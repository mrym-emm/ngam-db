-- ============================================
-- COMPLETE DATABASE SETUP - ALL SCENARIOS
-- Covers: Matching, FAQs, Messaging, AI, Boosts
-- ============================================

-- ============================================
-- STEP 1: DROP ALL TABLES
-- ============================================
DROP TABLE IF EXISTS thread_boost_contributions CASCADE;
DROP TABLE IF EXISTS messages CASCADE;
DROP TABLE IF EXISTS ai_actions CASCADE;
DROP TABLE IF EXISTS ai_chat_messages CASCADE;
DROP TABLE IF EXISTS ai_chat_sessions CASCADE;
DROP TABLE IF EXISTS listing_faqs CASCADE;
DROP TABLE IF EXISTS match_interactions CASCADE;
DROP TABLE IF EXISTS mutual_matches CASCADE;
DROP TABLE IF EXISTS listing_matches CASCADE;
DROP TABLE IF EXISTS listings CASCADE;
DROP TABLE IF EXISTS thread_members CASCADE;
DROP TABLE IF EXISTS threads CASCADE;
DROP TABLE IF EXISTS boost_levels_config CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- ============================================
-- STEP 2: CREATE TABLES
-- ============================================

-- 1. USERS (Enhanced with rating system)
CREATE TABLE users (
  id BIGSERIAL PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  username TEXT UNIQUE NOT NULL,
  full_name TEXT,
  avatar_url TEXT,
  location TEXT,
  is_verified BOOLEAN DEFAULT false,
  is_premium BOOLEAN DEFAULT false,
  tokens_balance INTEGER DEFAULT 0,
  seller_rating DECIMAL(3,2) DEFAULT 0.00,
  total_sales INTEGER DEFAULT 0,
  total_purchases INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_rating ON users(seller_rating);

-- 2. BOOST LEVELS CONFIG
CREATE TABLE boost_levels_config (
  level INTEGER PRIMARY KEY,
  points_required INTEGER UNIQUE NOT NULL,
  perks_granted JSONB NOT NULL,
  description TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 3. THREADS
CREATE TABLE threads (
  id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  image_url TEXT,
  category TEXT NOT NULL,
  tags TEXT[],
  views_count INTEGER DEFAULT 0,
  upvotes_count INTEGER DEFAULT 0,
  current_tokens INTEGER DEFAULT 0,
  goal_tokens INTEGER DEFAULT 0,
  contributions_count INTEGER DEFAULT 0,
  is_pinned BOOLEAN DEFAULT false,
  is_hot BOOLEAN DEFAULT false,
  boost_level INTEGER DEFAULT 0 REFERENCES boost_levels_config(level),
  boost_points INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_threads_category ON threads(category);
CREATE INDEX idx_threads_boost_level ON threads(boost_level);
CREATE INDEX idx_threads_hot ON threads(is_hot);

-- 4. THREAD MEMBERS
CREATE TABLE thread_members (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  thread_id TEXT NOT NULL REFERENCES threads(id) ON DELETE CASCADE,
  joined_at TIMESTAMPTZ DEFAULT now(),
  is_favorite BOOLEAN DEFAULT false,
  notification_enabled BOOLEAN DEFAULT true
);

CREATE INDEX idx_thread_members_user_id ON thread_members(user_id);
CREATE INDEX idx_thread_members_thread_id ON thread_members(thread_id);
CREATE UNIQUE INDEX idx_thread_members_user_thread ON thread_members(user_id, thread_id);

-- 5. LISTINGS
CREATE TABLE listings (
  id TEXT PRIMARY KEY,
  thread_id TEXT NOT NULL REFERENCES threads(id) ON DELETE CASCADE,
  user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  subtitle TEXT,
  description TEXT NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  currency TEXT DEFAULT 'RM',
  seller_name TEXT NOT NULL,
  seller_location TEXT NOT NULL,
  seller_verified BOOLEAN DEFAULT false,
  time_posted TEXT NOT NULL,
  image_url TEXT NOT NULL,
  gallery TEXT[],
  category TEXT NOT NULL,
  listing_type TEXT NOT NULL CHECK (listing_type IN ('for-sale', 'want-to-buy')),
  tags TEXT[],
  views_count INTEGER DEFAULT 0,
  is_protected BOOLEAN DEFAULT false,
  status TEXT DEFAULT 'active' CHECK (status IN ('active', 'sold', 'closed', 'pending', 'expired')),
  expires_at TIMESTAMPTZ NOT NULL,
  last_extended_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_listings_thread_id ON listings(thread_id);
CREATE INDEX idx_listings_user_id ON listings(user_id);
CREATE INDEX idx_listings_listing_type ON listings(listing_type);
CREATE INDEX idx_listings_category ON listings(category);
CREATE INDEX idx_listings_expires_at ON listings(expires_at);
CREATE INDEX idx_listings_status ON listings(status);
CREATE INDEX idx_listings_price ON listings(price);

-- 6. LISTING MATCHES
CREATE TABLE listing_matches (
  id BIGSERIAL PRIMARY KEY,
  source_listing_id TEXT NOT NULL REFERENCES listings(id) ON DELETE CASCADE,
  matched_listing_id TEXT NOT NULL REFERENCES listings(id) ON DELETE CASCADE,
  match_score INTEGER NOT NULL CHECK (match_score >= 0 AND match_score <= 100),
  match_quality TEXT NOT NULL CHECK (match_quality IN ('excellent', 'good', 'possible')),
  match_reasons JSONB NOT NULL,
  distance_km DECIMAL(10,2),
  price_compatible BOOLEAN DEFAULT false,
  location_compatible BOOLEAN DEFAULT false,
  category_compatible BOOLEAN DEFAULT false,
  status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'viewed', 'interested', 'dismissed')),
  expires_at TIMESTAMPTZ DEFAULT NOW() + INTERVAL '30 days',
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_listing_matches_source ON listing_matches(source_listing_id);
CREATE INDEX idx_listing_matches_matched ON listing_matches(matched_listing_id);
CREATE INDEX idx_listing_matches_score ON listing_matches(match_score DESC);
CREATE INDEX idx_listing_matches_status ON listing_matches(status);
CREATE INDEX idx_listing_matches_expires ON listing_matches(expires_at);
CREATE UNIQUE INDEX idx_listing_matches_unique ON listing_matches(source_listing_id, matched_listing_id);

-- 7. MUTUAL MATCHES
CREATE TABLE mutual_matches (
  id BIGSERIAL PRIMARY KEY,
  buyer_listing_id TEXT NOT NULL REFERENCES listings(id) ON DELETE CASCADE,
  seller_listing_id TEXT NOT NULL REFERENCES listings(id) ON DELETE CASCADE,
  buyer_user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  seller_user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  buyer_interested BOOLEAN DEFAULT false,
  seller_interested BOOLEAN DEFAULT false,
  buyer_interested_at TIMESTAMPTZ,
  seller_interested_at TIMESTAMPTZ,
  is_mutual BOOLEAN DEFAULT false,
  matched_at TIMESTAMPTZ,
  match_score INTEGER NOT NULL CHECK (match_score >= 0 AND match_score <= 100),
  match_quality TEXT NOT NULL CHECK (match_quality IN ('excellent', 'good', 'possible')),
  conversation_started BOOLEAN DEFAULT false,
  conversation_started_at TIMESTAMPTZ,
  status TEXT DEFAULT 'active' CHECK (status IN ('active', 'negotiating', 'deal_made', 'expired', 'cancelled')),
  deal_completed BOOLEAN DEFAULT false,
  completed_at TIMESTAMPTZ,
  initiated_by BIGINT REFERENCES users(id),
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_mutual_matches_buyer_user ON mutual_matches(buyer_user_id);
CREATE INDEX idx_mutual_matches_seller_user ON mutual_matches(seller_user_id);
CREATE INDEX idx_mutual_matches_buyer_listing ON mutual_matches(buyer_listing_id);
CREATE INDEX idx_mutual_matches_seller_listing ON mutual_matches(seller_listing_id);
CREATE INDEX idx_mutual_matches_is_mutual ON mutual_matches(is_mutual);
CREATE INDEX idx_mutual_matches_status ON mutual_matches(status);
CREATE UNIQUE INDEX idx_mutual_matches_unique ON mutual_matches(buyer_listing_id, seller_listing_id);

-- 8. MATCH INTERACTIONS
CREATE TABLE match_interactions (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  match_id BIGINT NOT NULL REFERENCES listing_matches(id) ON DELETE CASCADE,
  action_type TEXT NOT NULL CHECK (action_type IN ('viewed', 'interested', 'contacted', 'dismissed', 'reported')),
  metadata JSONB,
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_match_interactions_user ON match_interactions(user_id);
CREATE INDEX idx_match_interactions_match ON match_interactions(match_id);
CREATE INDEX idx_match_interactions_action ON match_interactions(action_type);
CREATE INDEX idx_match_interactions_created ON match_interactions(created_at);

-- 9. LISTING FAQS
CREATE TABLE listing_faqs (
  id BIGSERIAL PRIMARY KEY,
  listing_id TEXT NOT NULL REFERENCES listings(id) ON DELETE CASCADE,
  user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  parent_id BIGINT REFERENCES listing_faqs(id) ON DELETE CASCADE,
  type TEXT NOT NULL CHECK (type IN ('question', 'answer', 'reply')),
  content TEXT NOT NULL,
  description TEXT,
  is_accepted BOOLEAN DEFAULT false,
  upvotes_count INTEGER DEFAULT 0,
  downvotes_count INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_listing_faqs_listing ON listing_faqs(listing_id);
CREATE INDEX idx_listing_faqs_parent ON listing_faqs(parent_id);
CREATE INDEX idx_listing_faqs_type ON listing_faqs(type);
CREATE INDEX idx_listing_faqs_user ON listing_faqs(user_id);

-- 10. AI CHAT SESSIONS
CREATE TABLE ai_chat_sessions (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  title TEXT,
  mode TEXT DEFAULT 'reactive' CHECK (mode IN ('reactive', 'proactive')),
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_ai_chat_sessions_user ON ai_chat_sessions(user_id);

-- 11. AI CHAT MESSAGES
CREATE TABLE ai_chat_messages (
  id BIGSERIAL PRIMARY KEY,
  session_id BIGINT NOT NULL REFERENCES ai_chat_sessions(id) ON DELETE CASCADE,
  user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  role TEXT NOT NULL CHECK (role IN ('user', 'assistant')),
  content TEXT NOT NULL,
  prompt TEXT,
  tool_calls JSONB,
  tool_results JSONB,
  metadata JSONB,
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_ai_chat_messages_session ON ai_chat_messages(session_id);

-- 12. AI ACTIONS
CREATE TABLE ai_actions (
  id BIGSERIAL PRIMARY KEY,
  session_id BIGINT NOT NULL REFERENCES ai_chat_sessions(id) ON DELETE CASCADE,
  message_id BIGINT NOT NULL REFERENCES ai_chat_messages(id) ON DELETE CASCADE,
  user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  action_type TEXT NOT NULL,
  action_input JSONB,
  action_output JSONB,
  status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'running', 'completed', 'failed')),
  started_at TIMESTAMPTZ,
  completed_at TIMESTAMPTZ,
  error_message TEXT,
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_ai_actions_session ON ai_actions(session_id);
CREATE INDEX idx_ai_actions_user ON ai_actions(user_id);
CREATE INDEX idx_ai_actions_type ON ai_actions(action_type);

-- 13. MESSAGES
CREATE TABLE messages (
  id BIGSERIAL PRIMARY KEY,
  sender_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  recipient_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  listing_id TEXT REFERENCES listings(id) ON DELETE SET NULL,
  mutual_match_id BIGINT REFERENCES mutual_matches(id) ON DELETE SET NULL,
  content TEXT NOT NULL,
  is_read BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_messages_recipient_read ON messages(recipient_id, is_read);
CREATE INDEX idx_messages_sender ON messages(sender_id);
CREATE INDEX idx_messages_listing ON messages(listing_id);
CREATE INDEX idx_messages_mutual_match ON messages(mutual_match_id);
CREATE INDEX idx_messages_created ON messages(created_at DESC);

-- 14. THREAD BOOST CONTRIBUTIONS
CREATE TABLE thread_boost_contributions (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  thread_id TEXT NOT NULL REFERENCES threads(id) ON DELETE CASCADE,
  amount INTEGER NOT NULL,
  contributed_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_boost_contributions_user ON thread_boost_contributions(user_id);
CREATE INDEX idx_boost_contributions_thread ON thread_boost_contributions(thread_id);
CREATE INDEX idx_boost_contributions_date ON thread_boost_contributions(contributed_at);
