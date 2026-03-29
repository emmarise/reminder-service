-- Seed data for testing all three modules
-- Run after schema.sql in Supabase SQL Editor

-- Trip: Hawaii (Apr 23 - Apr 30)
INSERT INTO trips (title, destination, start_date, end_date, tier_30, tier_7, tier_1) VALUES (
  'Hawaii Trip',
  'Lihue, Kauai (LIH)',
  '2026-04-23',
  '2026-04-30',
  '{"summary": "7-day Hawaii getaway on Kauai", "hotel": "Grand Hyatt Kauai, Poipu Beach"}'::jsonb,
  '{"flight_info": "UA 1234 SFO→LIH, dep 8:15 AM, arr 11:30 AM | UA 5678 LIH→SFO, dep 2:00 PM, arr 10:15 PM", "packing_list": "Sunscreen SPF 50, hiking shoes, snorkel gear, rain jacket, reef-safe sunscreen", "car_rental": "Enterprise, confirmation #XYZ789, pickup at LIH airport"}'::jsonb,
  '{"itinerary": "Day 1: Check-in 3 PM, dinner at Tidepools 7 PM\nDay 2: Na Pali Coast boat tour 8 AM\nDay 3: Waimea Canyon hike\nDay 4: Beach day at Poipu\nDay 5: Snorkeling at Tunnels Beach\nDay 6: Helicopter tour 10 AM\nDay 7: Check-out 11 AM, flight 2 PM", "checklist": "Passport, boarding pass (United app), hotel confirmation, travel insurance card, car rental confirmation"}'::jsonb
);

-- Recurring event: Tennis Class (Tue/Thu, Apr 7 - Apr 30)
INSERT INTO recurring_events (title, location, start_date, end_date, days, start_time, end_time) VALUES (
  'Tennis Class',
  'Bay Club, Court 3',
  '2026-04-07',
  '2026-04-30',
  '{tue,thu}',
  '18:00',
  '19:15'
);

-- Maintenance items
INSERT INTO maintenance_items (title, category, frequency_days, last_performed, priority) VALUES
  ('Replace Toothbrush', 'Personal Hygiene', 90, '2025-12-15', 'medium'),
  ('Replace Water Filter', 'Home', 180, '2025-10-01', 'high');
