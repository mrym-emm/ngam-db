INSERT INTO listings (
    user_id, thread_id, title, description, price, min_price, max_price, currency,
    listing_type, image_url, gallery, tags, views, protected, creator_name,
    creator_location, creator_verified, shipping_options, inventory_quantity,
    ownership_proof_url, is_active, is_matched, created_at, updated_at
)
VALUES
-- 1. For Sale: iPhone 14 Pro Max
(1, 1, 'iPhone 14 Pro Max 256GB (Deep Purple) for Sale',
 'Selling my iPhone 14 Pro Max 256GB in Deep Purple. Excellent condition with 95% battery health. Comes with box, cable, and case. No scratches or dents.',
 5200, 5000, 5400, 'MYR', 'sale',
 'https://images.unsplash.com/photo-1701680848891-89a6a4e9e31a?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
 '["https://images.unsplash.com/photo-1680687688158-e9165395ff00?q=80&w=764&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", "https://images.unsplash.com/photo-1697898734230-705d8fc551e9?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fGlwaG9uZSUyMDE0JTIwcHJvJTIwbWF4fGVufDB8fDB8fHww"]',
 '["Apple", "iPhone", "iPhone 14 Pro Max", "Smartphone", "Electronics", "Mobile"]',
 4, FALSE, 'mmtest', 'Shah Alam', TRUE,
 '["Nationwide shipping", "Meet-up available"]', 1, NULL, TRUE, FALSE, NOW(), NOW()),

-- 2. Wanted: Apple Watch Series 9
(1, 1, 'Looking for Apple Watch Series 9',
 'Looking to buy an Apple Watch Series 9 in good or like-new condition. Prefer GPS + Cellular model, any color. Original box and accessories preferred.',
 1800, 1600, 1900, 'MYR', 'wanted',
 'https://images.unsplash.com/photo-1579586337278-3befd40fd17a?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8YXBwbGUlMjB3YXRjaHxlbnwwfHwwfHx8MA%3D%3D',
 '["https://images.unsplash.com/photo-1551816230-ef5deaed4a26?q=80&w=765&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", "https://images.unsplash.com/photo-1558126319-c9feecbf57ee?q=80&w=1332&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"]',
 '["Apple", "Watch", "Apple Watch Series 9", "Wearable", "Fitness", "Electronics"]',
 3, FALSE, 'mmtest', 'Shah Alam', TRUE,
 '["Nationwide shipping", "Meet-up in Klang Valley"]', NULL, NULL, TRUE, FALSE, NOW(), NOW()),

-- 3. For Sale: iPad Air (5th Gen) with Magic Keyboard
(1, 1, 'iPad Air (5th Gen) + Magic Keyboard Combo',
 'Selling my iPad Air (5th Gen, M1, 64GB, Space Gray) with Magic Keyboard. Perfect condition, used for light work. Comes with box and charger.',
 2900, 2800, 3000, 'MYR', 'sale',
 'https://images.unsplash.com/photo-1648806030599-c963fd14a22f?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aXBhZCUyMGFpcnxlbnwwfHwwfHx8MA%3D%3D',
 '["https://images.unsplash.com/photo-1630331528526-7d04c6eb463f?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8aXBhZCUyMGFpcnxlbnwwfHwwfHx8MA%3D%3D", "https://images.unsplash.com/photo-1682427286841-1f3ff788752b?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8aXBhZCUyMGFpcnxlbnwwfHwwfHx8MA%3D%3D"]',
 '["Apple", "iPad Air", "Tablet", "M1", "Magic Keyboard", "Electronics", "Productivity"]',
 5, FALSE, 'mmtest', 'Shah Alam', TRUE,
 '["Nationwide shipping", "COD available"]', 1, NULL, TRUE, FALSE, NOW(), NOW()),

-- 4. Wanted: MacBook Pro M3 (14-inch)
(1, 1, 'Looking for MacBook Pro M3 14-inch',
 'In search of a MacBook Pro M3 (14-inch) for professional work. Minimum specs: 16GB RAM and 512GB SSD. Open to reasonable offers. Prefer verified sellers.',
 8500, 8000, 9000, 'MYR', 'wanted',
 'https://images.unsplash.com/photo-1531297484001-80022131f5a1?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8bWFjYm9va3xlbnwwfHwwfHx8MA%3D%3D',
 '["https://images.unsplash.com/photo-1517336714731-489689fd1ca8?q=80&w=1026&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", "https://images.unsplash.com/photo-1541807084-5c52b6b3adef?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8bWFjYm9va3xlbnwwfHwwfHx8MA%3D%3D"]',
 '["Apple", "MacBook Pro", "Laptop", "M3", "Mac", "Electronics", "Professional"]',
 2, FALSE, 'mmtest', 'Shah Alam', TRUE,
 '["Nationwide shipping", "Meet-up in Petaling Jaya"]', NULL, NULL, TRUE, FALSE, NOW(), NOW()),

