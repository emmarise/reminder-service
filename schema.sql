-- Personal Reminder & Logistics Service
-- Run this in Supabase SQL Editor

-- Enums
CREATE TYPE event_status AS ENUM ('active', 'archived', 'cancelled');
CREATE TYPE maintenance_priority AS ENUM ('low', 'medium', 'high');
CREATE TYPE day_of_week AS ENUM ('mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun');

-- Trips: one-time countdown events with progressive reveal tiers
CREATE TABLE trips (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title       TEXT NOT NULL,
  destination TEXT,
  start_date  DATE NOT NULL,
  end_date    DATE NOT NULL,
  status      event_status DEFAULT 'active',
  tier_30     JSONB DEFAULT '{}'::jsonb,
  tier_7      JSONB DEFAULT '{}'::jsonb,
  tier_1      JSONB DEFAULT '{}'::jsonb,
  notes       TEXT,
  created_at  TIMESTAMPTZ DEFAULT now(),
  updated_at  TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_trips_active_upcoming
  ON trips (start_date)
  WHERE status = 'active';

-- Recurring events: bounded weekly schedules
CREATE TABLE recurring_events (
  id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title              TEXT NOT NULL,
  location           TEXT,
  start_date         DATE NOT NULL,
  end_date           DATE NOT NULL,
  days               day_of_week[] NOT NULL,
  start_time         TIME NOT NULL,
  end_time           TIME NOT NULL,
  status             event_status DEFAULT 'active',
  remind_day_before  BOOLEAN DEFAULT true,
  remind_morning_of  BOOLEAN DEFAULT true,
  notes              TEXT,
  created_at         TIMESTAMPTZ DEFAULT now(),
  updated_at         TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_recurring_active
  ON recurring_events (end_date)
  WHERE status = 'active';

-- Maintenance items: interval-based tracking
CREATE TABLE maintenance_items (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title           TEXT NOT NULL,
  category        TEXT,
  frequency_days  INT NOT NULL,
  last_performed  DATE NOT NULL,
  status          event_status DEFAULT 'active',
  priority        maintenance_priority DEFAULT 'medium',
  notes           TEXT,
  created_at      TIMESTAMPTZ DEFAULT now(),
  updated_at      TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_maintenance_active
  ON maintenance_items (last_performed)
  WHERE status = 'active';

-- Digest log: audit trail for sent emails
CREATE TABLE digest_log (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  sent_at           TIMESTAMPTZ DEFAULT now(),
  trip_count        INT DEFAULT 0,
  recurring_count   INT DEFAULT 0,
  maintenance_count INT DEFAULT 0,
  email_html        TEXT,
  success           BOOLEAN DEFAULT true,
  error_message     TEXT
);

-- Optional: convenience view for maintenance status
CREATE VIEW maintenance_status AS
SELECT
  *,
  (last_performed + (frequency_days || ' days')::interval)::date AS next_due,
  (last_performed + (frequency_days || ' days')::interval)::date - CURRENT_DATE AS days_until_due,
  CASE
    WHEN (last_performed + (frequency_days || ' days')::interval)::date <= CURRENT_DATE THEN true
    ELSE false
  END AS is_overdue
FROM maintenance_items
WHERE status = 'active'
ORDER BY days_until_due ASC;
