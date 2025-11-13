
-- Match 1: User 1 wants iPhone 14 Pro Max (listing 7) ↔ User 2 sells iPhone 14 Pro Max (listing 3)
INSERT INTO recommendations (
    source_listing_id, target_listing_id, created_by_user_id, 
    recommendation_type, match_score, match_reasons, status, message,
    created_at, updated_at, expires_at
) VALUES (
    7, 3, NULL,
    'ai_match', 96, 
    '["Same product - iPhone 14 Pro Max 256GB", "Perfect model match", "Price range fits buyer budget ($4500-$5200 vs $5000-$5400)", "Both in Klang Valley area", "Verified seller"]',
    'pending',
    'AI detected a strong match between your wanted iPhone 14 Pro Max and this seller. Both users are verified and in nearby locations.',
    NOW(), NOW(), NOW() + INTERVAL '30 days'
);

-- Match 2: User 2 wants Apple Watch Series 9 (listing 4) ↔ User 1 sells Apple Watch Series 9 (listing 8)
INSERT INTO recommendations (
    source_listing_id, target_listing_id, created_by_user_id,
    recommendation_type, match_score, match_reasons, status, message,
    created_at, updated_at, expires_at
) VALUES (
    4, 8, NULL,
    'ai_match', 93,
    '["Same product - Apple Watch Series 9 GPS + Cellular", "Condition and price expectations align ($1600-$1900 vs $1700-$1900)", "Both users in Klang Valley", "Verified seller with original accessories"]',
    'pending',
    'AI matched your wanted Apple Watch Series 9 with a verified seller offering the exact model you need.',
    NOW(), NOW(), NOW() + INTERVAL '30 days'
);

-- Match 3: User 1 wants iPad Air (listing 9) ↔ User 2 sells iPad Air (listing 5)
INSERT INTO recommendations (
    source_listing_id, target_listing_id, created_by_user_id,
    recommendation_type, match_score, match_reasons, status, message,
    created_at, updated_at, expires_at
) VALUES (
    9, 5, NULL,
    'ai_match', 94,
    '["Same product - iPad Air (5th Gen, M1)", "Magic Keyboard included as requested", "Price within acceptable range ($2500-$3000 vs $2800-$3000)", "Space Gray color match", "Verified seller in Shah Alam"]',
    'pending',
    'AI found your iPad Air listing is a great match for this buyer request with Magic Keyboard included.',
    NOW(), NOW(), NOW() + INTERVAL '30 days'
);

-- Match 4: User 2 wants MacBook Pro M3 (listing 6) ↔ User 1 sells MacBook Pro M3 (listing 10)
INSERT INTO recommendations (
    source_listing_id, target_listing_id, created_by_user_id,
    recommendation_type, match_score, match_reasons, status, message,
    created_at, updated_at, expires_at
) VALUES (
    6, 10, NULL,
    'ai_match', 97,
    '["Exact match - MacBook Pro M3 14-inch", "Configuration matches buyer specs (16GB RAM, 512GB SSD)", "Price within budget ($8000-$9000 vs $8500-$9000)", "Verified seller", "Meet-up available in KL area"]',
    'pending',
    'AI found a high compatibility between your MacBook Pro M3 wanted listing and this verified seller in your area.',
    NOW(), NOW(), NOW() + INTERVAL '30 days'
);

-- Match 5: User 2 wants MATCHSPEL chair (listing 2) ↔ User 1 sells MATCHSPEL chair (listing 1)
INSERT INTO recommendations (
    source_listing_id, target_listing_id, created_by_user_id,
    recommendation_type, match_score, match_reasons, status, message,
    created_at, updated_at, expires_at
) VALUES (
    2, 1, NULL,
    'ai_match', 92,
    '["Same product - IKEA MATCHSPEL Gaming Chair", "Price within budget ($300-$400 vs $300-$390)", "Both in Shah Alam area for easy meet-up", "Verified seller", "Buyer accepts any color (seller has white)"]',
    'pending',
    'AI matched your wanted MATCHSPEL chair with a verified seller in Shah Alam. Meet-up available.',
    NOW(), NOW(), NOW() + INTERVAL '30 days'
);
