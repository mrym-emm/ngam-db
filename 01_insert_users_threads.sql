-- ============================================
-- SEED DATA: USERS + BOOST + THREADS
-- ============================================

-- 1. BOOST CONFIG
INSERT INTO boost_levels_config (level, points_required, perks_granted, description) VALUES
(0, 0, '{"listing_duration": {"for_sale": 3, "want_to_buy": 7}, "max_listings": 5}'::jsonb, 'Basic tier'),
(1, 1000, '{"listing_duration": {"for_sale": 7, "want_to_buy": 14}, "max_listings": 15}'::jsonb, 'Bronze tier'),
(2, 5000, '{"listing_duration": {"for_sale": 14, "want_to_buy": 30}, "max_listings": 50}'::jsonb, 'Silver tier');

-- 2. INSERT 5 USERS (REQUIRED FOR LISTINGS!)
INSERT INTO users (id, email, username, full_name, location, is_verified, is_premium, tokens_balance, seller_rating, total_sales, total_purchases) VALUES
(1, 'gamergirl@example.com', 'GamerGirl2024', 'Sarah Chen', 'Kuala Lumpur', true, true, 5000, 4.85, 23, 15),
(2, 'techhunter@example.com', 'TechHunter', 'Michael Tan', 'Petaling Jaya', false, false, 1500, 4.20, 8, 12),
(3, 'hoopsmaster@example.com', 'HoopsMaster', 'David Wong', 'Johor Bahru', false, false, 300, 3.95, 5, 3),
(4, 'sneakerhead@example.com', 'SneakerHead99', 'Alex Lim', 'Shah Alam', true, false, 2200, 4.60, 18, 22),
(5, 'audiophile@example.com', 'AudioPhile', 'Jessica Lee', 'Subang Jaya', true, true, 3800, 4.95, 31, 19);

SELECT setval('users_id_seq', 5);

-- 3. INSERT 18 THREADS
INSERT INTO threads (
  id, title, description, image_url, category,
  views_count, upvotes_count,
  current_tokens, goal_tokens, tags,
  is_pinned, is_hot, contributions_count,
  boost_level, boost_points
) VALUES
('apple-devices', 'Pre-loved Apple', 
 'Latest smartphones, laptops, gaming gear and smart devices',
 'https://images.unsplash.com/photo-1646621407385-528a18fbe004?q=80&w=2070',
 'electronics', 18500, 892, 12400, 15000,
 ARRAY['apple', 'iphone', 'macbook', 'trending'],
 true, true, 4200, 0, 0),

('gaming', 'Nintendo Lovers',
 'Everything Nintendo Pre-loved',
 'https://images.unsplash.com/photo-1567094764148-bb14c3e6f14c?q=80&w=2070',
 'gaming', 22100, 1205, 8900, 12000,
 ARRAY['gaming', 'esports', 'console'],
 false, true, 3800, 0, 0),

('fashion', 'Pre-loved Luxurious Brands',
 'Shoes, bags, jewelry, watches and style accessories',
 'https://images.unsplash.com/photo-1629439612315-b69e9236c8e1?w=1200',
 'fashion', 9800, 423, 3200, 8000,
 ARRAY['fashion', 'accessories', 'style'],
 false, false, 1850, 0, 0),

('furniture', 'IKEA Pre-Loved',
 'Furniture, decor, appliances and home improvement swap from IKEA',
 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?q=80&w=958',
 'furniture', 5600, 234, 6500, 6500,
 ARRAY['furniture', 'home', 'decor'],
 true, false, 2100, 0, 0),

('books', 'Asian Literature',
 'Swaps asian literature!',
 'https://images.unsplash.com/photo-1531988042231-d39a9cc12a9a?q=80&w=1170',
 'books', 3400, 178, 1800, 5000,
 ARRAY['books', 'media', 'education'],
 false, false, 920, 0, 0),

('sport', 'GymBros Exchange',
 'Exercise equipment, sportswear, outdoor gear and wellness products',
 'https://images.unsplash.com/photo-1591311630200-ffa9120a540f?q=80&w=1110',
 'sport', 7200, 356, 4100, 10000,
 ARRAY['sports', 'fitness', 'wellness'],
 false, false, 1650, 0, 0),

('ai-tools', 'AI Tools & Software Development',
 'Discussing the latest in machine learning, generative AI, and coding frameworks.',
 'https://images.unsplash.com/photo-1712002641088-9d76f9080889?w=1200',
 'technology', 18500, 892, 12400, 15000,
 ARRAY['ai', 'software', 'coding', 'trending'],
 true, true, 4200, 0, 0),

