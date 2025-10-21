
INSERT INTO listings (
  id, thread_id, user_id, title, subtitle, description, 
  price, currency, seller_name, seller_location, seller_verified, 
  time_posted, image_url, gallery, category, listing_type, 
  tags, views_count, is_protected, status, expires_at
) VALUES

-- ============================================
-- ELECTRONICS (apple-devices thread) - 4 listings
-- ============================================
('elec-002', 'apple-devices', 2,
 'Looking to Buy: Latest iPhone 15 Pro Max',
 '256GB - Budget RM 4,500',
 'Seeking a brand new or lightly used iPhone 15 Pro Max, 256GB. Budget: RM 4,500.',
 4500.00, 'RM', 'TechHunter', 'Petaling Jaya', false, '2 hours ago',
 'https://images.unsplash.com/photo-1647866276622-7990c3ee684d?q=80&w=1287',
 ARRAY['https://images.unsplash.com/photo-1704380895316-caa2e4d68a7e?w=600','https://plus.unsplash.com/premium_photo-1681233750830-dfbb25c7abc0?w=600'],
 'electronics', 'want-to-buy',
 ARRAY['iphone', 'apple', 'buy-request'],
 89, false, 'active', NOW() + INTERVAL '7 days'),

('elec-008', 'apple-devices', 1,
 'Apple Watch SE (2nd Gen, 40mm) Starlight',
 'With Extra Sports Band',
 'Less than 3 months old, worn a few times. Comes with extra sports band.',
 850.00, 'RM', 'AppleFanMY', 'Kuala Lumpur', true, '3 hours ago',
 'https://images.unsplash.com/photo-1614106765035-bceac4ac1911?q=80&w=1287',
 ARRAY['https://images.unsplash.com/photo-1624096104992-9b4fa3a279dd?w=600','https://images.unsplash.com/photo-1609096458733-95b38583ac4e?w=600'],
 'electronics', 'for-sale',
 ARRAY['apple-watch', 'wearable', 'se', 'apple'],
 198, true, 'active', NOW() + INTERVAL '14 days'),

('elec-003', 'apple-devices', 5,
 'Sony WH-1000XM4 Noise Cancelling Headphones',
 'Excellent Condition',
 'Excellent condition, comes with original box and accessories. Used for 6 months.',
 650.00, 'RM', 'AudioPhile', 'Subang Jaya', true, '5 hours ago',
 'https://images.unsplash.com/photo-1583305727488-61f82c7eae4b?q=80&w=1287',
 ARRAY['https://images.unsplash.com/photo-1618366712010-f4ae9c647dcb?w=600'],
 'electronics', 'for-sale',
 ARRAY['sony', 'headphones', 'audio'],
 175, true, 'active', NOW() + INTERVAL '14 days'),

('elec-007', 'apple-devices', 2,
 'WTB: Vintage Vinyl Turntable (Working)',
 'Technics/Pioneer Preferred',
 'Searching for a classic, working turntable, preferably Technics or Pioneer model.',
 1000.00, 'RM', 'VinylJunkie', 'Ipoh', false, '10 hours ago',
 'https://plus.unsplash.com/premium_photo-1663011373221-9bce9f22261e?q=80&w=2670',
 ARRAY['https://images.unsplash.com/photo-1510100831744-b8d7fea7ca2e?w=600'],
 'electronics', 'want-to-buy',
 ARRAY['turntable', 'vinyl', 'vintage', 'audio'],
 65, false, 'active', NOW() + INTERVAL '7 days'),

-- ============================================
-- TECHNOLOGY (pc-building thread) - 2 listings
-- ============================================
('elec-001', 'pc-building', 1, 
 'Gaming PC Setup - RTX 4070', 
 'Complete Setup',
 'Complete gaming setup with RTX 4070, 32GB RAM, and 27" 144Hz monitor.',
 3500.00, 'RM', 'GamerGirl2024', 'Kuala Lumpur', true, '1 hour ago',
 'https://images.unsplash.com/photo-1706954817491-4d8d735256e5?w=600',
 ARRAY['https://images.unsplash.com/photo-1624701928517-44c8ac49d93c?w=600','https://images.unsplash.com/photo-1729934746958-857e5b082dcc?w=600'],
 'technology', 'for-sale',
 ARRAY['pc-building', 'rtx-4070', 'gaming-pc', 'custom-build'],
 345, true, 'active', NOW() + INTERVAL '14 days'),

('elec-009', 'pc-building', 2,
 'WTB: High-End Gaming PC Components',
 'RTX 4080 or 4090, 32GB DDR5 RAM',
 'Looking for high-end gaming PC components: RTX 4080/4090, 32GB DDR5 RAM, latest gen CPU. Budget: RM 8,000.',
 8000.00, 'RM', 'PCEnthusiast', 'Petaling Jaya', true, '4 hours ago',
 'https://images.unsplash.com/photo-1587831990711-23ca6441447b?w=600',
 ARRAY['https://images.unsplash.com/photo-1587831990711-23ca6441447b?w=600','https://images.unsplash.com/photo-1624705011240-c92ad5f33b31?w=600'],
 'technology', 'want-to-buy',
 ARRAY['pc-building', 'rtx-4080', 'rtx-4090', 'gaming-pc', 'wtb'],
 156, false, 'active', NOW() + INTERVAL '7 days'),