(3, 1, 'Looking for iPhone 14 Pro Max 256GB',
 'Looking to purchase an iPhone 14 Pro Max 256GB in Deep Purple or other colors. Must be in excellent condition with original box and cable preferred.',
 5000, 4500, 5200, 'MYR', 'wanted',
 'https://images.unsplash.com/photo-1632560354926-21886c0e811c?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fGlwaG9uZSUyMDE0fGVufDB8MHw0fHx8MA%3D%3D',
 '["https://images.unsplash.com/photo-1632582593957-e28f748ba619?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fGlwaG9uZSUyMDE0fGVufDB8MHw0fHx8MA%3D%3D", "https://plus.unsplash.com/premium_photo-1680985551022-ad298e8a5f82?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8aXBob25lJTIwMTR8ZW58MHwwfDR8fHww"]',
 '["Apple", "iPhone", "iPhone 14 Pro Max", "Smartphone", "Electronics", "Mobile"]',
 0, FALSE, 'loremduatest', 'Kuala Lumpur', TRUE,
 '["Nationwide shipping", "Meet-up available"]', NULL, NULL, TRUE, FALSE, NOW(), NOW()),

-- 2️⃣ Opposite of Apple Watch Series 9 (was wanted → now sale)
(3, 1, 'Apple Watch Series 9 GPS + Cellular for Sale',
 'Selling my Apple Watch Series 9 GPS + Cellular in Starlight. Excellent condition with minimal wear. Comes with original box and charger.',
 1850, 1700, 1900, 'MYR', 'sale',
 'https://images.unsplash.com/photo-1614106765035-bceac4ac1911?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fGFwcGxlJTIwd2F0Y2h8ZW58MHx8MHx8fDA%3D',
 '["https://images.unsplash.com/photo-1598516802414-50a01bee818d?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fGFwcGxlJTIwd2F0Y2h8ZW58MHx8MHx8fDA%3D", "https://images.unsplash.com/photo-1597923709001-5a061c88418d?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fGFwcGxlJTIwd2F0Y2h8ZW58MHx8MHx8fDA%3D"]',
 '["Apple", "Watch", "Apple Watch Series 9", "Wearable", "Fitness", "Electronics"]',
 0, FALSE, 'loremduatest', 'Kuala Lumpur', TRUE,
 '["Nationwide shipping", "Meet-up in Klang Valley"]', 1, NULL, TRUE, FALSE, NOW(), NOW()),

-- 3️⃣ Opposite of iPad Air + Magic Keyboard (was sale → now wanted)
(3, 1, 'Looking for iPad Air (5th Gen) with Magic Keyboard',
 'Searching for an iPad Air (5th Gen, M1) with Magic Keyboard. Prefer Space Gray color, like-new condition, and original accessories included.',
 2800, 2500, 3000, 'MYR', 'wanted',
 'https://images.unsplash.com/photo-1542751110-97427bbecf20?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fGlwYWR8ZW58MHx8MHx8fDA%3D',
 '["https://images.unsplash.com/photo-1546868871-0f936769675e?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fGlwYWR8ZW58MHx8MHx8fDA%3D", "https://images.unsplash.com/photo-1585770536735-27993a080586?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fGlwYWR8ZW58MHx8MHx8fDA%3D"]',
 '["Apple", "iPad Air", "Tablet", "M1", "Magic Keyboard", "Electronics", "Productivity"]',
 0, FALSE, 'loremduatest', 'Kuala Lumpur', TRUE,
 '["Nationwide shipping", "Meet-up available"]', NULL, NULL, TRUE, FALSE, NOW(), NOW()),

-- 4️⃣ Opposite of MacBook Pro M3 (was wanted → now sale)
(3, 1, 'MacBook Pro M3 14-inch for Sale',
 'Selling my MacBook Pro M3 14-inch (16GB RAM, 512GB SSD). Perfect for creative and professional use. In pristine condition, includes charger and box.',
 8700, 8500, 9000, 'MYR', 'sale',
 'https://images.unsplash.com/photo-1605784401368-5af1d9d6c4dc?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fG1hY2Jvb2t8ZW58MHx8MHx8fDA%3D',
 '["https://images.unsplash.com/photo-1651241680016-cc9e407e7dc3?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fG1hY2Jvb2t8ZW58MHx8MHx8fDA%3D", "https://images.unsplash.com/photo-1420406676079-b8491f2d07c8?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fG1hY2Jvb2t8ZW58MHx8MHx8fDA%3D"]',
 '["Apple", "MacBook Pro", "Laptop", "M3", "Mac", "Electronics", "Professional"]',
 0, FALSE, 'loremduatest', 'Kuala Lumpur', TRUE,
 '["Nationwide shipping", "Meet-up available"]', 1, NULL, TRUE, FALSE, NOW(), NOW());

