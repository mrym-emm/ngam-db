-- ============================================
-- DATA FLOW DEMONSTRATION SCRIPT
-- Shows how data flows through the system
-- ============================================

-- ============================================
-- STEP 1: SEED MINIMAL DATA
-- ============================================

-- Insert sample users
INSERT INTO users (id, full_name, email, avatar_url, is_verified, seller_rating, rating_count, total_listings, completed_deals, created_at) VALUES
('user-001', 'John Michael Smith', 'john@example.com', '/avatars/john.jpg', true, 4.8, 24, 12, 28, now()),
('user-002', 'Sarah Johnson', 'sarah@example.com', '/avatars/sarah.jpg', true, 4.9, 47, 23, 56, now()),
('user-003', 'Alex Chen', 'alex@example.com', '/avatars/alex.jpg', false, 4.2, 8, 5, 12, now());

-- Insert sample threads (communities)
INSERT INTO threads (id, title, description, image_url, category, tags, comments_count, views_count, upvotes_count, current_tokens, goal_tokens, contributions_count, is_pinned, is_hot, time_ago, online_users, total_users) VALUES
('thread-001', 'Pre-loved Apple', 'Latest smartphones, laptops, gaming gear and smart devices', 'https://images.unsplash.com/photo-1646621407385.jpg', 'apple-devices', ARRAY['apple', 'iphone', 'macbook'], 245, 18500, 892, 12400, 15000, 4200, true, true, '30m ago', 342, 8420),
('thread-002', 'Pre-loved Luxurious Brands', 'Shoes, bags, jewelry, watches and style accessories', 'https://images.unsplash.com/photo-1629439612315.jpg', 'fashion', ARRAY['fashion', 'accessories'], 156, 9800, 423, 3200, 8000, 1850, false, false, '1h ago', 89, 3420);

-- Insert sample listings
INSERT INTO listings (id, thread_id, user_id, title, description, price, location, timestamp, image_url, views_count, likes_count, category, expires_at, subscription_tier) VALUES
('listing-001', 'thread-001', 'user-001', 'iPhone 14 Pro - 256GB Space Black', 'Excellent condition, barely used. Comes with original box and charger.', 3400.00, 'Kuala Lumpur', '2 hours ago', '/images/iphone14.jpg', 45, 12, 'Electronics', now() + interval '5 days', 'basic'),
('listing-002', 'thread-001', 'user-002', 'MacBook Air M2 - Like New', 'Perfect for students and professionals. 8GB RAM, 256GB SSD.', 5100.00, 'Petaling Jaya', '4 hours ago', '/images/macbook.jpg', 67, 23, 'Electronics', now() + interval '29 days', 'pro');

-- Insert wanted listings (with budget instead of price)
INSERT INTO listings (id, thread_id, user_id, title, description, budget, location, timestamp, image_url, views_count, likes_count, category, expires_at, subscription_tier) VALUES
('listing-003', 'thread-001', 'user-003', 'Looking for: MacBook Pro M3 16-inch', 'Need for video editing work. Willing to pay good price for excellent condition.', 8500.00, 'Kuala Lumpur', '1 hour ago', '/images/wanted-macbook.jpg', 23, 5, 'Electronics', now() + interval '2 days', 'basic');

-- ============================================
-- STEP 2: DATA FLOW EXAMPLES
-- ============================================

-- FLOW 1: User browses threads (home page)
-- Query: Get all threads with their stats
SELECT 
  id, title, description, category, 
  views_count, upvotes_count, is_hot, is_pinned,
  online_users, total_users
FROM threads
ORDER BY is_pinned DESC, is_hot DESC, views_count DESC;

-- FLOW 2: User clicks on a thread to see listings
-- Query: Get all listings in a specific thread
SELECT 
  l.id, l.title, l.price, l.budget, l.location, l.timestamp,
  l.views_count, l.likes_count, l.expires_at,
  u.full_name as seller_name,
  u.seller_rating,
  u.is_verified as seller_verified
FROM listings l
JOIN users u ON l.user_id = u.id
WHERE l.thread_id = 'thread-001'
  AND l.expires_at > now()
ORDER BY l.created_at DESC;

-- FLOW 3: AI Matching System generates matches
-- Insert a match between a buyer and seller
INSERT INTO listing_matches (id, source_listing_id, matched_listing_id, match_score, match_quality, match_reasons, distance, price_compatible, location_compatible, category_compatible, status) VALUES
('match-001', 'listing-003', 'listing-002', 88, 'good', 
'[
  {"type": "category", "label": "Same category", "matched": true, "details": "Electronics"},
  {"type": "location", "label": "Nearby location", "matched": true, "details": "Petaling Jaya"},
  {"type": "price", "label": "Close to budget", "matched": true, "details": "Within budget range"}
]'::jsonb, 
'3km away', true, true, true, 'new');

