# 🛍️ NGAM Marketplace - Database Schema

## 📋 Overview

Complete PostgreSQL database schema for the NGAM Marketplace platform. This schema supports a full-featured marketplace with user-to-user trading, AI-powered matching, community forums, and gamification features.

## 🗂️ Database Structure

### Core Entities
- **Users & Membership** - User profiles with tiered access
- **Listings** - Items for sale or wanted
- **Matches** - AI-powered listing matches
- **Messaging** - User-to-user conversations
- **Community** - Forum threads and discussions
- **AI Assistant** - Chat history with AI helper
- **Gamification** - Achievements and activity tracking

---

## 📊 Schema Breakdown

### 1. 👥 Users & Membership

#### `user_tiers`
Defines membership levels and their features.

| Column | Type | Description |
|--------|------|-------------|
| `id` | VARCHAR(20) | Tier identifier (e.g., 'free', 'premium') |
| `name` | VARCHAR(50) | Display name |
| `description` | TEXT | Tier description |
| `features` | JSONB | Array of feature flags |

**Default Tiers:**
- `free` - Basic marketplace access
- `premium` - Full feature access (default for all users in demo)

#### `users`
Core user profiles and statistics.

| Column | Type | Description |
|--------|------|-------------|
| `id` | VARCHAR(50) | Primary key |
| `name` | VARCHAR(100) | User's display name |
| `email` | VARCHAR(255) | Unique email address |
| `verified` | BOOLEAN | Email verification status |
| `rating` | DECIMAL(3,2) | Average user rating (0.00-5.00) |
| `rating_count` | INTEGER | Number of ratings received |
| `total_listings` | INTEGER | Total listings created |
| `completed_deals` | INTEGER | Successfully completed transactions |
| `avatar` | TEXT | Profile picture URL |
| `tier_id` | VARCHAR(20) | FK to user_tiers (default: 'premium') |
| `joined_date` | VARCHAR(50) | Human-readable join date |

**Indexes:**
- `idx_users_email` - Fast email lookups
- `idx_users_tier` - Filter by membership tier

---

### 2. 🗣️ Community Threads

#### `threads`
Forum categories and discussion topics.

| Column | Type | Description |
|--------|------|-------------|
| `id` | SERIAL | Auto-incrementing primary key |
| `creator_id` | VARCHAR(50) | FK to users |
| `title` | VARCHAR(255) | Thread title |
| `description` | TEXT | Thread description |
| `image_url` | TEXT | Header image |
| `comments` | INTEGER | Comment count |
| `views` | INTEGER | View count |
| `upvotes` | INTEGER | Upvote count |
| `current_tokens` | INTEGER | Current funding tokens |
| `goal_tokens` | INTEGER | Funding goal |
| `tags` | JSONB | Array of tags |
| `is_pinned` | BOOLEAN | Sticky thread flag |
| `is_hot` | BOOLEAN | Trending thread flag |
| `category` | VARCHAR(100) | Thread category |
| `online_users` | INTEGER | Currently active users |
| `total_users` | INTEGER | Total subscribed users |

**Indexes:**
- `idx_threads_creator` - Threads by user
- `idx_threads_category` - Filter by category
- `idx_threads_pinned` - Quick access to pinned threads
- `idx_threads_hot` - Trending threads

---

### 3. 📦 Listings & FAQs

#### `listings`
Items for sale or wanted by users.

| Column | Type | Description |
|--------|------|-------------|
| `id` | VARCHAR(50) | Primary key |
| `user_id` | VARCHAR(50) | FK to users (listing owner) |
| `thread_id` | INTEGER | FK to threads (optional category) |
| `title` | VARCHAR(255) | Listing title |
| `subtitle` | VARCHAR(255) | Short description |
| `description` | TEXT | Full description |
| `price` | DECIMAL(10,2) | Item price |
| `currency` | VARCHAR(3) | Currency code (default: 'MYR') |
| `category` | VARCHAR(100) | Item category |
| `listing_type` | VARCHAR(20) | 'sale' or 'wanted' |
| `image_url` | TEXT | Primary image |
| `gallery` | JSONB | Array of additional images |
| `tags` | JSONB | Array of searchable tags |
| `views` | INTEGER | View count |
| `protected` | BOOLEAN | Premium-only listing flag |
| `seller_name` | VARCHAR(100) | Denormalized seller name |
| `seller_location` | VARCHAR(100) | Seller's location |
| `seller_verified` | BOOLEAN | Seller verification status |
| `time_posted` | VARCHAR(50) | Human-readable post time |

**Indexes:**
- `idx_listings_user` - User's listings
- `idx_listings_thread` - Listings in thread
- `idx_listings_category` - Filter by category
- `idx_listings_type` - Sale vs wanted
- `idx_listings_protected` - Premium listings

#### `listing_faqs`
Frequently asked questions for listings.

| Column | Type | Description |
|--------|------|-------------|
| `id` | SERIAL | Auto-incrementing primary key |
| `listing_id` | VARCHAR(50) | FK to listings |
| `question` | TEXT | FAQ question |
| `answer` | TEXT | FAQ answer |

---

### 4. ❤️ Likes & Matches

#### `likes`
User favorites/bookmarks.

