-- ============================================
-- SCENARIO: 2 USERS INTERACTION FLOW
-- User 1 (GamerGirl2024) = SELLER
-- User 2 (TechHunter) = BUYER
-- ============================================

-- ============================================
-- STEP 1: USERS JOIN THE THREAD
-- ============================================
INSERT INTO thread_members (user_id, thread_id, is_favorite, notification_enabled) VALUES
(1, 'apple-devices', true, true),   -- Seller joins
(2, 'apple-devices', true, true);   -- Buyer joins

-- ============================================
-- STEP 2: AI CREATES A MATCH
-- (System finds that buyer's WTB matches seller's listing)
-- ============================================
INSERT INTO listing_matches (
  source_listing_id, matched_listing_id,
  match_score, match_quality, match_reasons,
  distance_km, price_compatible, location_compatible, category_compatible,
  status
) VALUES
('elec-002', 'elec-008', 92, 'excellent',
 '[
   {"type":"product","label":"Apple products","matched":true,"details":"Both interested in Apple ecosystem"},
   {"type":"price","label":"Within budget","matched":true,"details":"RM 850 vs RM 4,500 budget"},
   {"type":"location","label":"Nearby","matched":true,"details":"8km apart (KL to PJ)"}
 ]'::jsonb,
 8.0, true, true, true, 'pending');

-- ============================================
-- STEP 3: BUYER VIEWS AND SHOWS INTEREST
-- ============================================
INSERT INTO match_interactions (user_id, match_id, action_type, metadata) VALUES
(2, 1, 'viewed', '{"viewed_at":"2025-10-20T10:30:00Z","device":"mobile"}'::jsonb),
(2, 1, 'interested', '{"contacted_at":"2025-10-20T10:35:00Z"}'::jsonb);

