-- ============================================
-- NGAM-JE Database Schema
-- PostgreSQL / MySQL Compatible
-- ============================================

-- Users Table
-- Stores platform users (buyers and sellers)
CREATE TABLE users (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    bio TEXT,
    location VARCHAR(100),
    avatar_url TEXT,
    joined_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_users_email ON users(email);

-- ============================================

-- Listings Table
-- Core marketplace listings (buy and sell)
CREATE TABLE listings (
    id SERIAL PRIMARY KEY,
    user_id VARCHAR(50) NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    category VARCHAR(100) NOT NULL,
    condition VARCHAR(50),
    status VARCHAR(50) DEFAULT 'active', -- active, matched, sold, expired
    listing_type VARCHAR(20) NOT NULL, -- 'buy' or 'sell'
    image_url TEXT,
    is_matched BOOLEAN DEFAULT FALSE,
    time_posted TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_listings_user_id ON listings(user_id);
CREATE INDEX idx_listings_category ON listings(category);
CREATE INDEX idx_listings_status ON listings(status);
CREATE INDEX idx_listings_type ON listings(listing_type);
CREATE INDEX idx_listings_is_matched ON listings(is_matched);

-- ============================================

-- Tags Table
-- Stores listing tags for filtering/search
CREATE TABLE tags (
    id SERIAL PRIMARY KEY,
    listing_id INTEGER NOT NULL REFERENCES listings(id) ON DELETE CASCADE,
    tag_name VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_tags_listing_id ON tags(listing_id);
CREATE INDEX idx_tags_name ON tags(tag_name);

-- ============================================

-- Matches Table
-- Tracks matched buy/sell listings
CREATE TABLE matches (
    id SERIAL PRIMARY KEY,
    buy_listing_id INTEGER NOT NULL REFERENCES listings(id) ON DELETE CASCADE,
    sell_listing_id INTEGER NOT NULL REFERENCES listings(id) ON DELETE CASCADE,
    buyer_id VARCHAR(50) NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    seller_id VARCHAR(50) NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    match_score DECIMAL(5, 2), -- 0.00 to 100.00
    status VARCHAR(50) DEFAULT 'pending', -- pending, accepted, rejected, completed
    matched_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(buy_listing_id, sell_listing_id)
);

CREATE INDEX idx_matches_buyer ON matches(buyer_id);
CREATE INDEX idx_matches_seller ON matches(seller_id);
CREATE INDEX idx_matches_status ON matches(status);

-- ============================================

-- Threads Table
-- Conversation threads between users
CREATE TABLE threads (
    id VARCHAR(50) PRIMARY KEY,
    listing_id INTEGER REFERENCES listings(id) ON DELETE SET NULL,
    participant_1_id VARCHAR(50) NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    participant_2_id VARCHAR(50) NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    last_message TEXT,
    last_message_time TIMESTAMP,
    unread_count INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_threads_participant_1 ON threads(participant_1_id);
CREATE INDEX idx_threads_participant_2 ON threads(participant_2_id);
CREATE INDEX idx_threads_listing ON threads(listing_id);

-- ============================================

-- Messages Table
-- Individual messages within threads
CREATE TABLE messages (
    id SERIAL PRIMARY KEY,
    thread_id VARCHAR(50) NOT NULL REFERENCES threads(id) ON DELETE CASCADE,
    sender_id VARCHAR(50) NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_messages_thread ON messages(thread_id);
CREATE INDEX idx_messages_sender ON messages(sender_id);
CREATE INDEX idx_messages_read ON messages(is_read);

-- ============================================

-- Achievements Table
-- User achievement/badge system
CREATE TABLE achievements (
    id VARCHAR(50) PRIMARY KEY,
    user_id VARCHAR(50) NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    icon VARCHAR(50),
    earned_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_achievements_user ON achievements(user_id);

-- ============================================

-- Activities Table
-- User activity feed/history
CREATE TABLE activities (
    id SERIAL PRIMARY KEY,
    user_id VARCHAR(50) NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    activity_type VARCHAR(50) NOT NULL, -- listing_created, offer_made, match_found, etc.
    title VARCHAR(255) NOT NULL,
    description TEXT,
    related_listing_id INTEGER REFERENCES listings(id) ON DELETE SET NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_activities_user ON activities(user_id);
CREATE INDEX idx_activities_type ON activities(activity_type);
CREATE INDEX idx_activities_timestamp ON activities(timestamp);

-- ============================================

-- FAQs Table
-- Frequently asked questions
CREATE TABLE faqs (
    id SERIAL PRIMARY KEY,
    listing_id INTEGER NOT NULL REFERENCES listings(id) ON DELETE CASCADE,
    user_id VARCHAR(50) NOT NULL REFERENCES users(id) ON DELETE CASCADE, -- who asked the question
    question TEXT NOT NULL,
    answer TEXT,
    is_answered BOOLEAN DEFAULT FALSE,
    asked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    answered_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_faqs_listing ON faqs(listing_id);
CREATE INDEX idx_faqs_user ON faqs(user_id);
CREATE INDEX idx_faqs_answered ON faqs(is_answered);

-- ============================================

-- Chat History Table (Alternative structure for sidebar chat)
CREATE TABLE chat_history (
    id VARCHAR(50) PRIMARY KEY,
    user_id VARCHAR(50) NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    other_user_id VARCHAR(50) NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    last_message TEXT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_read BOOLEAN DEFAULT FALSE,
    avatar_url TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_chat_history_user ON chat_history(user_id);
CREATE INDEX idx_chat_history_other_user ON chat_history(other_user_id);

-- ============================================
-- End of Schema
-- ============================================