-- ============================================
-- TECHNOLOGY (ai-tools thread) - 3 listings
-- ============================================
('elec-004', 'ai-tools', 1,
 'DJI Mini 3 Pro Drone Combo',
 'Fly More Kit Included',
 'Fly More Combo with extra batteries and controller screen. Low flight hours.',
 2800.00, 'RM', 'DronePilotMY', 'Klang', true, '1 day ago',
 'https://images.unsplash.com/photo-1662348316911-d6aef85f8560?q=80&w=3030',
 ARRAY['https://plus.unsplash.com/premium_photo-1714618849685-89cad85746b1?w=600','https://images.unsplash.com/photo-1655219282209-6e6e64515c0d?w=600','https://images.unsplash.com/photo-1667948088559-f5036b9f3802?w=600'],
 'technology', 'for-sale',
 ARRAY['dji', 'drone', 'mini-3-pro', 'photography'],
 410, true, 'active', NOW() + INTERVAL '14 days'),

('elec-005', 'ai-tools', 3,
 'HP LaserJet Pro Multifunction Printer',
 'Office/Home Use',
 'Black and white laser printer, scanner, and copier. Perfect for small office.',
 450.00, 'RM', 'OfficeClearance', 'Johor Bahru', false, '7 hours ago',
 'https://images.unsplash.com/photo-1612815154858-60aa4c59eaa6?q=80&w=2670',
 ARRAY['https://images.unsplash.com/photo-1612815154858-60aa4c59eaa6?w=600'],
 'technology', 'for-sale',
 ARRAY['printer', 'hp', 'office', 'equipment'],
 112, false, 'active', NOW() + INTERVAL '7 days'),

('elec-006', 'ai-tools', 5,
 'Selling: Canon EOS M50 Mark II Mirrorless Camera',
 'Vlogging Kit',
 'Comes with 15-45mm kit lens. Great for vlogging and beginner photography.',
 1900.00, 'RM', 'PhotoHobbyist', 'Penang', true, '2 days ago',
 'https://images.unsplash.com/photo-1581673958497-493bc93c2a0a?q=80&w=2670',
 ARRAY['https://images.unsplash.com/photo-1495707902641-75cac588d2e9?w=600','https://images.unsplash.com/photo-1504093376055-b3094b674dcb?w=600'],
 'technology', 'for-sale',
 ARRAY['camera', 'canon', 'mirrorless', 'vlog', 'photography'],
 290, true, 'active', NOW() + INTERVAL '14 days'),

-- ============================================
-- TECHNOLOGY (smart-home thread) - 3 listings
-- ============================================
('smart-001', 'smart-home', 4,
 'Google Nest Hub Max',
 'Smart Display with Voice Control',
 'Google Nest Hub Max with 10-inch display, camera, and Google Assistant. Perfect for smart home control.',
 580.00, 'RM', 'SmartHomeMY', 'Shah Alam', true, '2 hours ago',
 'https://images.unsplash.com/photo-1558618047-3c8c76ca7d13?w=600',
 ARRAY['https://images.unsplash.com/photo-1558618047-3c8c76ca7d13?w=600','https://images.unsplash.com/photo-1573164713988-8665fc963095?w=600'],
 'technology', 'for-sale',
 ARRAY['google-nest', 'smart-display', 'home-automation', 'voice-control'],
 124, false, 'active', NOW() + INTERVAL '7 days'),

('smart-002', 'smart-home', 2,
 'WTB: Philips Hue Smart Light Starter Kit',
 'Color Bulbs + Bridge Included',
 'Looking for Philips Hue starter kit with bridge and color bulbs. Prefer complete package. Budget: RM 450.',
 450.00, 'RM', 'HomeAutomator', 'Kuala Lumpur', false, '6 hours ago',
 'https://images.unsplash.com/photo-1574269909862-7e1d70bb8078?w=600',
 ARRAY['https://images.unsplash.com/photo-1574269909862-7e1d70bb8078?w=600','https://images.unsplash.com/photo-1558618047-3c8c76ca7d13?w=600'],
 'technology', 'want-to-buy',
 ARRAY['philips-hue', 'smart-lights', 'home-automation', 'wtb'],
 89, false, 'active', NOW() + INTERVAL '7 days'),

('smart-003', 'smart-home', 5,
 'Amazon Echo Dot (5th Gen) Bundle',
 '3 Units + Smart Plug Included',
 'Bundle of 3 Echo Dot devices with smart plugs. Perfect for multi-room voice control setup.',
 320.00, 'RM', 'TechBundler', 'Subang Jaya', true, '1 day ago',
 'https://images.unsplash.com/photo-1518444065439-e933c06ce9cd?w=600',
 ARRAY['https://images.unsplash.com/photo-1518444065439-e933c06ce9cd?w=600','https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=600'],
 'technology', 'for-sale',
 ARRAY['amazon-echo', 'voice-assistant', 'smart-plug', 'bundle'],
 167, true, 'active', NOW() + INTERVAL '14 days'),