-- ============================================
-- STEP 4: MUTUAL MATCH CREATED
-- (Both users interested in each other's listings)
-- ============================================
INSERT INTO mutual_matches (
  buyer_listing_id, seller_listing_id,
  buyer_user_id, seller_user_id,
  buyer_interested, seller_interested,
  buyer_interested_at, seller_interested_at,
  is_mutual, matched_at,
  match_score, match_quality,
  conversation_started, conversation_started_at,
  status, initiated_by
) VALUES
('elec-002', 'elec-008',
 2, 1,
 true, true,
 NOW() - INTERVAL '2 hours', NOW() - INTERVAL '1 hour',
 true, NOW() - INTERVAL '1 hour',
 92, 'excellent',
 true, NOW() - INTERVAL '50 minutes',
 'negotiating', 2);

-- ============================================
-- STEP 5: CONVERSATION VIA MESSAGES
-- ============================================
INSERT INTO messages (sender_id, recipient_id, listing_id, mutual_match_id, content, is_read) VALUES
-- Michael initiates
(2, 1, 'elec-008', 1,
 'Hi! I saw your Apple Watch SE. Is it still available?',
 true),

-- Sarah responds
(1, 2, 'elec-008', 1,
 'Yes it is! Very interested? It''s practically brand new.',
 true),

-- Michael asks details
(2, 1, 'elec-008', 1,
 'That''s great! What''s the battery health like? Does it come with the original charger?',
 true),

-- Sarah provides info
(1, 2, 'elec-008', 1,
 'Battery health is at 100%! Yes, comes with original charger and 2 sport bands. All original packaging too.',
 true),

-- Michael negotiates
(2, 1, 'elec-008', 1,
 'Sounds perfect! I''m in PJ. Can we meet halfway? Maybe Bangsar this weekend?',
 true),

-- Sarah agrees
(1, 2, 'elec-008', 1,
 'Saturday 2pm works for me. Bangsar Village? I''ll bring all accessories.',
 false);

-- ============================================
-- STEP 6: PUBLIC FAQs ON THE LISTING
-- ============================================
INSERT INTO listing_faqs (listing_id, user_id, parent_id, type, content, description, is_accepted, upvotes_count, downvotes_count) VALUES
-- Question 1: Battery (from buyer)
('elec-008', 2, NULL, 'question',
 'What''s the current battery health percentage?',
 'Want to make sure it''s above 95%',
 false, 5, 0),

-- Sarah's answer (accepted as best answer)
('elec-008', 1, 1, 'answer',
 'Battery health is at 100%! The watch is only 3 months old, barely worn.',
 NULL,
 true, 12, 0),

-- Question 2: Warranty
('elec-008', 2, NULL, 'question',
 'Is there any warranty remaining?',
 'Wondering about Apple warranty coverage',
 false, 3, 0),

-- Sarah's answer
('elec-008', 1, 3, 'answer',
 'Yes! Still under Apple warranty until March 2025 (5 months left). I can provide the original receipt.',
 NULL,
 true, 8, 0),

-- Follow-up
('elec-008', 2, 4, 'reply',
 'Perfect! Thanks for confirming.',
 NULL,
 false, 2, 0);

-- ============================================
-- STEP 7: AI CHAT SESSION (Buyer uses AI)
-- ============================================
INSERT INTO ai_chat_sessions (user_id, title, mode) VALUES
(2, 'Finding Apple Watch deals', 'reactive');

INSERT INTO ai_chat_messages (session_id, user_id, role, content, metadata) VALUES
-- Michael asks AI
(1, 2, 'user',
 'Can you help me find Apple Watch deals under RM 1000 in KL area?',
 NULL),

-- AI responds with match
(1, 2, 'assistant',
 'I found 1 excellent match for you! 🎯

**Apple Watch SE (2nd Gen) - RM 850**
- Seller: GamerGirl2024 (⭐ 4.85 rating, Verified)
- Location: Kuala Lumpur (8km from you)
- Condition: Like new, 3 months old
- Includes: Extra sport band + original packaging
- Match Score: 92% (Excellent!)

This listing matches your budget and location perfectly!

Would you like me to:
1. Send an interest message to the seller?
2. Show you the seller''s reviews?
3. Set up a meeting?',
 '{"sources":["elec-008"],"match_id":1}'::jsonb),

-- Michael responds
(1, 2, 'user',
 'Yes! Please send an interest message.',
 NULL),

-- AI takes action
(1, 2, 'assistant',
 '✅ **Message sent successfully!**

I''ve contacted GamerGirl2024 about the Apple Watch. 

**What I did:**
- Created a mutual match request
- Sent your introduction message
- Added to your "Interested Matches" tab

**Seller Info:**
- Response time: Usually within 1 hour
- Rating: 4.85/5.00 (23 successful sales)
- Last active: 30 minutes ago

You''ll get a notification when they reply. Good luck! 🎉',
 '{"action":"sent_interest","match_id":1,"mutual_match_id":1}'::jsonb);

-- ============================================
-- STEP 8: AI ACTIONS LOG
-- ============================================
INSERT INTO ai_actions (session_id, message_id, user_id, action_type, action_input, action_output, status, started_at, completed_at) VALUES
-- Action 1: Search listings
(1, 2, 2, 'search_listings',
 '{"query":"apple watch","max_price":1000,"location":"kuala lumpur"}'::jsonb,
 '{"results":[{"listing_id":"elec-008","score":92}],"total_found":1}'::jsonb,
 'completed', NOW() - INTERVAL '30 minutes', NOW() - INTERVAL '29 minutes'),

-- Action 2: Send interest
(1, 4, 2, 'send_interest_message',
 '{"listing_id":"elec-008","match_id":1}'::jsonb,
 '{"mutual_match_id":1,"message_sent":true}'::jsonb,
 'completed', NOW() - INTERVAL '25 minutes', NOW() - INTERVAL '24 minutes');

-- ============================================
-- STEP 9: THREAD BOOST CONTRIBUTIONS
-- ============================================
INSERT INTO thread_boost_contributions (user_id, thread_id, amount, contributed_at) VALUES
(1, 'apple-devices', 2000, NOW() - INTERVAL '5 days'),
(2, 'apple-devices', 1500, NOW() - INTERVAL '3 days');

-- Update thread boost
UPDATE threads 
SET boost_points = 3500, boost_level = 1
WHERE id = 'apple-devices';

-- ============================================
-- VERIFICATION: Show the Complete Flow
-- ============================================

SELECT '=== 👥 USERS ===' as section;
SELECT id, username, full_name, location, is_verified, seller_rating 
FROM users WHERE id IN (1,2)
ORDER BY id;

SELECT '' as blank;

SELECT '=== 📝 THEIR LISTINGS ===' as section;
SELECT id, user_id, LEFT(title, 50) as title, listing_type, price 
FROM listings WHERE id IN ('elec-002', 'elec-008')
ORDER BY listing_type DESC;

SELECT '' as blank;

SELECT '=== 🤝 THE MATCH ===' as section;
SELECT 
  lm.id,
  lm.source_listing_id as buyer_listing,
  lm.matched_listing_id as seller_listing,
  lm.match_score,
  lm.match_quality,
  lm.status
FROM listing_matches lm
WHERE lm.id = 1;

SELECT '' as blank;

SELECT '=== 💚 MUTUAL MATCH ===' as section;
SELECT 
  mm.id,
  u1.username as buyer,
  u2.username as seller,
  mm.is_mutual,
  mm.conversation_started,
  mm.status
FROM mutual_matches mm
JOIN users u1 ON mm.buyer_user_id = u1.id
JOIN users u2 ON mm.seller_user_id = u2.id
WHERE mm.id = 1;

SELECT '' as blank;

SELECT '=== 💬 MESSAGES ===' as section;
SELECT 
  m.id,
  u.username as from_user,
  LEFT(m.content, 60) as message,
  m.is_read,
  m.created_at
FROM messages m
JOIN users u ON m.sender_id = u.id
WHERE m.mutual_match_id = 1
ORDER BY m.created_at;

SELECT '' as blank;

SELECT '=== ❓ PUBLIC FAQs ===' as section;
SELECT 
  f.id,
  u.username as user,
  f.type,
  LEFT(f.content, 50) as content,
  f.upvotes_count
FROM listing_faqs f
JOIN users u ON f.user_id = u.id
WHERE f.listing_id = 'elec-008'
ORDER BY f.parent_id NULLS FIRST, f.id;

SELECT '' as blank;

SELECT '=== 🤖 AI CHAT ===' as section;
SELECT 
  m.id,
  m.role,
  LEFT(m.content, 80) as preview
FROM ai_chat_messages m
WHERE m.session_id = 1
ORDER BY m.created_at;

SELECT '' as blank;

SELECT '=== 🚀 AI ACTIONS ===' as section;
SELECT 
  a.id,
  a.action_type,
  a.status,
  a.completed_at
FROM ai_actions a
WHERE a.session_id = 1
ORDER BY a.id;

SELECT '' as blank;

SELECT '=== ✅ FLOW COMPLETE! ===' as summary;
