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

-- 1. USERS
CREATE TABLE users (
  id TEXT PRIMARY KEY,
  full_name TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  avatar_url TEXT,
  is_verified BOOLEAN DEFAULT false,
  seller_rating DECIMAL(3,2) DEFAULT 0.00,
  rating_count INTEGER DEFAULT 0,
  total_listings INTEGER DEFAULT 0,
  completed_deals INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_rating ON users(seller_rating);

-- 2. THREADS (Communities/Categories)
CREATE TABLE threads (
  id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  image_url TEXT,
  category TEXT NOT NULL,
  tags TEXT[],
  comments_count INTEGER DEFAULT 0,
  views_count INTEGER DEFAULT 0,
  upvotes_count INTEGER DEFAULT 0,
  current_tokens INTEGER DEFAULT 0,
  goal_tokens INTEGER DEFAULT 0,
  contributions_count INTEGER DEFAULT 0,
  is_pinned BOOLEAN DEFAULT false,
  is_hot BOOLEAN DEFAULT false,
  time_ago TEXT,
  online_users INTEGER DEFAULT 0,
  total_users INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_threads_category ON threads(category);
CREATE INDEX idx_threads_is_hot ON threads(is_hot);
CREATE INDEX idx_threads_is_pinned ON threads(is_pinned);

-- 3. LISTINGS
CREATE TABLE listings (
  id TEXT PRIMARY KEY,
  thread_id TEXT NOT NULL REFERENCES threads(id) ON DELETE CASCADE,
  user_id TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  price DECIMAL(10,2),
  budget DECIMAL(10,2),
  location TEXT NOT NULL,
  timestamp TEXT NOT NULL,
  image_url TEXT,
  views_count INTEGER DEFAULT 0,
  likes_count INTEGER DEFAULT 0,
  category TEXT NOT NULL,
  expires_at TIMESTAMPTZ NOT NULL,
  subscription_tier TEXT DEFAULT 'basic' CHECK (subscription_tier IN ('basic', 'pro', 'enterprise')),
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_listings_thread_id ON listings(thread_id);
CREATE INDEX idx_listings_user_id ON listings(user_id);
CREATE INDEX idx_listings_category ON listings(category);
CREATE INDEX idx_listings_expires_at ON listings(expires_at);

-- 4. LISTING MATCHES
CREATE TABLE listing_matches (
  id TEXT PRIMARY KEY,
  source_listing_id TEXT NOT NULL REFERENCES listings(id) ON DELETE CASCADE,
  matched_listing_id TEXT NOT NULL REFERENCES listings(id) ON DELETE CASCADE,
  match_score INTEGER NOT NULL CHECK (match_score >= 0 AND match_score <= 100),
  match_quality TEXT NOT NULL CHECK (match_quality IN ('excellent', 'good', 'possible')),
  match_reasons JSONB NOT NULL,
  distance TEXT,
  price_compatible BOOLEAN DEFAULT false,
  location_compatible BOOLEAN DEFAULT false,
  category_compatible BOOLEAN DEFAULT false,
  status TEXT DEFAULT 'new' CHECK (status IN ('new', 'contacted', 'dismissed')),
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_listing_matches_source ON listing_matches(source_listing_id);
CREATE INDEX idx_listing_matches_matched ON listing_matches(matched_listing_id);
CREATE INDEX idx_listing_matches_score ON listing_matches(match_score DESC);
CREATE INDEX idx_listing_matches_status ON listing_matches(status);
CREATE UNIQUE INDEX idx_listing_matches_unique ON listing_matches(source_listing_id, matched_listing_id);

-- 5. LISTING FAQS (Questions)
CREATE TABLE listing_faqs (
  id TEXT PRIMARY KEY,
  listing_id TEXT NOT NULL REFERENCES listings(id) ON DELETE CASCADE,
  user_id TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  question TEXT NOT NULL,
  description TEXT,
  is_answered_by_poster BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_listing_faqs_listing ON listing_faqs(listing_id);
CREATE INDEX idx_listing_faqs_user ON listing_faqs(user_id);

-- 6. FAQ ANSWERS (Including Replies)
CREATE TABLE faq_answers (
  id TEXT PRIMARY KEY,
  faq_id TEXT NOT NULL REFERENCES listing_faqs(id) ON DELETE CASCADE,
  parent_answer_id TEXT REFERENCES faq_answers(id) ON DELETE CASCADE,
  user_id TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  user_name TEXT NOT NULL,
  text TEXT NOT NULL,
  is_accepted BOOLEAN DEFAULT false,
  likes_count INTEGER DEFAULT 0,
  dislikes_count INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_faq_answers_faq ON faq_answers(faq_id);
CREATE INDEX idx_faq_answers_parent ON faq_answers(parent_answer_id);
CREATE INDEX idx_faq_answers_user ON faq_answers(user_id);

-- 7. AI CHAT SESSIONS
CREATE TABLE ai_chat_sessions (
  id BIGSERIAL PRIMARY KEY,
  user_id TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_ai_chat_sessions_user ON ai_chat_sessions(user_id);

-- 8. AI CHAT MESSAGES
CREATE TABLE ai_chat_messages (
  id TEXT PRIMARY KEY,
  session_id BIGINT NOT NULL REFERENCES ai_chat_sessions(id) ON DELETE CASCADE,
  user_id TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  role TEXT NOT NULL CHECK (role IN ('user', 'assistant')),
  content TEXT NOT NULL,
  tool_calls JSONB,
  timestamp TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_ai_chat_messages_session ON ai_chat_messages(session_id);
CREATE INDEX idx_ai_chat_messages_timestamp ON ai_chat_messages(timestamp);

-- 9. MESSAGES (User to User)
CREATE TABLE messages (
  id TEXT PRIMARY KEY,
  sender_id TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  recipient_id TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  listing_id TEXT REFERENCES listings(id) ON DELETE SET NULL,
  content TEXT NOT NULL,
  is_read BOOLEAN DEFAULT false,
  product_info JSONB,
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_messages_recipient_read ON messages(recipient_id, is_read);
CREATE INDEX idx_messages_sender ON messages(sender_id);
CREATE INDEX idx_messages_listing ON messages(listing_id);
CREATE INDEX idx_messages_created ON messages(created_at DESC);

-- 10. ACTIVITIES
CREATE TABLE activities (
  id BIGSERIAL PRIMARY KEY,
  user_id TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  activity_type TEXT NOT NULL CHECK (activity_type IN ('sale', 'purchase', 'achievement', 'alert')),
  message TEXT NOT NULL,
  date TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_activities_user ON activities(user_id);
CREATE INDEX idx_activities_type ON activities(activity_type);
CREATE INDEX idx_activities_created ON activities(created_at DESC);

-- 11. ACHIEVEMENTS
CREATE TABLE achievements (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  label TEXT NOT NULL,
  description TEXT NOT NULL,
  icon TEXT NOT NULL,
  unlocked BOOLEAN DEFAULT false,
  unlocked_at TEXT,
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_achievements_user ON achievements(user_id);
CREATE INDEX idx_achievements_unlocked ON achievements(unlocked);

-- ============================================
-- HELPER VIEWS (Optional - for easier queries)
-- ============================================

-- View for listing with owner info
CREATE VIEW listings_with_owner AS
SELECT 
  l.*,
  u.full_name as owner_name,
  u.avatar_url as owner_avatar,
  u.seller_rating as owner_rating,
  u.is_verified as owner_verified
FROM listings l
JOIN users u ON l.user_id = u.id;

-- View for complete match information
CREATE VIEW matches_with_listings AS
SELECT 
  m.*,
  sl.title as source_title,
  sl.price as source_price,
  ml.title as matched_title,
  ml.price as matched_price,
  ml.image_url as matched_image
FROM listing_matches m
JOIN listings sl ON m.source_listing_id = sl.id
JOIN listings ml ON m.matched_listing_id = ml.id;