-- ============================================
-- FURNITURE (furniture thread) - 6 listings
-- ============================================
('furn-001', 'furniture', 1,
 'Minimalist Scandinavian 4-Seater Sofa',
 'Light Grey Fabric, Excellent Condition',
 'Light grey fabric sofa, perfect condition, selling due to relocation.',
 1800.00, 'RM', 'HomeStylist', 'Kuala Lumpur', true, '1 day ago',
 'https://images.unsplash.com/photo-1540574163026-643ea20ade25?q=80&w=2070',
 ARRAY['https://images.unsplash.com/photo-1540574163026-643ea20ade25?q=80&w=2070','https://images.unsplash.com/photo-1658501238841-da09649a94f3?w=600'],
 'furniture', 'for-sale',
 ARRAY['sofa', 'minimalist', 'scandinavian', 'living-room'],
 280, true, 'active', NOW() + INTERVAL '14 days'),

('furn-003', 'furniture', 4,
 'IKEA Billy Bookcase (White, 5 units)',
 'Selling as a Set Only',
 'Five standard white Billy bookcases. Selling as a set only. Used for 1 year.',
 400.00, 'RM', 'BookLoverKL', 'Shah Alam', true, '8 hours ago',
 'https://images.unsplash.com/photo-1593670755950-603e1d6184b9?q=80&w=1963',
 ARRAY['https://images.unsplash.com/photo-1593670755950-603e1d6184b9?q=80&w=1963','https://images.unsplash.com/photo-1543248939-4296e1fea89b?w=600'],
 'furniture', 'for-sale',
 ARRAY['ikea', 'bookcase', 'storage', 'shelving'],
 120, true, 'active', NOW() + INTERVAL '14 days'),

('furn-004', 'furniture', 2,
 'Queen Size Bed Frame and Mattress',
 'Medium-Firm, Self-Pickup Required',
 'Metal frame and medium-firm spring mattress. Used for 2 years. Self-pickup required.',
 950.00, 'RM', 'MovingOutSale', 'Subang Jaya', false, '4 hours ago',
 'https://images.unsplash.com/photo-1593184091721-409ccc1753d9?q=80&w=2070',
 ARRAY['https://images.unsplash.com/photo-1593184091721-409ccc1753d9?q=80&w=2070'],
 'furniture', 'for-sale',
 ARRAY['bed', 'mattress', 'bedroom', 'queen-size'],
 190, true, 'active', NOW() + INTERVAL '14 days'),

('furn-005', 'furniture', 5,
 'Modern Glass Dining Table (6-Seater)',
 'Includes 6 Fabric Chairs',
 'Tempered glass top with stainless steel legs. Includes 6 fabric chairs.',
 1500.00, 'RM', 'DiningDeals', 'Klang', true, '1 day ago',
 'https://images.unsplash.com/photo-1582472181599-86a60136bdf4?w=600',
 ARRAY['https://images.unsplash.com/photo-1582472181599-86a60136bdf4?w=600'],
 'furniture', 'for-sale',
 ARRAY['dining', 'table', 'glass', '6-seater'],
 210, true, 'active', NOW() + INTERVAL '14 days'),

('furn-006', 'furniture', 2,
 'Selling: Herman Miller Embody Office Chair',
 'Ergonomic, Black, With Receipt',
 'Ergonomic chair in black. Excellent support for long hours of work. Original purchase receipt available.',
 3500.00, 'RM', 'WorkFromHomePro', 'Petaling Jaya', true, '2 hours ago',
 'https://images.unsplash.com/photo-1616982731841-001a8a090d86?w=600',
 ARRAY['https://images.unsplash.com/photo-1616982731841-001a8a090d86?w=600'],
 'furniture', 'for-sale',
 ARRAY['office-chair', 'herman-miller', 'ergonomic', 'work-from-home'],
 350, true, 'active', NOW() + INTERVAL '14 days'),

('furn-007', 'furniture', 1,
 'WTB: Antique Chinese Cabinet or Chest',
 'Looking for Genuine Antique',
 'Looking for a genuine antique Chinese-style wooden cabinet. Condition can be moderate.',
 3000.00, 'RM', 'HeritageFinder', 'Georgetown', true, '6 days ago',
 'https://plus.unsplash.com/premium_photo-1720884611740-f5e807d7c77e?w=600',
 ARRAY['https://plus.unsplash.com/premium_photo-1720884611740-f5e807d7c77e?w=600'],
 'furniture', 'want-to-buy',
 ARRAY['antique', 'cabinet', 'chinese', 'wtb'],
 40, false, 'active', NOW() + INTERVAL '7 days'),

-- ============================================
-- FURNITURE (furniture-vintage thread) - 1 listing
-- ============================================
('furn-002', 'furniture-vintage', 3,
 'Looking to Buy: Vintage Wooden Study Desk',
 'Solid Wood, Must Have Drawers',
 'Seeking a solid wood antique or vintage study desk, must have drawers.',
 500.00, 'RM', 'AntiqueCollector', 'Ipoh', false, '3 days ago',
 'https://images.unsplash.com/photo-1585148481101-0dea656c03a9?q=80&w=2070',
 ARRAY['https://plus.unsplash.com/premium_photo-1664297827889-5cc99441cada?w=600'],
 'furniture', 'want-to-buy',
 ARRAY['desk', 'vintage', 'study', 'wtb'],
 60, false, 'active', NOW() + INTERVAL '7 days'),

