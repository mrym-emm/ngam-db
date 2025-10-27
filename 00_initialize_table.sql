-- ============================================
-- OPTIMIZED DATABASE SCHEMA - FRONTEND ALIGNED
-- Based on actual mock data usage analysis
-- ============================================

-- ============================================
-- STEP 1: DROP ALL TABLES
-- ============================================
DROP TABLE IF EXISTS achievements CASCADE;
DROP TABLE IF EXISTS activities CASCADE;
DROP TABLE IF EXISTS ai_chat_messages CASCADE;
DROP TABLE IF EXISTS ai_chat_sessions CASCADE;
DROP TABLE IF EXISTS listing_faqs CASCADE;
DROP TABLE IF EXISTS faq_answers CASCADE;
DROP TABLE IF EXISTS listing_matches CASCADE;
DROP TABLE IF EXISTS messages CASCADE;
DROP TABLE IF EXISTS listings CASCADE;
DROP TABLE IF EXISTS threads CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- ============================================
-- STEP 2: CREATE TABLES
-- ============================================

 ============================================================================
-- NGAM-JE DATABASE SCHEMA
-- Based on mock data structure from frontend refactoring
-- Designed for 2-user platform (Fitri and Sani)
-- ============================================================================

-- ============================================================================
-- USERS TABLE
-- ============================================================================
CREATE TABLE users (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    verified BOOLEAN DEFAULT FALSE,
    rating DECIMAL(3,2) DEFAULT 0.00,
    rating_count INT DEFAULT 0,
    total_listings INT DEFAULT 0,
    completed_deals INT DEFAULT 0,
    avatar_url TEXT,
    joined_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ============================================================================
-- LISTINGS TABLE (Unified - both Sale and Wanted)
-- ============================================================================
CREATE TABLE listings (
    id VARCHAR(50) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    subtitle VARCHAR(255),
    description TEXT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    currency VARCHAR(10) DEFAULT 'MYR',

    -- Foreign key to users
    user_id VARCHAR(50) NOT NULL,

    -- Denormalized seller info (for quick display, but user_id is source of truth)
    seller_name VARCHAR(100) NOT NULL,
    seller_location VARCHAR(100) NOT NULL,
    seller_verified BOOLEAN DEFAULT FALSE,

    -- Media
    image_url TEXT,
    gallery JSON,  -- Array of image URLs

    -- Category and type
    category VARCHAR(50) NOT NULL,
    listing_type ENUM('sale', 'wanted') NOT NULL,

    -- Metadata
    tags JSON,  -- Array of tags
    views INT DEFAULT 0,
    protected BOOLEAN DEFAULT FALSE,

    -- Timestamps
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    expires_at TIMESTAMP,

    -- Indexes
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_category (category),
    INDEX idx_listing_type (listing_type),
    INDEX idx_created_at (created_at)
);

-- ============================================================================
-- THREADS/COMMUNITIES TABLE
-- ============================================================================
CREATE TABLE threads (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    image_url TEXT,
    comments INT DEFAULT 0,
    views INT DEFAULT 0,
    upvotes INT DEFAULT 0,
    current_tokens INT DEFAULT 0,
    goal_tokens INT DEFAULT 0,
    is_pinned BOOLEAN DEFAULT FALSE,
    is_hot BOOLEAN DEFAULT FALSE,
    contributions INT DEFAULT 0,
    category VARCHAR(50) NOT NULL,
    online_users INT DEFAULT 0,
    total_users INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    INDEX idx_category (category),
    INDEX idx_is_pinned (is_pinned),
    INDEX idx_is_hot (is_hot)
);

-- ============================================================================
-- THREAD TAGS TABLE (Many-to-Many relationship)
-- ============================================================================
CREATE TABLE thread_tags (
    thread_id INT NOT NULL,
    tag VARCHAR(50) NOT NULL,
    PRIMARY KEY (thread_id, tag),
    FOREIGN KEY (thread_id) REFERENCES threads(id) ON DELETE CASCADE,
    INDEX idx_tag (tag)
);

-- ============================================================================
-- MESSAGES/CONVERSATIONS TABLE
-- ============================================================================
CREATE TABLE conversations (
    id VARCHAR(50) PRIMARY KEY,
    user1_id VARCHAR(50) NOT NULL,
    user2_id VARCHAR(50) NOT NULL,
    listing_id VARCHAR(50),  -- Optional: if conversation is about a specific listing
    last_message TEXT,
    last_message_time TIMESTAMP,
    unread_count_user1 INT DEFAULT 0,
    unread_count_user2 INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (user1_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (user2_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (listing_id) REFERENCES listings(id) ON DELETE SET NULL,
    INDEX idx_user1 (user1_id),
    INDEX idx_user2 (user2_id),
    INDEX idx_listing (listing_id)
);

-- ============================================================================
-- MESSAGES TABLE
-- ============================================================================
CREATE TABLE messages (
    id VARCHAR(50) PRIMARY KEY,
    conversation_id VARCHAR(50) NOT NULL,
    sender_id VARCHAR(50) NOT NULL,
    content TEXT NOT NULL,
    product_info JSON,  -- Optional: product card info
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (conversation_id) REFERENCES conversations(id) ON DELETE CASCADE,
    FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_conversation (conversation_id),
    INDEX idx_created_at (created_at)
);

-- ============================================================================
-- ACHIEVEMENTS TABLE
-- ============================================================================
CREATE TABLE achievements (
    id VARCHAR(50) PRIMARY KEY,
    label VARCHAR(100) NOT NULL,
    description TEXT,
    icon VARCHAR(50),  -- Icon name from lucide-react
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================================
-- USER ACHIEVEMENTS TABLE (Many-to-Many)
-- ============================================================================
CREATE TABLE user_achievements (
    user_id VARCHAR(50) NOT NULL,
    achievement_id VARCHAR(50) NOT NULL,
    unlocked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, achievement_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (achievement_id) REFERENCES achievements(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_unlocked_at (unlocked_at)
);

-- ============================================================================
-- ACTIVITIES TABLE (User activity log)
-- ============================================================================
CREATE TABLE activities (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id VARCHAR(50) NOT NULL,
    type ENUM('sale', 'purchase', 'achievement', 'alert') NOT NULL,
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_type (type),
    INDEX idx_created_at (created_at)
);

-- ============================================================================
-- LISTING MATCHES TABLE
-- ============================================================================
CREATE TABLE listing_matches (
    id VARCHAR(50) PRIMARY KEY,
    your_listing_id VARCHAR(50) NOT NULL,
    matched_listing_id VARCHAR(50) NOT NULL,
    match_score INT NOT NULL,  -- 0-100
    match_quality ENUM('excellent', 'good', 'possible') NOT NULL,
    status ENUM('new', 'contacted', 'dismissed') DEFAULT 'new',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (your_listing_id) REFERENCES listings(id) ON DELETE CASCADE,
    FOREIGN KEY (matched_listing_id) REFERENCES listings(id) ON DELETE CASCADE,
    INDEX idx_your_listing (your_listing_id),
    INDEX idx_matched_listing (matched_listing_id),
    INDEX idx_match_score (match_score)
);

-- ============================================================================
-- LISTING MATCH REASONS TABLE (Many match reasons per match)
-- ============================================================================
CREATE TABLE listing_match_reasons (
    match_id VARCHAR(50) NOT NULL,
    type ENUM('category', 'price', 'location', 'keyword', 'timing') NOT NULL,
    label VARCHAR(100) NOT NULL,
    matched BOOLEAN NOT NULL,
    details TEXT,
    PRIMARY KEY (match_id, type),
    FOREIGN KEY (match_id) REFERENCES listing_matches(id) ON DELETE CASCADE
);

-- ============================================================================
-- FAQ TABLE
-- ============================================================================
CREATE TABLE listing_faqs (
    id VARCHAR(50) PRIMARY KEY,
    listing_id VARCHAR(50) NOT NULL,
    question TEXT NOT NULL,
    description TEXT,
    is_answered_by_poster BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (listing_id) REFERENCES listings(id) ON DELETE CASCADE,
    INDEX idx_listing_id (listing_id)
);

-- ============================================================================
-- FAQ ANSWERS TABLE
-- ============================================================================
CREATE TABLE faq_answers (
    id VARCHAR(50) PRIMARY KEY,
    question_id VARCHAR(50) NOT NULL,
    user_id VARCHAR(50) NOT NULL,
    text TEXT NOT NULL,
    is_accepted BOOLEAN DEFAULT FALSE,
    likes INT DEFAULT 0,
    dislikes INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (question_id) REFERENCES listing_faqs(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_question_id (question_id)
);

-- ============================================================================
-- FAQ ANSWER REPLIES TABLE (Nested replies)
-- ============================================================================
CREATE TABLE faq_replies (
    id VARCHAR(50) PRIMARY KEY,
    answer_id VARCHAR(50) NOT NULL,
    parent_reply_id VARCHAR(50),  -- NULL if top-level reply, otherwise parent reply
    user_id VARCHAR(50) NOT NULL,
    text TEXT NOT NULL,
    likes INT DEFAULT 0,
    dislikes INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (answer_id) REFERENCES faq_answers(id) ON DELETE CASCADE,
    FOREIGN KEY (parent_reply_id) REFERENCES faq_replies(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_answer_id (answer_id),
    INDEX idx_parent_reply_id (parent_reply_id)
);

-- ============================================================================
-- CHAT HISTORY TABLE (AI chat sessions)
-- ============================================================================
CREATE TABLE chat_history (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id VARCHAR(50) NOT NULL,
    title VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_created_at (created_at)
);

-- ============================================================================
-- CHAT MESSAGES TABLE
-- ============================================================================
CREATE TABLE chat_messages (
    id VARCHAR(50) PRIMARY KEY,
    chat_id INT NOT NULL,
    role ENUM('user', 'assistant') NOT NULL,
    content TEXT NOT NULL,
    tool_calls JSON,  -- Array of tool call objects
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (chat_id) REFERENCES chat_history(id) ON DELETE CASCADE,
    INDEX idx_chat_id (chat_id),
    INDEX idx_created_at (created_at)
);

-- ============================================================================
-- SEED DATA FOR 2 USERS (Fitri and Sani)
-- ============================================================================
INSERT INTO users (id, name, email, password_hash, verified, rating, rating_count, total_listings, completed_deals, joined_date) VALUES
('user-1', 'Fitri', 'fitri@example.com', 'password1', TRUE, 4.8, 32, 36, 45, '2024-01-15'),
('user-2', 'Sani', 'sani@example.com', 'password2', TRUE, 4.9, 28, 36, 38, '2023-12-10');

-- Note: Listings, threads, and other data would be migrated from mock-all-data-used.ts

