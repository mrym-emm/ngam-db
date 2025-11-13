INSERT INTO faqs (
    listing_id, question_user_id, answer_user_id, question, question_username,
    answer, answer_username, is_answered, is_accepted, helpful_count,
    not_helpful_count, created_at, updated_at, answered_at
)
VALUES
-- ===========================
-- FAQs for mmtest (user_id = 1)
-- ===========================

-- Listing 1: iPhone 14 Pro Max (Sale)
(1, 1, 1, 'Is the iPhone still under warranty?', 'mmtest',
 'Yes, the Apple warranty is valid until March 2026. I can provide proof of purchase upon request.',
 'mmtest', TRUE, FALSE, 0, 0, NOW(), NOW(), NOW()),
(1, 1, 1, 'Does it come with original accessories?', 'mmtest',
 'Yes, includes the original box, USB-C to Lightning cable, and a protective case.',
 'mmtest', TRUE, FALSE, 0, 0, NOW(), NOW(), NOW()),

-- Listing 2: Apple Watch Series 9 (Wanted)
(2, 1, 1, 'Are you only interested in the GPS + Cellular model?', 'mmtest',
 'Preferably yes, but I might consider the GPS-only version if it’s in excellent condition.',
 'mmtest', TRUE, FALSE, 0, 0, NOW(), NOW(), NOW()),
(2, 1, 1, 'Do you have a color preference?', 'mmtest',
 'Any color is fine, though Starlight or Midnight would be ideal.',
 'mmtest', TRUE, FALSE, 0, 0, NOW(), NOW(), NOW()),

-- Listing 3: iPad Air (Sale)
(3, 1, 1, 'Is the Magic Keyboard genuine Apple or third-party?', 'mmtest',
 'It’s the official Apple Magic Keyboard purchased from the Apple Store.',
 'mmtest', TRUE, FALSE, 0, 0, NOW(), NOW(), NOW()),
(3, 1, 1, 'Any scratches or dents on the iPad?', 'mmtest',
 'None at all — screen is pristine and the body has no marks.',
 'mmtest', TRUE, FALSE, 0, 0, NOW(), NOW(), NOW()),

-- Listing 4: MacBook Pro M3 (Wanted)
(4, 1, 1, 'Do you have a specific configuration in mind?', 'mmtest',
 'Minimum 16GB RAM and 512GB SSD. Open to higher specs as well.',
 'mmtest', TRUE, FALSE, 0, 0, NOW(), NOW(), NOW()),
(4, 1, 1, 'Are you open to refurbished units?', 'mmtest',
 'Only Apple Certified Refurbished or verified sellers with warranty.',
 'mmtest', TRUE, FALSE, 0, 0, NOW(), NOW(), NOW()),


-- ===============================
-- FAQs for loremduatest (user_id = 3)
-- ===============================

-- Listing 5: iPhone 14 Pro Max (Wanted)
(5, 3, 3, 'What color preferences do you have?', 'loremduatest',
 'Deep Purple preferred, but other colors like Silver or Gold are fine too.',
 'loremduatest', TRUE, FALSE, 0, 0, NOW(), NOW(), NOW()),
(5, 3, 3, 'Do you need the original box and cable?', 'loremduatest',
 'Original accessories are preferred but not mandatory.',
 'loremduatest', TRUE, FALSE, 0, 0, NOW(), NOW(), NOW()),

-- Listing 6: Apple Watch Series 9 (Sale)
(6, 3, 3, 'Is the watch still under warranty?', 'loremduatest',
 'Yes, it’s under Apple warranty until September 2026. Comes with receipt.',
 'loremduatest', TRUE, FALSE, 0, 0, NOW(), NOW(), NOW()),
(6, 3, 3, 'Any visible scratches on the body or display?', 'loremduatest',
 'No scratches at all — looks like new. Always used with a screen protector.',
 'loremduatest', TRUE, FALSE, 0, 0, NOW(), NOW(), NOW()),

-- Listing 7: iPad Air (Wanted)
(7, 3, 3, 'Would you consider other storage options?', 'loremduatest',
 'Yes, 64GB or 256GB would be acceptable depending on condition and price.',
 'loremduatest', TRUE, FALSE, 0, 0, NOW(), NOW(), NOW()),
(7, 3, 3, 'Do you require the Magic Keyboard included?', 'loremduatest',
 'Preferably yes, but willing to buy separately if the iPad is a good deal.',
 'loremduatest', TRUE, FALSE, 0, 0, NOW(), NOW(), NOW()),

-- Listing 8: MacBook Pro M3 (Sale)
(8, 3, 3, 'Any battery cycle count info?', 'loremduatest',
 'Battery cycle count is under 40, excellent health.',
 'loremduatest', TRUE, FALSE, 0, 0, NOW(), NOW(), NOW()),
(8, 3, 3, 'Does it include the original charger and box?', 'loremduatest',
 'Yes, both included and in great condition.',
 'loremduatest', TRUE, FALSE, 0, 0, NOW(), NOW(), NOW());