| Column | Type | Description |
|--------|------|-------------|
| `id` | VARCHAR(50) | Primary key |
| `user_id` | VARCHAR(50) | FK to users |
| `listing_id` | VARCHAR(50) | FK to listings |

**Constraints:**
- `UNIQUE(user_id, listing_id)` - One like per user per listing

**Indexes:**
- `idx_likes_user` - User's liked items
- `idx_likes_listing` - Listing's like count

#### `matches`
AI-generated listing matches.

| Column | Type | Description |
|--------|------|-------------|
| `id` | VARCHAR(50) | Primary key |
| `user_id` | VARCHAR(50) | FK to users (match owner) |
| `user_listing_id` | VARCHAR(50) | FK to listings (user's listing) |
| `matched_listing_id` | VARCHAR(50) | FK to listings (matched listing) |
| `score` | INTEGER | Match score (0-100) |
| `match_quality` | VARCHAR(20) | 'excellent', 'good', 'possible' |
| `match_reasons` | JSONB | Array of match reasons |
| `distance` | VARCHAR(50) | Geographic distance |
| `status` | VARCHAR(20) | 'new', 'contacted', 'dismissed' |

**Indexes:**
- `idx_matches_user` - User's matches
- `idx_matches_user_listing` - Matches for specific listing
- `idx_matches_matched_listing` - Reverse lookup
- `idx_matches_status` - Filter by status

---

### 5. 💬 User-to-User Messaging

#### `conversations`
Message threads between users.

| Column | Type | Description |
|--------|------|-------------|
| `id` | VARCHAR(50) | Primary key |
| `participant_1_id` | VARCHAR(50) | FK to users |
| `participant_2_id` | VARCHAR(50) | FK to users |
| `listing_id` | VARCHAR(50) | FK to listings (optional context) |
| `last_message_at` | TIMESTAMP | Last activity timestamp |
| `unread_count` | INTEGER | Unread message count |

**Indexes:**
- `idx_conversations_participant1` - User's conversations
- `idx_conversations_participant2` - User's conversations
- `idx_conversations_listing` - Conversations about listing

#### `messages`
Individual messages in conversations.

| Column | Type | Description |
|--------|------|-------------|
| `id` | VARCHAR(50) | Primary key |
| `conversation_id` | VARCHAR(50) | FK to conversations |
| `sender_id` | VARCHAR(50) | FK to users |
| `receiver_id` | VARCHAR(50) | FK to users |
| `listing_id` | VARCHAR(50) | FK to listings (optional) |
| `content` | TEXT | Message content |
| `read` | BOOLEAN | Read status |
| `timestamp` | TIMESTAMP | Message timestamp |

**Indexes:**
- `idx_messages_conversation` - Messages in conversation
- `idx_messages_sender` - Sent messages
- `idx_messages_receiver` - Received messages
- `idx_messages_read` - Unread messages

---

### 6. 🤖 AI Chat Assistant

#### `ai_chat_sessions`
AI assistant conversation sessions.

| Column | Type | Description |
|--------|------|-------------|
| `id` | VARCHAR(50) | Primary key |
| `user_id` | VARCHAR(50) | FK to users |
| `title` | VARCHAR(255) | Session title |
| `timestamp` | VARCHAR(50) | Human-readable timestamp |

**Indexes:**
- `idx_ai_chat_sessions_user` - User's chat history

#### `ai_chat_messages`
Messages within AI chat sessions.

| Column | Type | Description |
|--------|------|-------------|
| `id` | SERIAL | Auto-incrementing primary key |
| `session_id` | VARCHAR(50) | FK to ai_chat_sessions |
| `role` | VARCHAR(20) | 'user' or 'assistant' |
| `content` | TEXT | Message content |
| `timestamp` | TIMESTAMP | Message timestamp |

**Indexes:**
- `idx_ai_chat_messages_session` - Messages in session

---

### 7. 🏆 Achievements & Activities

#### `achievements`
Gamification achievements/badges.

| Column | Type | Description |
|--------|------|-------------|
| `id` | SERIAL | Auto-incrementing primary key |
| `title` | VARCHAR(100) | Achievement name |
| `description` | TEXT | Achievement description |
| `icon` | VARCHAR(50) | Icon identifier |
| `category` | VARCHAR(50) | 'trading', 'social', 'milestone', 'special' |
| `requirement` | TEXT | How to unlock |
| `progress` | INTEGER | Current progress |
| `total` | INTEGER | Required for unlock |
| `unlocked` | BOOLEAN | Unlock status |
| `unlocked_date` | TIMESTAMP | When unlocked |

**Indexes:**
- `idx_achievements_category` - Filter by category
- `idx_achievements_unlocked` - Unlocked achievements

#### `activities`
User activity feed.

| Column | Type | Description |
|--------|------|-------------|
| `id` | SERIAL | Auto-incrementing primary key |
| `user_id` | VARCHAR(50) | FK to users |
| `type` | VARCHAR(50) | 'sale', 'purchase', 'achievement', 'alert' |
| `message` | TEXT | Activity description |
| `date` | VARCHAR(50) | Human-readable date |

**Indexes:**
- `idx_activities_user` - User's activities
- `idx_activities_type` - Filter by type

---