-- FLOW 4: User views their matches
-- Query: Get all matches for a user's listing
SELECT 
  m.id, m.match_score, m.match_quality, m.distance, m.status,
  m.match_reasons,
  ml.title as matched_title,
  ml.price as matched_price,
  ml.location as matched_location,
  ml.image_url as matched_image,
  u.full_name as seller_name,
  u.seller_rating
FROM listing_matches m
JOIN listings ml ON m.matched_listing_id = ml.id
JOIN users u ON ml.user_id = u.id
WHERE m.source_listing_id = 'listing-003'
ORDER BY m.match_score DESC;

-- FLOW 5: User contacts seller (message)
-- Insert a message
INSERT INTO messages (id, sender_id, recipient_id, listing_id, content, product_info, is_read) VALUES
('msg-001', 'user-003', 'user-002', 'listing-002', 
'Hi! Is the MacBook Air still available? I saw it matched my requirements.',
'{"title": "MacBook Air M2 - Like New", "price": "RM 5,100", "image": "/images/macbook.jpg"}'::jsonb,
false);

-- FLOW 6: User checks their messages
-- Query: Get all conversations for a user
SELECT 
  m.id, m.content, m.is_read, m.created_at, m.product_info,
  u.full_name as other_user_name,
  u.avatar_url as other_user_avatar,
  u.is_verified as other_user_verified,
  CASE 
    WHEN m.sender_id = 'user-002' THEN 'received'
    ELSE 'sent'
  END as message_type
FROM messages m
JOIN users u ON (
  CASE 
    WHEN m.sender_id = 'user-002' THEN m.sender_id = u.id
    ELSE m.recipient_id = u.id
  END
)
WHERE m.sender_id = 'user-002' OR m.recipient_id = 'user-002'
ORDER BY m.created_at DESC;

-- FLOW 7: User asks question on listing (FAQ)
-- Insert question
INSERT INTO listing_faqs (id, listing_id, user_id, question, description, is_answered_by_poster) VALUES
('faq-001', 'listing-002', 'user-003', 'Does it come with original charger?', 'Want to make sure all accessories are included', false);

-- Seller answers the question
INSERT INTO faq_answers (id, faq_id, parent_answer_id, user_id, user_name, text, is_accepted, likes_count, dislikes_count) VALUES
('ans-001', 'faq-001', NULL, 'user-002', 'Sarah Johnson', 'Yes! Comes with original charger, box, and all accessories. Everything is included.', true, 12, 0);

-- Another user replies to the answer
INSERT INTO faq_answers (id, faq_id, parent_answer_id, user_id, user_name, text, is_accepted, likes_count, dislikes_count) VALUES
('ans-002', 'faq-001', 'ans-001', 'user-001', 'John Michael Smith', 'Great to know! Original accessories always add value.', false, 5, 0);

-- FLOW 8: Get FAQ with nested replies for listing page
-- Query: Get all FAQs with answers and nested replies
WITH RECURSIVE faq_tree AS (
  -- Get all questions
  SELECT 
    f.id as faq_id,
    f.question,
    f.description as question_description,
    f.is_answered_by_poster,
    a.id as answer_id,
    a.parent_answer_id,
    a.user_name,
    a.text,
    a.is_accepted,
    a.likes_count,
    a.dislikes_count,
    1 as level
  FROM listing_faqs f
  LEFT JOIN faq_answers a ON f.id = a.faq_id AND a.parent_answer_id IS NULL
  WHERE f.listing_id = 'listing-002'
  
  UNION ALL
  
  -- Get nested replies
  SELECT 
    ft.faq_id,
    ft.question,
    ft.question_description,
    ft.is_answered_by_poster,
    a.id,
    a.parent_answer_id,
    a.user_name,
    a.text,
    a.is_accepted,
    a.likes_count,
    a.dislikes_count,
    ft.level + 1
  FROM faq_tree ft
  JOIN faq_answers a ON ft.answer_id = a.parent_answer_id
)
SELECT * FROM faq_tree ORDER BY faq_id, level, answer_id;

-- FLOW 9: AI Chat Session
-- User starts AI chat
INSERT INTO ai_chat_sessions (id, user_id, title) VALUES
(1, 'user-001', 'iPhone 14 Pro price comparison');

-- User sends message
INSERT INTO ai_chat_messages (id, session_id, user_id, role, content, timestamp) VALUES
('chat-msg-001', 1, 'user-001', 'user', 'Compare iPhone 14 Pro prices', now());

-- AI responds with tool call
INSERT INTO ai_chat_messages (id, session_id, user_id, role, content, tool_calls, timestamp) VALUES
('chat-msg-002', 1, 'user-001', 'assistant', 'Let me search for iPhone 14 Pro listings...', 
'[{"name": "search_listings", "status": "completed", "result": "Found 12 listings"}]'::jsonb, 
now());

-- AI provides results
INSERT INTO ai_chat_messages (id, session_id, user_id, role, content, timestamp) VALUES
('chat-msg-003', 1, 'user-001', 'assistant', 'Found several options. The best deal is RM3,400 from a verified seller in Kuala Lumpur.', now());