-- ============================================
-- FURNITURE (furniture-diy thread) - 1 listing
-- ============================================
('furn-008', 'furniture-diy', 3,
 'Large Outdoor Patio Umbrella (Cantilever)',
 '3-Meter Beige',
 '3-meter cantilever umbrella in beige. Great for garden or balcony. Minor sun fading.',
 550.00, 'RM', 'BalconyRelax', 'Johor Bahru', false, '12 hours ago',
 'https://plus.unsplash.com/premium_photo-1676638972162-99c667d08938?w=600',
 ARRAY['https://plus.unsplash.com/premium_photo-1676638972162-99c667d08938?w=600'],
 'furniture', 'for-sale',
 ARRAY['outdoor', 'patio', 'umbrella', 'garden'],
 95, true, 'active', NOW() + INTERVAL '14 days'),

-- ============================================
-- BOOKS (books thread) - 6 listings
-- ============================================
('book-002', 'books', 2,
 'Selling: Used University Textbooks (Finance/Eco)',
 'Discount for Bulk Buy',
 'Assorted university textbooks for Finance and Economics degrees. Discount for bulk buy.',
 80.00, 'RM', 'GradStudent', 'Petaling Jaya', false, '1 day ago',
 'https://images.unsplash.com/photo-1520467795206-62e33627e6ce?w=600',
 ARRAY['https://images.unsplash.com/photo-1520467795206-62e33627e6ce?w=600'],
 'books', 'for-sale',
 ARRAY['textbook', 'finance', 'education', 'economics'],
 95, false, 'active', NOW() + INTERVAL '7 days'),

('book-003', 'books', 1,
 'WTB: Rare First Edition Comic Books',
 'Malaysian/Asian Comics Preferred',
 'Looking to buy rare Malaysian or Asian comic books, first editions preferred.',
 1.00, 'RM', 'ComicFanatic', 'Online', true, '5 days ago',
 'https://images.unsplash.com/photo-1598888831741-cb535295b013?q=80&w=2070',
 ARRAY['https://images.unsplash.com/photo-1598888831741-cb535295b013?q=80&w=2070'],
 'books', 'want-to-buy',
 ARRAY['comic', 'rare', 'first-edition', 'wtb'],
 20, false, 'active', NOW() + INTERVAL '7 days'),

('book-004', 'books', 1,
 'Complete Harry Potter Series (Paperback)',
 'All 7 Books, Excellent Condition',
 'All 7 books in the standard paperback edition. Read once, excellent condition.',
 200.00, 'RM', 'PotterHeadMY', 'Kuala Lumpur', true, '3 hours ago',
 'https://images.unsplash.com/photo-1481047540402-8f3d39289bca?w=600',
 ARRAY['https://images.unsplash.com/photo-1481047540402-8f3d39289bca?w=600','https://images.unsplash.com/photo-1610466025839-ec6040c347b6?w=600'],
 'books', 'for-sale',
 ARRAY['harry-potter', 'fiction', 'series', 'young-adult'],
 250, true, 'active', NOW() + INTERVAL '14 days'),

('book-005', 'books', 4,
 'Selling: Malaysian Cookbook Collection (5 Books)',
 'Nonya and Malay Cuisine',
 'Set of five local cookbooks, including Nonya and Malay cuisine. Great for beginners.',
 120.00, 'RM', 'HomeChefKL', 'Shah Alam', true, '1 hour ago',
 'https://images.unsplash.com/photo-1570570329584-b41861c52c5b?w=600',
 ARRAY['https://images.unsplash.com/photo-1570570329584-b41861c52c5b?w=600'],
 'books', 'for-sale',
 ARRAY['cookbook', 'malaysian-cuisine', 'cooking', 'recipe'],
 70, true, 'active', NOW() + INTERVAL '14 days'),

('book-006', 'books', 2,
 'WTB: Used Manga - Attack on Titan Vol. 1-30',
 'Complete or Near-Complete Set',
 'Looking for a complete or near-complete set of the Attack on Titan manga series.',
 10.00, 'RM', 'MangaFanBoy', 'Penang', false, '1 day ago',
 'https://images.unsplash.com/photo-1553931122-eb3db723739f?w=600',
 ARRAY['https://images.unsplash.com/photo-1553931122-eb3db723739f?w=600'],
 'books', 'want-to-buy',
 ARRAY['manga', 'attack-on-titan', 'anime', 'wtb'],
 55, false, 'active', NOW() + INTERVAL '7 days'),

('book-008', 'books', 3,
 'Kids'' Picture Book Bundle (20 Books)',
 'English and Malay Storybooks',
 'Mix of English and Malay storybooks for children aged 3-6. Good for reading practice.',
 60.00, 'RM', 'ParentSeller', 'Bayan Lepas', false, '5 hours ago',
 'https://images.unsplash.com/photo-1469013078550-305e63b7c8f7?w=600',
 ARRAY['https://images.unsplash.com/photo-1469013078550-305e63b7c8f7?w=600'],
 'books', 'for-sale',
 ARRAY['childrens-books', 'kids', 'education', 'bundle'],
 85, false, 'active', NOW() + INTERVAL '7 days'),

