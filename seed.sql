-- Seed data for testing all three modules
-- Run after schema.sql in Supabase SQL Editor

-- Trip: Hawaii (Apr 23 - Apr 30) — Kauai + Oahu multi-island
INSERT INTO trips (title, destination, start_date, end_date, tier_30, tier_7, tier_1) VALUES (
  'Hawaii Trip',
  'Kauai + Oahu (LIH/HNL)',
  '2026-04-23',
  '2026-04-30',
  '{"summary": "Kauai (5 nights) + Oahu (2 nights) multi-island trip", "hotel": "Kauai Shores Hotel (3n, 4/23-4/26) > Grand Hyatt Kauai (2n, 4/26-4/28) > Airbnb Honolulu (2n, 4/28-4/30)"}'::jsonb,
  '{"flight_info": "DL345 SEA-LIH, Thu Apr 23, 2:30 PM-5:40 PM (Delta) | AS1134 LIH-HNL, Tue Apr 28, 5:10 PM-5:48 PM (Alaska) | DL440 HNL-SEA, Thu Apr 30, 10:45 PM-7:35 AM+1 (Delta)", "packing_list": "墨镜, 防晒帽, 牙刷, 牙膏, 牙线, camera, 隐形眼镜, 充电器, 直板夹, 拖鞋"}'::jsonb,
  '{"checklist": "Boarding pass (Delta app + Alaska app), Kauai Shores confirmation, Grand Hyatt confirmation, Airbnb confirmation (HM4NHBYNJJ), Shangri La Tour tickets ($96.76)"}'::jsonb
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
INSERT INTO maintenance_items (title, category, frequency_days, last_performed, priority, notes) VALUES
  ('Replace Toothbrush', 'Personal Hygiene', 90, '2025-12-23', 'medium', NULL),
  ('Replace Water Filter', 'Home', 90, '2026-03-29', 'high', NULL),
  ('Period', 'Personal Health', 27, '2026-04-04', 'medium', 'duration:5'),
  ('Oncall Rotation', 'Work', 35, '2026-03-31', 'high', NULL);
