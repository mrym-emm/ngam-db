-- ============================================
-- NGAM-JE Seed Data
-- Insert Statements
-- ============================================

-- Users (Complete - 2 users)
INSERT INTO users (id, name, email, bio, location, avatar_url, joined_date) VALUES
('user-1', 'Fitri', 'fitri@example.com', 'Love finding great deals on tech and collectibles!', 'Kuala Lumpur', '/avatars/fitri.jpg', '2024-01-15 10:00:00'),
('user-2', 'Sani', 'sani@example.com', 'Passionate gamer and tech enthusiast. Always looking for the latest gear!', 'Petaling Jaya', '/avatars/sani.jpg', '2024-01-20 14:30:00');

-- ============================================

-- Listings (Sample - 3 out of 72)
-- NOTE: Import remaining 69 listings from CSV later
INSERT INTO listings (id, user_id, title, description, price, category, condition, status, listing_type, image_url, is_matched, time_posted) VALUES
(1, 'user-1', 'iPhone 14 Pro 256GB', 'Excellent condition, barely used. Comes with original box and accessories.', 3500.00, 'Electronics', 'Like New', 'active', 'sell', '/images/iphone14pro.jpg', FALSE, '2024-10-27 08:30:00'),
(2, 'user-2', 'MacBook Air M2 2023', '13-inch, 8GB RAM, 256GB SSD. Perfect for students and professionals.', 4200.00, 'Electronics', 'Excellent', 'active', 'sell', '/images/macbook-air.jpg', TRUE, '2024-10-26 15:20:00'),
(3, 'user-1', 'Looking for Gaming Laptop', 'Need a gaming laptop with RTX 4060 or better. Budget up to RM5000.', 5000.00, 'Electronics', NULL, 'active', 'buy', NULL, FALSE, '2024-10-25 11:45:00');

-- To import remaining listings later:
-- COPY listings(id, user_id, title, description, price, category, condition, status, listing_type, image_url, is_matched, time_posted)
-- FROM '/path/to/listings.csv' DELIMITER ',' CSV HEADER;

-- ============================================

-- Tags (Sample - 3 tags)
-- NOTE: Import remaining tags from CSV later
INSERT INTO tags (listing_id, tag_name) VALUES
(1, 'electronics'),
(1, 'smartphone'),
(1, 'apple');

-- To import remaining tags later:
-- COPY tags(listing_id, tag_name)
-- FROM '/path/to/tags.csv' DELIMITER ',' CSV HEADER;

-- ============================================

-- Matches (Complete - 3 matched listings for testing)
INSERT INTO matches (buy_listing_id, sell_listing_id, buyer_id, seller_id, match_score, status, matched_at) VALUES
(10, 2, 'user-1', 'user-2', 95.50, 'pending', '2024-10-27 09:15:00'),
(12, 4, 'user-1', 'user-2', 88.25, 'pending', '2024-10-26 16:45:00'),
(15, 6, 'user-1', 'user-2', 92.00, 'pending', '2024-10-25 13:30:00');

-- ============================================

-- Threads (Sample - 3 out of many)
-- NOTE: Import remaining threads from CSV later
INSERT INTO threads (id, listing_id, participant_1_id, participant_2_id, last_message, last_message_time, unread_count) VALUES
('thread-1', 1, 'user-1', 'user-2', 'Is the iPhone still available?', '2024-10-27 10:30:00', 1),
('thread-2', 2, 'user-2', 'user-1', 'Can we meet tomorrow?', '2024-10-26 18:00:00', 0),
('thread-3', 3, 'user-1', 'user-2', 'I have a laptop that might interest you', '2024-10-25 14:20:00', 2);

-- To import remaining threads later:
-- COPY threads(id, listing_id, participant_1_id, participant_2_id, last_message, last_message_time, unread_count)
-- FROM '/path/to/threads.csv' DELIMITER ',' CSV HEADER;

-- ============================================

-- Messages (Sample - 5 messages across threads)
-- NOTE: Import remaining messages from CSV later
INSERT INTO messages (thread_id, sender_id, content, is_read, sent_at) VALUES
('thread-1', 'user-2', 'Is the iPhone still available?', TRUE, '2024-10-27 10:30:00'),
('thread-1', 'user-1', 'Yes it is! Are you interested?', TRUE, '2024-10-27 10:35:00'),
('thread-2', 'user-1', 'Can we meet tomorrow?', TRUE, '2024-10-26 18:00:00'),
('thread-2', 'user-2', 'Sure, what time works for you?', TRUE, '2024-10-26 18:15:00'),
('thread-3', 'user-2', 'I have a laptop that might interest you', FALSE, '2024-10-25 14:20:00');

-- To import remaining messages later:
-- COPY messages(thread_id, sender_id, content, is_read, sent_at)
-- FROM '/path/to/messages.csv' DELIMITER ',' CSV HEADER;

-- ============================================

-- Achievements (Complete - 2 achievements)
INSERT INTO achievements (id, user_id, title, description, icon, earned_date) VALUES
('ach-1', 'user-1', 'First Listing', 'Created your first listing on the platform', 'trophy', '2024-01-15 11:00:00'),
('ach-2', 'user-2', 'Early Adopter', 'Joined the platform in its first month', 'star', '2024-01-20 15:00:00');

-- ============================================

-- Activities (Complete - 4 sample activities)
INSERT INTO activities (user_id, activity_type, title, description, related_listing_id, timestamp) VALUES
('user-1', 'listing_created', 'Listed iPhone 14 Pro', 'You created a new listing for iPhone 14 Pro 256GB', 1, '2024-10-27 08:30:00'),
('user-2', 'listing_created', 'Listed MacBook Air', 'You created a new listing for MacBook Air M2 2023', 2, '2024-10-26 15:20:00'),
('user-1', 'match_found', 'Match Found!', 'Your buy request matched with a MacBook Air listing', 2, '2024-10-27 09:15:00'),
('user-2', 'offer_received', 'New Offer', 'Someone is interested in your MacBook Air', 2, '2024-10-27 10:00:00');

-- ============================================

-- FAQs (Item-Specific - Sample data)
INSERT INTO faqs (listing_id, user_id, question, answer, is_answered, asked_at, answered_at) VALUES
(1, 'user-2', 'Does the iPhone come with the original charger?', 'Yes, it comes with the original Apple 20W USB-C charger and cable!', TRUE, '2024-10-27 09:00:00', '2024-10-27 09:15:00'),
(1, 'user-2', 'What is the battery health percentage?', 'Battery health is at 98%', TRUE, '2024-10-27 09:30:00', '2024-10-27 09:45:00'),
(2, 'user-1', 'Has this MacBook been repaired before?', 'No, never repaired. Still under AppleCare warranty until June 2025.', TRUE, '2024-10-26 16:00:00', '2024-10-26 16:30:00'),
(3, 'user-2', 'Would you consider a laptop with RTX 4050 instead?', NULL, FALSE, '2024-10-25 12:00:00', NULL);

-- ============================================

-- Chat History (Complete - 2 chat entries)
INSERT INTO chat_history (id, user_id, other_user_id, last_message, timestamp, is_read, avatar_url) VALUES
('chat-1', 'user-1', 'user-2', 'Can we meet tomorrow?', '2024-10-26 18:00:00', TRUE, '/avatars/sani.jpg'),
('chat-2', 'user-2', 'user-1', 'Yes it is! Are you interested?', '2024-10-27 10:35:00', FALSE, '/avatars/fitri.jpg');

-- ============================================
-- End of Seed Data
-- ============================================