-- ============================================
-- BOOKS (books-fantasy thread) - 1 listing
-- ============================================
('book-001', 'books-fantasy', 3,
 'The Lord of the Rings Trilogy (Hardcover)',
 'Collector''s Edition, Like New',
 'Collector''s edition hardcover set. Like new condition.',
 150.00, 'RM', 'FantasyReader', 'Johor Bahru', true, '2 hours ago',
 'https://images.unsplash.com/photo-1607948274673-3dc6578ebecc?q=80&w=2070',
 ARRAY['https://images.unsplash.com/photo-1607948274673-3dc6578ebecc?q=80&w=2070','https://images.unsplash.com/photo-1590594786467-09c7c73c111f?q=80&w=1170'],
 'books', 'for-sale',
 ARRAY['fantasy', 'fiction', 'collector', 'lotr'],
 110, true, 'active', NOW() + INTERVAL '14 days'),

-- ============================================
-- BOOKS (books-productivity thread) - 1 listing
-- ============================================
('book-007', 'books-productivity', 5,
 'Biography of Elon Musk (New Release)',
 'Hardcover, Dust Jacket Intact',
 'Hardcover copy of the latest biography. Read once, dust jacket intact.',
 95.00, 'RM', 'BusinessReader', 'Subang Jaya', true, '7 hours ago',
 'https://images.unsplash.com/photo-1650178284536-2d6dff47f903?w=600',
 ARRAY['https://images.unsplash.com/photo-1650178284536-2d6dff47f903?w=600'],
 'books', 'for-sale',
 ARRAY['biography', 'non-fiction', 'business', 'hardcover'],
 140, true, 'active', NOW() + INTERVAL '14 days'),

-- ============================================
-- FASHION (fashion thread) - 6 listings
-- ============================================
('fash-002', 'fashion', 3,
 'Want to Buy: Vintage Leather Jacket (Size L)',
 'Distressed Brown Motorcycle Style',
 'Seeking a genuine, distressed brown leather motorcycle jacket. Must be size L. Budget: RM 800.00.',
 800.00, 'RM', 'RockerStyle', 'Georgetown', false, '1 day ago',
 'https://images.unsplash.com/photo-1641943632479-3798ef1e14c6?w=700',
 ARRAY['https://images.unsplash.com/photo-1641943632479-3798ef1e14c6?w=700'],
 'fashion', 'want-to-buy',
 ARRAY['vintage', 'leather', 'jacket', 'wtb'],
 45, false, 'active', NOW() + INTERVAL '7 days'),

('fash-003', 'fashion', 3,
 'Tissot Chronograph Watch',
 'Swiss-made, Stainless Steel',
 'Swiss-made chronograph. Stainless steel with black leather strap. Excellent condition.',
 1800.00, 'RM', 'TimePieceGuy', 'Johor Bahru', true, '4 hours ago',
 'https://images.unsplash.com/photo-1727716919539-3cd4aaf7af99?q=80&w=1287',
 ARRAY['https://images.unsplash.com/photo-1727716919539-3cd4aaf7af99?q=80&w=1287'],
 'fashion', 'for-sale',
 ARRAY['watch', 'tissot', 'luxury', 'accessories'],
 110, true, 'active', NOW() + INTERVAL '14 days'),

('fash-004', 'fashion', 1,
 'Original Coach Tote Bag (Black)',
 'Large Capacity, Excellent Condition',
 'Large capacity tote bag, perfect for work or travel. Used a few times, excellent condition.',
 750.00, 'RM', 'BagLoverKL', 'Kuala Lumpur', true, '50 minutes ago',
 'https://plus.unsplash.com/premium_photo-1750218296007-f73edb01d1ba?q=80&w=2670',
 ARRAY['https://plus.unsplash.com/premium_photo-1750218296007-f73edb01d1ba?q=80&w=2670'],
 'fashion', 'for-sale',
 ARRAY['handbag', 'coach', 'designer', 'tote'],
 78, false, 'active', NOW() + INTERVAL '7 days'),

('fash-005', 'fashion', 2,
 'Ray-Ban Aviator Sunglasses (Polarized)',
 'Classic Aviator Style with Case',
 'Classic aviator style, polarized lenses. Only worn a few times. Comes with case.',
 350.00, 'RM', 'SunShadesMY', 'Subang Jaya', false, '3 hours ago',
 'https://images.unsplash.com/photo-1530432999454-016a47c78af3?q=80&w=1336',
 ARRAY['https://images.unsplash.com/photo-1530432999454-016a47c78af3?q=80&w=1336'],
 'fashion', 'for-sale',
 ARRAY['sunglasses', 'ray-ban', 'accessories', 'polarized'],
 61, false, 'active', NOW() + INTERVAL '7 days'),

('fash-006', 'fashion', 1,
 'Wedding Dress (Size M/UK 10)',
 'Mermaid Cut, Lace, Dry-Cleaned',
 'Mermaid-cut, lace detailing. Worn once, professionally dry-cleaned. Negotiable price.',
 1500.00, 'RM', 'BrideToSeller', 'Melaka', true, '2 days ago',
 'https://plus.unsplash.com/premium_photo-1661432699720-b50b2abd5c0a?q=80&w=2670',
 ARRAY['https://plus.unsplash.com/premium_photo-1661432699720-b50b2abd5c0a?q=80&w=2670'],
 'fashion', 'for-sale',
 ARRAY['wedding', 'dress', 'formal', 'negotiable'],
 198, true, 'active', NOW() + INTERVAL '14 days'),