-- FLOW 10: Get user's AI chat history
-- Query: Get all chat sessions for sidebar
SELECT 
  s.id, s.title, 
  COUNT(m.id) as message_count,
  MAX(m.timestamp) as last_message_at,
  CASE 
    WHEN MAX(m.timestamp) > now() - interval '1 hour' THEN 'minutes ago'
    WHEN MAX(m.timestamp) > now() - interval '1 day' THEN 'hours ago'
    ELSE 'days ago'
  END as time_ago
FROM ai_chat_sessions s
LEFT JOIN ai_chat_messages m ON s.id = m.session_id
WHERE s.user_id = 'user-001'
GROUP BY s.id, s.title
ORDER BY MAX(m.timestamp) DESC;

-- FLOW 11: Track user activity
-- Insert activities
INSERT INTO activities (user_id, activity_type, message, date) VALUES
('user-001', 'sale', 'Sold an item: iPhone 14 Pro', '2 hours ago'),
('user-002', 'purchase', 'Bought an item: Wireless Headphones', '1 day ago'),
('user-003', 'achievement', 'Unlocked achievement: First Listing', '3 days ago');

-- Query: Get user activity feed
SELECT 
  activity_type, message, date
FROM activities
WHERE user_id = 'user-001'
ORDER BY created_at DESC
LIMIT 10;

-- FLOW 12: Track achievements
-- Insert achievements
INSERT INTO achievements (id, user_id, label, description, icon, unlocked, unlocked_at) VALUES
('achievement-001', 'user-001', 'First Sale', 'Complete your first successful sale', 'Trophy', true, 'Jan 15, 2024'),
('achievement-002', 'user-001', 'Trusted Seller', 'Achieve a 4.5+ rating with 10+ reviews', 'Star', true, 'Feb 20, 2024'),
('achievement-003', 'user-001', 'Community Helper', 'Help 10 users in the forums', 'Users', false, NULL);

-- Query: Get user's unlocked achievements
SELECT 
  label, description, icon, unlocked_at
FROM achievements
WHERE user_id = 'user-001' AND unlocked = true
ORDER BY created_at DESC;

-- Query: Get achievement progress
SELECT 
  COUNT(*) FILTER (WHERE unlocked = true) as unlocked_count,
  COUNT(*) as total_count,
  ROUND(COUNT(*) FILTER (WHERE unlocked = true)::numeric / COUNT(*)::numeric * 100, 2) as completion_percentage
FROM achievements
WHERE user_id = 'user-001';

-- ============================================
-- STEP 3: COMMON DASHBOARD QUERIES
-- ============================================

-- User Dashboard: Get overview stats
SELECT 
  u.full_name,
  u.seller_rating,
  u.total_listings,
  u.completed_deals,
  COUNT(DISTINCT l.id) as active_listings,
  COUNT(DISTINCT m.id) as pending_matches,
  COUNT(DISTINCT msg.id) FILTER (WHERE msg.is_read = false) as unread_messages
FROM users u
LEFT JOIN listings l ON u.id = l.user_id AND l.expires_at > now()
LEFT JOIN listing_matches m ON l.id = m.source_listing_id AND m.status = 'new'
LEFT JOIN messages msg ON u.id = msg.recipient_id AND msg.is_read = false
WHERE u.id = 'user-001'
GROUP BY u.id, u.full_name, u.seller_rating, u.total_listings, u.completed_deals;

-- Trending Threads: Get hot communities
SELECT 
  id, title, description, category,
  views_count, upvotes_count, online_users,
  is_hot, is_pinned
FROM threads
WHERE is_hot = true OR is_pinned = true
ORDER BY is_pinned DESC, upvotes_count DESC
LIMIT 5;

-- Recent Listings: Get latest items in category
SELECT 
  l.id, l.title, l.price, l.location, l.timestamp,
  u.full_name as seller_name,
  u.seller_rating,
  u.is_verified
FROM listings l
JOIN users u ON l.user_id = u.id
WHERE l.thread_id = 'thread-001' 
  AND l.expires_at > now()
ORDER BY l.created_at DESC
LIMIT 10;

-- ============================================
-- STEP 4: ANALYTICS QUERIES
-- ============================================

-- Most active sellers
SELECT 
  u.full_name,
  u.seller_rating,
  COUNT(l.id) as total_listings,
  AVG(l.views_count) as avg_views,
  SUM(l.likes_count) as total_likes
FROM users u
JOIN listings l ON u.id = l.user_id
GROUP BY u.id, u.full_name, u.seller_rating
ORDER BY total_listings DESC
LIMIT 10;

-- Popular categories
SELECT 
  category,
  COUNT(*) as listing_count,
  AVG(price) as avg_price,
  SUM(views_count) as total_views
FROM listings
WHERE expires_at > now()
GROUP BY category
ORDER BY listing_count DESC;

-- Match success rate
SELECT 
  status,
  COUNT(*) as count,
  ROUND(COUNT(*)::numeric / SUM(COUNT(*)) OVER () * 100, 2) as percentage
FROM listing_matches
GROUP BY status;
