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
 '["Nationwide shipping", "Meet-up in Petaling Jaya"]', NULL, NULL, TRUE, FALSE, NOW(), NOW());