('fash-007', 'fashion', 1,
 'WTB: Authentic Hermes Scarf (Silk)',
 'Seeking Proof of Authenticity',
 'Seeking a genuine Hermes silk scarf, any color/pattern. Must provide proof of authenticity. Budget: RM 1,200.00.',
 1200.00, 'RM', 'LuxuryBuyer', 'Online', true, '1 day ago',
 'https://plus.unsplash.com/premium_photo-1758611682513-261331205a40?q=80&w=1287',
 ARRAY['https://plus.unsplash.com/premium_photo-1758611682513-261331205a40?q=80&w=1287'],
 'fashion', 'want-to-buy',
 ARRAY['hermes', 'luxury', 'scarf', 'wtb'],
 22, true, 'active', NOW() + INTERVAL '7 days'),

-- ============================================
-- FASHION (fashion-sneakers thread) - 1 listing
-- ============================================
('fash-001', 'fashion-sneakers', 4,
 'Nike Air Max 270 (Size 9)',
 'Brand New, Black/White',
 'Brand new Nike Air Max 270 in black/white colorway. Never worn.',
 450.00, 'RM', 'SneakerHead99', 'Shah Alam', true, '30 minutes ago',
 'https://images.unsplash.com/photo-1562613521-6b5293e5b0ea?q=80&w=2670',
 ARRAY['https://images.unsplash.com/photo-1562613521-6b5293e5b0ea?q=80&w=2670'],
 'fashion', 'for-sale',
 ARRAY['nike', 'air-max', 'sneakers', 'new'],
 152, false, 'active', NOW() + INTERVAL '7 days'),

-- ============================================
-- FASHION (fashion-sustainable thread) - 1 listing
-- ============================================
('fash-008', 'fashion-sustainable', 2,
 'Uniqlo Heattech Long-Sleeve Tops (4 Pcs)',
 'Size M, 2 Black & 2 Grey',
 'Four pieces of Uniqlo Heattech (2 Black, 2 Grey), size M. Great for winter travel.',
 100.00, 'RM', 'TravelReady', 'Petaling Jaya', false, '1 hour ago',
 'https://images.unsplash.com/photo-1624522955553-a5240288ce21?q=80&w=1287',
 ARRAY['https://images.unsplash.com/photo-1624522955553-a5240288ce21?q=80&w=1287'],
 'fashion', 'for-sale',
 ARRAY['uniqlo', 'heattech', 'winter', 'bundle'],
 90, false, 'active', NOW() + INTERVAL '7 days'),

-- ============================================
-- GAMING (gaming thread) - 6 listings
-- ============================================
('game-001', 'gaming', 5,
 'Nintendo Switch OLED (White)',
 'Barely Used, Includes Zelda Game',
 'Barely used console with all original accessories and one game (Zelda).',
 1250.00, 'RM', 'ConsoleSeller', 'Klang', true, '45 minutes ago',
 'https://images.unsplash.com/photo-1680007966627-d49ae18dbbae?q=80&w=2670',
 ARRAY['https://images.unsplash.com/photo-1680007966627-d49ae18dbbae?q=80&w=2670'],
 'gaming', 'for-sale',
 ARRAY['nintendo', 'switch', 'oled', 'console'],
 210, false, 'active', NOW() + INTERVAL '7 days'),

('game-002', 'gaming', 4,
 'PS5 DualSense Controllers (Pair)',
 'White and Midnight Black, Mint Condition',
 'Two controllers, one white, one midnight black. Mint condition.',
 380.00, 'RM', 'AccessoryMaster', 'Bayan Lepas', false, '2 hours ago',
 'https://images.unsplash.com/photo-1643906651350-20325b18debb?q=80&w=2670',
 ARRAY['https://images.unsplash.com/photo-1643906651350-20325b18debb?q=80&w=2670'],
 'gaming', 'for-sale',
 ARRAY['ps5', 'dualsense', 'controller', 'accessories'],
 155, false, 'active', NOW() + INTERVAL '7 days'),

('game-003', 'gaming', 2,
 'Looking for: Used Valve Steam Deck (512GB)',
 'WTB, KL Meet-up Preferred',
 'Seeking a 512GB Steam Deck model. Willing to meet up in KL area for trade. Budget: RM 2,000.00.',
 2000.00, 'RM', 'PCGamer23', 'Kuala Lumpur', false, '6 hours ago',
 'https://images.unsplash.com/photo-1654621158365-55fcf7b76fb7?q=80&w=2670',
 ARRAY['https://images.unsplash.com/photo-1654621158365-55fcf7b76fb7?q=80&w=2670'],
 'gaming', 'want-to-buy',
 ARRAY['steam-deck', 'pc-gaming', 'portable', 'wtb'],
 95, false, 'active', NOW() + INTERVAL '7 days'),

('game-004', 'gaming', 2,
 'Xbox Series X Console (Mint Condition)',
 'Less than 1 Year Old, Includes 2 Controllers',
 'Used for less than a year. Includes 2 controllers and original box. Selling to upgrade PC.',
 1900.00, 'RM', 'GreenTeamMY', 'Petaling Jaya', true, '4 hours ago',
 'https://images.unsplash.com/photo-1621259182978-fbf93132d53d?q=80&w=3132',
 ARRAY['https://images.unsplash.com/photo-1621259182978-fbf93132d53d?q=80&w=3132'],
 'gaming', 'for-sale',
 ARRAY['xbox', 'series-x', 'console'],
 250, true, 'active', NOW() + INTERVAL '14 days'),