('fashion-sneakers', 'Collectible Sneakers & Streetwear Drops',
 'Talk about new releases, resale market, and styling advice for streetwear and sneakers.',
 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=1200',
 'fashion', 22100, 1205, 8900, 12000,
 ARRAY['fashion', 'sneakers', 'streetwear', 'drops'],
 false, true, 3800, 0, 0),

('gaming-mmorpg', 'MMORPGs & Online Multiplayer Games',
 'Guides, discussions, and news for massive online role-playing games and co-op titles.',
 'https://images.unsplash.com/photo-1616588589676-62b3bd4ff6d2?q=80&w=1032',
 'gaming', 9800, 423, 3200, 8000,
 ARRAY['gaming', 'mmorpg', 'online', 'multiplayer'],
 false, false, 1850, 0, 0),

('furniture-vintage', 'Vintage & Mid-Century Modern Furniture',
 'Collecting, restoring, and finding unique pieces of vintage and retro home decor.',
 'https://images.unsplash.com/photo-1715249891485-4b8e66b584dc?w=1200',
 'furniture', 5600, 234, 6500, 6500,
 ARRAY['furniture', 'vintage', 'decor', 'design'],
 true, false, 2100, 0, 0),

('books-productivity', 'Self-Help & Productivity Items',
 'Discussing strategies for personal growth, habit building, and maximizing daily output.',
 'https://images.unsplash.com/photo-1598301257942-e6bde1d2149b?w=1200',
 'books', 3400, 178, 1800, 5000,
 ARRAY['books', 'self-help', 'productivity', 'wellness'],
 false, false, 920, 0, 0),

('sport-running', 'Running & Marathon Equipments',
 'Tips, gear reviews, and motivation for runners of all levels, from 5K to marathon distances.',
 'https://images.unsplash.com/photo-1597892657493-6847b9640bac?w=1200',
 'sport', 7200, 356, 4100, 10000,
 ARRAY['sports', 'running', 'marathon', 'fitness'],
 false, false, 1650, 0, 0),

('furniture-diy', 'DIY & Home Renovation Thread',
 'Places to share your DIY items.',
 'https://images.unsplash.com/photo-1603227809135-512eb5c03f43?w=1200',
 'furniture', 6100, 310, 5400, 7500,
 ARRAY['diy', 'home', 'tools', 'renovation'],
 false, false, 1900, 0, 0),

('pc-building', 'High-End PC Building & Overclocking',
 'Discussions on custom PC builds, components, and performance tuning.',
 'https://images.unsplash.com/photo-1587202372775-e229f172b9d7?w=1200',
 'technology', 35000, 2150, 18500, 20000,
 ARRAY['pc-building', 'gaming', 'overclocking', 'hardware'],
 true, true, 5500, 0, 0),

('fashion-sustainable', 'Sustainable & Ethical Facial Brands',
 'Sell or buy sustainable facial brands.',
 'https://images.unsplash.com/photo-1634217620030-403525c4b9de?w=1200',
 'fashion', 8400, 560, 2500, 6000,
 ARRAY['fashion', 'sustainability', 'eco-friendly'],
 true, false, 1100, 0, 0),

('sport-outdoor', 'Outdoor Adventures & Hiking Gear',
 'Reviews and recommendations for tents, packs, boots, and trail guides.',
 'https://plus.unsplash.com/premium_photo-1663127114654-37b84c0ed3ed?q=80&w=1150',
 'sport', 14200, 780, 7800, 10000,
 ARRAY['sports', 'outdoor', 'travel', 'gear'],
 false, true, 3200, 0, 0),

('books-fantasy', 'Fantasy Book Club: High Fantasy',
 'Discussing the latest and greatest in epic high fantasy novels and series.',
 'https://images.unsplash.com/photo-1540650659171-c24a35e9cd54?q=80&w=688',
 'books', 8100, 490, 3500, 5500,
 ARRAY['books', 'fantasy', 'literature'],
 false, false, 1550, 0, 0),

('smart-home', 'Best Smart Home Automation Hubs',
 'Comparing Google Home, Amazon Echo, Apple HomeKit, and custom solutions.',
 'https://plus.unsplash.com/premium_photo-1758492123932-31c78cdbabe2?q=80&w=772',
 'technology', 19300, 1100, 9200, 11000,
 ARRAY['smart-home', 'automation', 'iot', 'homekit'],
 true, true, 4000, 0, 0);
