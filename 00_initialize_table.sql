
-- ============================================
-- NGAM MARKETPLACE - COMPLETE DATABASE SCHEMA
-- ============================================
-- Matches frontend data structures exactly
-- All users default to premium tier for demo

-- ============================================
-- 1. USERS & MEMBERSHIP
-- ============================================

CREATE TABLE user_tiers (
    id VARCHAR(20) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT,
    features JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert default tiers (everyone gets premium for demo)
INSERT INTO user_tiers (id, name, description, features) VALUES
('free', 'Free', 'Basic marketplace access', '["basic_listing", "basic_messaging"]'),
('premium', 'Premium', 'Full access to all features', '["unlimited_listings", "ai_matching", "priority_support", "analytics"]');

CREATE TABLE users (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    verified BOOLEAN DEFAULT FALSE,
    rating DECIMAL(3, 2) DEFAULT 0.0,
    rating_count INTEGER DEFAULT 0,
    total_listings INTEGER DEFAULT 0,
    completed_deals INTEGER DEFAULT 0,
    avatar TEXT,
    tier_id VARCHAR(20) DEFAULT 'premium' REFERENCES user_tiers(id),
    joined_date VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_tier ON users(tier_id);

-- ============================================
-- 2. COMMUNITY THREADS (FORUM CATEGORIES)
-- ============================================

CREATE TABLE threads (
    id SERIAL PRIMARY KEY,
    creator_id VARCHAR(50) NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    image_url TEXT,
    comments INTEGER DEFAULT 0,
    views INTEGER DEFAULT 0,
    upvotes INTEGER DEFAULT 0,
    current_tokens INTEGER DEFAULT 0,
    goal_tokens INTEGER DEFAULT 0,
    tags JSONB,
    is_pinned BOOLEAN DEFAULT FALSE,
    is_hot BOOLEAN DEFAULT FALSE,
    time_ago VARCHAR(50),
    contributions INTEGER DEFAULT 0,
    category VARCHAR(100),
    online_users INTEGER DEFAULT 0,
    total_users INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_threads_creator ON threads(creator_id);
CREATE INDEX idx_threads_category ON threads(category);
CREATE INDEX idx_threads_pinned ON threads(is_pinned);
CREATE INDEX idx_threads_hot ON threads(is_hot);

-- ============================================
-- 3. LISTINGS & FAQS
-- ============================================

CREATE TABLE listings (
    id VARCHAR(50) PRIMARY KEY,
    user_id VARCHAR(50) NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    thread_id INTEGER REFERENCES threads(id) ON DELETE SET NULL,
    title VARCHAR(255) NOT NULL,
    subtitle VARCHAR(255),
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'MYR',
    category VARCHAR(100) NOT NULL,
    listing_type VARCHAR(20) NOT NULL, -- 'sale' or 'wanted'
    image_url TEXT,
    gallery JSONB, -- array of image URLs
    tags JSONB, -- array of tags
    views INTEGER DEFAULT 0,
    protected BOOLEAN DEFAULT FALSE,
    seller_name VARCHAR(100),
    seller_location VARCHAR(100),
    seller_verified BOOLEAN DEFAULT FALSE,
    time_posted VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_listings_user ON listings(user_id);
CREATE INDEX idx_listings_thread ON listings(thread_id);
CREATE INDEX idx_listings_category ON listings(category);
CREATE INDEX idx_listings_type ON listings(listing_type);
CREATE INDEX idx_listings_protected ON listings(protected);

CREATE TABLE listing_faqs (
    id SERIAL PRIMARY KEY,
    listing_id VARCHAR(50) NOT NULL REFERENCES listings(id) ON DELETE CASCADE,
    question TEXT NOT NULL,
    answer TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_listing_faqs_listing ON listing_faqs(listing_id);

-- ============================================
-- 4. LIKES & MATCHES
-- ============================================

CREATE TABLE likes (
    id VARCHAR(50) PRIMARY KEY,
    user_id VARCHAR(50) NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    listing_id VARCHAR(50) NOT NULL REFERENCES listings(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, listing_id)
);

CREATE INDEX idx_likes_user ON likes(user_id);
CREATE INDEX idx_likes_listing ON likes(listing_id);

CREATE TABLE matches (
    id VARCHAR(50) PRIMARY KEY,
    user_id VARCHAR(50) NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    user_listing_id VARCHAR(50) NOT NULL REFERENCES listings(id) ON DELETE CASCADE,
    matched_listing_id VARCHAR(50) NOT NULL REFERENCES listings(id) ON DELETE CASCADE,
    score INTEGER NOT NULL,
    match_quality VARCHAR(20) NOT NULL, -- 'excellent', 'good', 'possible'
    match_reasons JSONB, -- array of reasons
    distance VARCHAR(50),
    status VARCHAR(20) DEFAULT 'new', -- 'new', 'contacted', 'dismissed'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_matches_user ON matches(user_id);
CREATE INDEX idx_matches_user_listing ON matches(user_listing_id);
CREATE INDEX idx_matches_matched_listing ON matches(matched_listing_id);
CREATE INDEX idx_matches_status ON matches(status);

-- ============================================
-- 5. USER-TO-USER MESSAGING
-- ============================================

CREATE TABLE conversations (
    id VARCHAR(50) PRIMARY KEY,
    participant_1_id VARCHAR(50) NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    participant_2_id VARCHAR(50) NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    listing_id VARCHAR(50) REFERENCES listings(id) ON DELETE SET NULL,
    last_message_at TIMESTAMP,
    unread_count INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_conversations_participant1 ON conversations(participant_1_id);
CREATE INDEX idx_conversations_participant2 ON conversations(participant_2_id);
CREATE INDEX idx_conversations_listing ON conversations(listing_id);

CREATE TABLE messages (
    id VARCHAR(50) PRIMARY KEY,
    conversation_id VARCHAR(50) NOT NULL REFERENCES conversations(id) ON DELETE CASCADE,
    sender_id VARCHAR(50) NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    receiver_id VARCHAR(50) NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    listing_id VARCHAR(50) REFERENCES listings(id) ON DELETE SET NULL,
    content TEXT NOT NULL,
    read BOOLEAN DEFAULT FALSE,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_messages_conversation ON messages(conversation_id);
CREATE INDEX idx_messages_sender ON messages(sender_id);
CREATE INDEX idx_messages_receiver ON messages(receiver_id);
CREATE INDEX idx_messages_read ON messages(read);

-- ============================================
-- 6. AI CHAT ASSISTANT
-- ============================================

CREATE TABLE ai_chat_sessions (
    id VARCHAR(50) PRIMARY KEY,
    user_id VARCHAR(50) NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    title VARCHAR(255),
    timestamp VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_ai_chat_sessions_user ON ai_chat_sessions(user_id);

CREATE TABLE ai_chat_messages (
    id SERIAL PRIMARY KEY,
    session_id VARCHAR(50) NOT NULL REFERENCES ai_chat_sessions(id) ON DELETE CASCADE,
    role VARCHAR(20) NOT NULL, -- 'user' or 'assistant'
    content TEXT NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_ai_chat_messages_session ON ai_chat_messages(session_id);

-- ============================================
-- 7. ACHIEVEMENTS & ACTIVITIES
-- ============================================

CREATE TABLE achievements (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    icon VARCHAR(50),
    category VARCHAR(50), -- 'trading', 'social', 'milestone', 'special'
    requirement TEXT,
    progress INTEGER DEFAULT 0,
    total INTEGER,
    unlocked BOOLEAN DEFAULT FALSE,
    unlocked_date TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_achievements_category ON achievements(category);
CREATE INDEX idx_achievements_unlocked ON achievements(unlocked);

CREATE TABLE activities (
    id SERIAL PRIMARY KEY,
    user_id VARCHAR(50) NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    type VARCHAR(50) NOT NULL, -- 'sale', 'purchase', 'achievement', 'alert'
    message TEXT NOT NULL,
    date VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_activities_user ON activities(user_id);
CREATE INDEX idx_activities_type ON activities(type);

-- ============================================
-- End of Schema
-- ============================================