('game-005', 'gaming', 2,
 'The Last of Us Part II (PS4/PS5)',
 'Physical Copy, Excellent Condition',
 'Physical copy, excellent condition. Compatible with PS5 via backward compatibility.',
 80.00, 'RM', 'GameSwapPJ', 'Subang Jaya', false, '1 hour ago',
 'https://images.unsplash.com/photo-1585984968562-1443b72fb0dc?q=80&w=2670',
 ARRAY['https://images.unsplash.com/photo-1585984968562-1443b72fb0dc?q=80&w=2670'],
 'gaming', 'for-sale',
 ARRAY['ps4', 'ps5', 'game', 'last-of-us', 'physical'],
 75, false, 'active', NOW() + INTERVAL '7 days'),

('game-006', 'gaming', 1,
 'Retro Console Lot - Nintendo 64 & Games',
 'N64 Console, 2 Controllers, 5 Classic Games',
 'N64 console, 2 controllers, and 5 classic games (Mario 64, Ocarina of Time, etc.).',
 700.00, 'RM', 'RetroHunter', 'Kuala Lumpur', true, '1 day ago',
 'https://images.unsplash.com/photo-1630835149127-e07e5f9b0a9f?q=80&w=2670',
 ARRAY['https://images.unsplash.com/photo-1630835149127-e07e5f9b0a9f?q=80&w=2670'],
 'gaming', 'for-sale',
 ARRAY['retro', 'nintendo-64', 'n64', 'vintage'],
 180, false, 'active', NOW() + INTERVAL '7 days'),

-- ============================================
-- GAMING (gaming-mmorpg thread) - 2 listings
-- ============================================
('game-007', 'gaming-mmorpg', 3,
 'WTB: Used Razer BlackShark V2 Pro Headset',
 'Wireless Version Preferred, Working Condition',
 'Seeking the wireless version of the Razer BlackShark V2 Pro headset. Must be in working order. Budget: RM 400.00.',
 400.00, 'RM', 'VoiceChatKing', 'Georgetown', false, '9 hours ago',
 'https://images.unsplash.com/photo-1674989844487-722ec77b9b81?q=80&w=1287',
 ARRAY['https://images.unsplash.com/photo-1591105866700-cb5d708ccd93?w=700'],
 'gaming', 'want-to-buy',
 ARRAY['headset', 'razer', 'pc-gaming', 'wtb'],
 40, false, 'active', NOW() + INTERVAL '7 days'),

('game-008', 'gaming-mmorpg', 4,
 'Logitech G Pro X Mechanical Gaming Keyboard',
 'Tactile Switches, Tenkeyless Design',
 'Tactile switches, tenkeyless design. Perfect for competitive gaming. Less than a year old.',
 350.00, 'RM', 'PCMasterRace', 'Shah Alam', true, '3 hours ago',
 'https://images.unsplash.com/photo-1623593475667-377c7376f0f4?q=80&w=1365',
 ARRAY['https://images.unsplash.com/photo-1623593475667-377c7376f0f4?q=80&w=1365'],
 'gaming', 'for-sale',
 ARRAY['keyboard', 'logitech', 'pc-gaming', 'mechanical'],
 115, false, 'active', NOW() + INTERVAL '7 days'),

-- ============================================
-- SPORT (sport thread) - 6 listings
-- ============================================
('sport-002', 'sport', 2,
 'Looking for: Adjustable Dumbbell Set (50kg)',
 'WTB, Space-Saving Design',
 'Seeking a space-saving, adjustable dumbbell set (up to 25kg per hand). Must be good quality. Budget: RM 600.00.',
 600.00, 'RM', 'HomeGymGuy', 'Selangor', false, '7 hours ago',
 'https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2?w=600',
 ARRAY['https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2?w=600'],
 'sport', 'want-to-buy',
 ARRAY['dumbbell', 'gym', 'home-fitness', 'wtb'],
 55, false, 'active', NOW() + INTERVAL '7 days'),

('sport-003', 'sport', 5,
 'Professional Yonex Badminton Rackets (Pair)',
 'High-End, Recently Re-strung',
 'Two high-end Yonex rackets, recently re-strung. Selling as a pair.',
 480.00, 'RM', 'BadmintonPro', 'Penang', true, '3 days ago',
 'https://images.unsplash.com/photo-1564226803380-91139fdcb4d0?w=600',
 ARRAY['https://images.unsplash.com/photo-1564226803380-91139fdcb4d0?w=600'],
 'sport', 'for-sale',
 ARRAY['badminton', 'yonex', 'racket', 'pair'],
 130, false, 'active', NOW() + INTERVAL '7 days'),

('sport-004', 'sport', 3,
 'Adidas Predator Football Boots (Size UK 10)',
 'Used 1 Season, Firm Ground Cleats',
 'Used for one season only, excellent grip and condition. Cleats for firm ground.',
 180.00, 'RM', 'FootyFanatic', 'Kuala Lumpur', false, '2 hours ago',
 'https://images.unsplash.com/photo-1580902394724-b08ff9ba7e8a?w=600',
 ARRAY['https://images.unsplash.com/photo-1580902394724-b08ff9ba7e8a?w=600'],
 'sport', 'for-sale',
 ARRAY['football', 'adidas', 'boots', 'size-10'],
 88, false, 'active', NOW() + INTERVAL '7 days'),

('sport-005', 'sport', 5,
 'Used Golf Clubs Set (Complete)',
 'PING G425 Irons and Driver, Includes Bag',
 'Full set of PING G425 irons and driver. Perfect for a mid-handicap player. Includes bag.',
 4500.00, 'RM', 'GolfLoverMY', 'Subang Jaya', true, '1 day ago',
 'https://images.unsplash.com/photo-1675106643681-da7ad12e926f?w=600',
 ARRAY['https://images.unsplash.com/photo-1675106643681-da7ad12e926f?w=600'],
 'sport', 'for-sale',
 ARRAY['golf', 'clubs', 'ping', 'complete-set'],
 220, true, 'active', NOW() + INTERVAL '14 days'),

('sport-006', 'sport', 3,
 'WTB: Scuba Diving BCD (Size M)',
 'Scubapro Preferred, Well-Maintained',
 'Searching for a reliable and well-maintained Buoyancy Control Device (BCD) for diving. Brand preferred: Scubapro. Budget: RM 1,500.00.',
 1500.00, 'RM', 'DiverJoe', 'Kota Kinabalu', false, '9 hours ago',
 'https://images.unsplash.com/photo-1645059986162-d077871822b6?w=700',
 ARRAY['https://images.unsplash.com/photo-1645059986162-d077871822b6?w=700'],
 'sport', 'want-to-buy',
 ARRAY['diving', 'scuba', 'watersports', 'bcd', 'wtb'],
 35, false, 'active', NOW() + INTERVAL '7 days'),

('sport-007', 'sport', 2,
 'Xiaomi Walking Pad Treadmill',
 'Foldable, Under-Desk, Hardly Used',
 'Foldable, under-desk treadmill. Excellent for a home office setup. Hardly used.',
 900.00, 'RM', 'FitnessHome', 'Petaling Jaya', true, '4 hours ago',
 'https://images.unsplash.com/photo-1576678927484-cc907957088c?w=600',
 ARRAY['https://images.unsplash.com/photo-1576678927484-cc907957088c?w=600'],
 'sport', 'for-sale',
 ARRAY['treadmill', 'home-fitness', 'xiaomi', 'foldable'],
 165, false, 'active', NOW() + INTERVAL '7 days'),

-- ============================================
-- SPORT (sport-running thread) - 1 listing
-- ============================================
('sport-008', 'sport-running', 3,
 'Basketball Shoes - Nike Kobe 5 Protro (Size 11)',
 'Rare Colorway, Indoor Court Use Only',
 'Rare colorway, worn for indoor court only. Good traction remaining.',
 750.00, 'RM', 'HoopsMaster', 'Johor Bahru', false, '5 days ago',
 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTm5IO04dUeXmJDSI-ZtUGaQGuXJBkFioWwtQ&s',
 ARRAY['https://images.unsplash.com/photo-1552346154-21d32810aba3?w=600'],
 'sport', 'for-sale',
 ARRAY['basketball', 'nike', 'kobe', 'sneakers', 'rare'],
 99, false, 'active', NOW() + INTERVAL '7 days'),

-- ============================================
-- SPORT (sport-outdoor thread) - 1 listing
-- ============================================
('sport-001', 'sport-outdoor', 3,
 'Used Road Bike - Polygon Strattos S5 (Size 52)',
 'Good Condition, Maintained',
 'Good condition, regularly maintained. Perfect for beginner to intermediate riders.',
 2200.00, 'RM', 'BikeLoverMY', 'Puchong', true, '1 hour ago',
 'https://images.unsplash.com/photo-1487803836022-91054ca05fdd?w=600',
 ARRAY['https://images.unsplash.com/photo-1487803836022-91054ca05fdd?w=600'],
 'sport', 'for-sale',
 ARRAY['road-bike', 'cycling', 'fitness', 'polygon'],
 170, false, 'active', NOW() + INTERVAL '7 days');

-- ============================================
-- VERIFICATION QUERIES
-- ============================================

SELECT '=== ALL 56 LISTINGS INSERTED ===' as status;
SELECT '' as blank;

SELECT 
  t.id as thread_id,
  t.title as thread_name,
  t.category,
  COUNT(l.id) as listing_count
FROM threads t
LEFT JOIN listings l ON t.id = l.thread_id
GROUP BY t.id, t.title, t.category
ORDER BY t.category, listing_count DESC;

SELECT '' as blank;

SELECT 
  category,
  COUNT(*) as total_listings,
  COUNT(*) FILTER (WHERE listing_type = 'for-sale') as for_sale,
  COUNT(*) FILTER (WHERE listing_type = 'want-to-buy') as wtb
FROM listings
GROUP BY category
ORDER BY category;

SELECT '' as blank;

SELECT 
  COUNT(*) as total_listings,
  COUNT(DISTINCT thread_id) as threads_with_listings,
  COUNT(DISTINCT user_id) as active_sellers
FROM listings;
 
