# 🧩 Ngam-Je Database Schema Documentation (v5.0)

---

## 📊 Data Flow Summary

### **User Journey Flow**

1. **Browse Threads** → User sees communities/categories  
2. **View Listings** → User clicks thread, sees items for sale/wanted  
3. **AI Matching** → System generates matches based on compatibility  
4. **View Matches** → User sees recommended listings  
5. **Contact Seller** → User sends message  
6. **Ask Questions** → User posts FAQ on listing  
7. **AI Chat** → User asks AI for help finding items  
8. **Track Activity** → System logs user actions  
9. **Earn Achievements** → System unlocks badges  

---

### **Key Database Interactions**

| Operation | Purpose |
|-----------|---------|
| ✅ **READ** | Browse, search, view matches |
| ✅ **WRITE** | Create listings, send messages, post FAQs |
| ✅ **UPDATE** | Mark messages as read, update stats |
| ✅ **JOIN** | Get listings with user info, matches with details |
| ✅ **AGGREGATE** | Count views, calculate ratings, stats |

---

## 🧱 Database Tables Overview

| Table | Purpose | 
|-------|---------|
| `users` | Platform users (buyers/sellers) | 
| `listings` | Marketplace items (buy/sell) | 
| `tags` | Listing tags for filtering |
| `matches` | AI-matched listings | 
| `threads` | Conversation threads |
| `messages` | Individual messages |
| `achievements` | User badges/achievements |
| `activities` | User activity feed |
| `faqs` | Item-specific questions | 
| `chat_history` | AI chat sidebar history | 

---

## 🗂️ Table Structures & Frontend Mapping

---

### 🧑‍💼 **users**

**Purpose:** Stores platform users (buyers and sellers)

**Used By:**
- `frontend/src/utils/mock-all-data-used.ts` (MOCK_USER, MOCK_USERS)
- `frontend/src/app/profile/page.tsx`
- `frontend/src/components/layout/Header.tsx`
- `frontend/src/components/matching/shared/MatchCard.tsx`

**Database Schema:**

```sql
CREATE TABLE users (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    bio TEXT,
    location VARCHAR(100),
    avatar_url TEXT,
    verified BOOLEAN DEFAULT FALSE,
    rating DECIMAL(3, 2) DEFAULT 0.0,
    rating_count INTEGER DEFAULT 0,
    total_listings INTEGER DEFAULT 0,
    completed_deals INTEGER DEFAULT 0,
    joined_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### Field Mappings:

| DB Field | Frontend Field (TypeScript) | Example Value |
|----------|----------------------------|---------------|
| id | User.id | "user-1" |
| name | User.name | "Fitri" |
| email | User.email | "fitri@example.com" |
| avatar_url | User.avatar | "/avatars/fitri.jpg" |
| verified | User.verified | true |
| rating | User.rating | 4.8 |
| rating_count | User.ratingCount | 32 |
| total_listings | User.totalListings | 24 |
| completed_deals | User.completedDeals | 45 |
| joined_date | User.joinedDate | "Jan 15, 2024" |

#### Sample Frontend Type:

```typescript
export interface User {
  id: string;
  name: string;
  email: string;
  verified: boolean;
  rating: number;
  ratingCount: number;
  totalListings: number;
  completedDeals: number;
  avatar?: string;
  joinedDate: string;
}
```

---

### 🛒 **listings**

**Purpose:** Core marketplace listings (items for sale or wanted)

**Used By:**
- `frontend/src/utils/mock-all-data-used.ts` (UNIFIED_LISTINGS)
- `frontend/src/app/listings/page.tsx`
- `frontend/src/app/threads/[threadCategory]/[listingId]/page.tsx`
- `frontend/src/components/matching/AIMatchingContainer.tsx`
- `frontend/src/components/create-listing/CreateListingModal.tsx`

**Database Schema:**

```sql
CREATE TABLE listings (
    id VARCHAR(50) PRIMARY KEY,
    user_id VARCHAR(50) NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'MYR',
    category VARCHAR(100) NOT NULL,
    condition VARCHAR(50),
    status VARCHAR(50) DEFAULT 'active',
    listing_type VARCHAR(20) NOT NULL, -- 'sale' or 'wanted'
    image_url TEXT,
    gallery JSONB,
    views INTEGER DEFAULT 0,
    is_matched BOOLEAN DEFAULT FALSE,
    time_posted TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### Field Mappings:

| DB Field | Frontend Field | Example Value |
|----------|----------------|---------------|
| id | UnifiedListingData.id | "sale-53" |
| title | UnifiedListingData.title | "iPhone 14 Pro" |
| description | UnifiedListingData.description | "Excellent condition..." |
| price | UnifiedListingData.price | 3500 |
| currency | UnifiedListingData.currency | "MYR" |
| user_id | UnifiedListingData.userId | "user-1" |
| category | UnifiedListingData.category | "Electronics" |
| listing_type | UnifiedListingData.listingType | "sale" or "wanted" |
| image_url | UnifiedListingData.imageUrl | "/images/iphone.jpg" |
| gallery | UnifiedListingData.gallery | ["img1.jpg", "img2.jpg"] |
| views | UnifiedListingData.views | 245 |

#### Sample Frontend Type:

```typescript
export type UnifiedListingData = {
  id: string;
  title: string;
  description: string;
  price: number;
  currency: string;
  userId: string;
  seller: {
    name: string;
    location: string;
    verified: boolean;
    timePosted: string;
  };
  imageUrl: string;
  gallery?: string[];
  category: string;
  listingType: "sale" | "wanted";
  tags: string[];
  views: number;
  protected: boolean;
};
```

---

### 🏷️ **tags**

**Purpose:** Stores listing tags for filtering/search

**Used By:**
- `frontend/src/components/create-listing/tag-generator.tsx`
- `frontend/src/utils/mock-all-data-used.ts` (databaseTags, suggestedTags)

**Database Schema:**

```sql
CREATE TABLE tags (
    id SERIAL PRIMARY KEY,
    listing_id VARCHAR(50) NOT NULL REFERENCES listings(id) ON DELETE CASCADE,
    tag_name VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### Field Mappings:

| DB Field | Frontend Field | Example Value |
|----------|----------------|---------------|
| listing_id | Associated listing | "sale-53" |
| tag_name | tags[] in listing | "electronics" |

---

### 🤝 **matches**

**Purpose:** Tracks AI-matched buy/sell listings

**Used By:**
- `frontend/src/app/listings/[listingId]/matches/page.tsx`
- `frontend/src/components/matching/AIMatchingContainer.tsx`
- `frontend/src/components/matching/shared/MatchCard.tsx`
- `frontend/src/utils/mock-all-data-used.ts` (ListingMatch)

**Database Schema:**

```sql
CREATE TABLE matches (
    id SERIAL PRIMARY KEY,
    buy_listing_id VARCHAR(50) NOT NULL REFERENCES listings(id) ON DELETE CASCADE,
    sell_listing_id VARCHAR(50) NOT NULL REFERENCES listings(id) ON DELETE CASCADE,
    buyer_id VARCHAR(50) NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    seller_id VARCHAR(50) NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    match_score DECIMAL(5, 2),
    status VARCHAR(50) DEFAULT 'pending',
    matched_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(buy_listing_id, sell_listing_id)
);
```

#### Field Mappings:

| DB Field | Frontend Field | Example Value |
|----------|----------------|---------------|
| id | ListingMatch.id | "1" |
| sell_listing_id | ListingMatch.matchedListing | Joined listing object |
| match_score | ListingMatch.matchScore | 95.50 |
| status | ListingMatch.status | "new", "contacted", "dismissed" |
| matched_at | ListingMatch.createdAt | "2024-10-27 09:15:00" |

#### Sample Frontend Type:

```typescript
export interface ListingMatch {
  id: string;
  yourListingId: number;
  matchedListing: Listing;
  matchScore: number; // 0-100
  matchQuality: MatchQuality;
  matchReasons: MatchReason[];
  distance?: string;
  createdAt: string;
  status: "new" | "contacted" | "dismissed";
}
```

---

### 💬 **threads**

**Purpose:** Represents conversation threads between users

**Used By:**
- `frontend/src/app/messages/page.tsx`
- `frontend/src/components/messages/ConversationList.tsx`
- `frontend/src/components/messages/ConversationItem.tsx`

**Database Schema:**

```sql
CREATE TABLE threads (
    id VARCHAR(50) PRIMARY KEY,
    participant_1_id VARCHAR(50) NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    participant_2_id VARCHAR(50) NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    listing_id VARCHAR(50) REFERENCES listings(id) ON DELETE SET NULL,
    last_message_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### Field Mappings:

| DB Field | Frontend Field | Example Value |
|----------|----------------|---------------|
| id | Conversation.id | "thread-1" |
| participant_1_id | Linked to User | "user-1" |
| participant_2_id | Linked to User | "user-2" |
| listing_id | Conversation.listingId | "sale-53" |
| last_message_at | Conversation.timestamp | "10:30 AM" |



---

### 💌 **messages**

**Purpose:** Stores individual messages within threads

**Used By:**
- `frontend/src/components/messages/ChatWindow.tsx`
- `frontend/src/utils/mock-all-data-used.ts` (messagesData)

**Database Schema:**

```sql
CREATE TABLE messages (
    id SERIAL PRIMARY KEY,
    thread_id VARCHAR(50) NOT NULL REFERENCES threads(id) ON DELETE CASCADE,
    sender_id VARCHAR(50) NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### Field Mappings:

| DB Field | Frontend Field | Example Value |
|----------|----------------|---------------|
| id | Message.id | "1" |
| sender_id | Message.userId | "user-1" |
| content | Message.content | "Hello, is this still available?" |
| sent_at | Message.timestamp | "10:30 AM" |
| is_read | Message.read | true |



---

### 🏆 **achievements**

**Purpose:** Tracks user achievements and badges

**Used By:**
- `frontend/src/app/profile/page.tsx`
- `frontend/src/utils/mock-all-data-used.ts` (MOCK_ACHIEVEMENTS)

**Database Schema:**

```sql
CREATE TABLE achievements (
    id SERIAL PRIMARY KEY,
    user_id VARCHAR(50) NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    achievement_type VARCHAR(50) NOT NULL,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    unlocked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### Field Mappings:

| DB Field | Frontend Field | Example Value |
|----------|----------------|---------------|
| id | Achievement.id | "1" |
| user_id | Achievement.userId | "user-1" |
| achievement_type | Achievement.type | "sales" |
| title | Achievement.title | "First Sale" |
| description | Achievement.description | "Complete your first sale" |
| unlocked_at | Achievement.unlockedAt | "2024-10-15" |

#### Sample Frontend Type:

```typescript
export interface Achievement {
  id: string;
  title: string;
  description: string;
  icon: string;
  unlockedAt: string;
  type: "sales" | "listings" | "community" | "streak";
}
```

---

### 📊 **activities**

**Purpose:** Logs user activities for activity feed

**Used By:**
- `frontend/src/app/profile/activity/page.tsx`
- `frontend/src/utils/mock-all-data-used.ts` (placeholderActivities)

**Database Schema:**

```sql
CREATE TABLE activities (
    id SERIAL PRIMARY KEY,
    user_id VARCHAR(50) NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    activity_type VARCHAR(50) NOT NULL,
    activity_text TEXT NOT NULL,
    related_listing_id VARCHAR(50) REFERENCES listings(id) ON DELETE SET NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### Field Mappings:

| DB Field | Frontend Field | Example Value |
|----------|----------------|---------------|
| id | Activity.id | "1" |
| activity_type | Activity.type | "listing_created" |
| activity_text | Activity.text | "Posted a new listing" |
| related_listing_id | Activity.listingId | "sale-53" |
| timestamp | Activity.timestamp | "2 hours ago" |

#### Sample Frontend Type:

```typescript
export interface Activity {
  id: string;
  type: "listing_created" | "match_found" | "message_sent" | "achievement_unlocked";
  text: string;
  timestamp: string;
  listingId?: string;
  image?: string;
}
```

---

### ❓ **faqs**

**Purpose:** Stores questions and answers for listings

**Used By:**
- `frontend/src/app/threads/[threadCategory]/[listingId]/faq/page.tsx`
- `frontend/src/components/create-listing/faq-generator.tsx`
- `frontend/src/utils/mock-all-data-used.ts` (MOCK_FAQ_BUY, MOCK_FAQ_SELL)

**Database Schema:**

```sql
CREATE TABLE faqs (
    id SERIAL PRIMARY KEY,
    listing_id VARCHAR(50) NOT NULL REFERENCES listings(id) ON DELETE CASCADE,
    user_id VARCHAR(50) NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    question TEXT NOT NULL,
    answer TEXT,
    asked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    answered_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### Field Mappings:

| DB Field | Frontend Field | Example Value |
|----------|----------------|---------------|
| id | FAQ.id | "1" |
| listing_id | FAQ.listingId | "sale-53" |
| user_id | FAQ.userId | "user-2" |
| question | FAQ.question | "Is this still available?" |
| answer | FAQ.answer | "Yes, it is!" |
| asked_at | FAQ.askedAt | "2024-10-27 10:00:00" |
| answered_at | FAQ.answeredAt | "2024-10-27 10:15:00" |

#### Sample Frontend Type:

```typescript
export interface FAQ {
  id: string;
  question: string;
  answer?: string;
  askedBy: string;
  askedAt: string;
  answeredAt?: string;
}
```

---

### 💬 **chat_history**

**Purpose:** Stores AI chat sidebar conversation history

**Used By:**
- `frontend/src/app/chat/history/page.tsx`
- `frontend/src/utils/mock-all-data-used.ts` (SIDEBAR_CHAT_HISTORY)

**Database Schema:**

```sql
CREATE TABLE chat_history (
    id SERIAL PRIMARY KEY,
    user_id VARCHAR(50) NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    session_id VARCHAR(50) NOT NULL,
    message_type VARCHAR(20) NOT NULL, -- 'user' or 'ai'
    message_text TEXT NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### Field Mappings:

| DB Field | Frontend Field | Example Value |
|----------|----------------|---------------|
| id | ChatMessage.id | "1" |
| user_id | ChatMessage.userId | "user-1" |
| session_id | ChatMessage.sessionId | "session-abc123" |
| message_type | ChatMessage.sender | "user" or "ai" |
| message_text | ChatMessage.text | "Looking for a laptop" |
| timestamp | ChatMessage.timestamp | "10:30 AM" |

 

---

## 🔍 Common SQL Queries

### 1️⃣ Get All Active Listings with User Info

```sql
SELECT 
  l.*,
  u.name AS seller_name,
  u.rating AS seller_rating,
  u.verified AS seller_verified,
  u.avatar_url AS seller_avatar
FROM listings l
JOIN users u ON l.user_id = u.id
WHERE l.status = 'active'
ORDER BY l.time_posted DESC;
```

### 2️⃣ Get Matches with Listing Details

```sql
SELECT 
  m.*,
  ml.title, ml.price, ml.currency, ml.location, ml.image_url,
  u.name AS seller_name, u.rating AS seller_rating, u.verified AS seller_verified
FROM matches m
JOIN listings ml ON m.sell_listing_id = ml.id
JOIN users u ON ml.user_id = u.id
WHERE m.buyer_id = 'user-1' AND m.status = 'pending'
ORDER BY m.match_score DESC;
```

### 3️⃣ Get Conversation Messages

```sql
SELECT 
  m.*,
  u.name, u.avatar_url, u.verified
FROM messages m
JOIN users u ON m.sender_id = u.id
WHERE m.thread_id = 'thread-1'
ORDER BY m.sent_at ASC;
```

### 4️⃣ Get Listing Tags

```sql
SELECT 
  l.id, l.title,
  array_agg(t.tag_name) AS tags
FROM listings l
LEFT JOIN tags t ON l.id = t.listing_id
WHERE l.id = 'sale-53'
GROUP BY l.id, l.title;
```

### 5️⃣ Get User Statistics

```sql
SELECT 
  u.id, u.name,
  COUNT(DISTINCT l.id) AS total_listings,
  COUNT(DISTINCT m.id) AS total_matches,
  AVG(m.match_score) AS avg_match_score
FROM users u
LEFT JOIN listings l ON u.id = l.user_id
LEFT JOIN matches m ON u.id = m.buyer_id OR u.id = m.seller_id
WHERE u.id = 'user-1'
GROUP BY u.id, u.name;
```

### 6️⃣ Get FAQs for a Listing

```sql
SELECT 
  f.*,
  u.name AS asked_by_user
FROM faqs f
JOIN users u ON f.user_id = u.id
WHERE f.listing_id = 'sale-53'
ORDER BY f.asked_at DESC;
```

### 7️⃣ Get User Activities Feed

```sql
SELECT 
  a.*,
  l.title AS listing_title,
  l.image_url AS listing_image
FROM activities a
LEFT JOIN listings l ON a.related_listing_id = l.id
WHERE a.user_id = 'user-1'
ORDER BY a.timestamp DESC
LIMIT 20;
```

### 8️⃣ Get Unread Message Count

```sql
SELECT 
  t.id,
  COUNT(m.id) AS unread_count
FROM threads t
JOIN messages m ON t.id = m.thread_id
WHERE (t.participant_1_id = 'user-1' OR t.participant_2_id = 'user-1')
  AND m.sender_id != 'user-1'
  AND m.is_read = FALSE
GROUP BY t.id;
```

---

## 🌐 API Endpoints (Proposed)

### Users

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/users/me` | Get current user profile |
| GET | `/api/users/:id` | Get user by ID |
| PATCH | `/api/users/me` | Update current user profile |
| GET | `/api/users/:id/stats` | Get user statistics |

### Listings

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/listings` | Get all listings (with filters) |
| GET | `/api/listings/:id` | Get listing by ID |
| POST | `/api/listings` | Create new listing |
| PATCH | `/api/listings/:id` | Update listing |
| DELETE | `/api/listings/:id` | Delete listing |
| POST | `/api/listings/:id/views` | Increment view count |

### Matches

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/listings/:id/matches` | Get matches for listing |
| POST | `/api/matches/generate` | Generate new matches (AI) |
| PATCH | `/api/matches/:id/status` | Update match status |

### Messages

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/threads` | Get all threads for user |
| GET | `/api/threads/:id/messages` | Get messages in thread |
| POST | `/api/messages` | Send message |
| PATCH | `/api/messages/:id/read` | Mark message as read |

### FAQs

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/listings/:id/faqs` | Get FAQs for listing |
| POST | `/api/listings/:id/faqs` | Create FAQ |
| PATCH | `/api/faqs/:id/answer` | Answer FAQ |

### Activities

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/users/me/activities` | Get user activities |
| POST | `/api/activities` | Log new activity |

### Achievements

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/users/me/achievements` | Get user achievements |
| PATCH | `/api/achievements/:id/unlock` | Unlock achievement |

### Tags

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/tags/popular` | Get popular tags |
| GET | `/api/tags/search?q=` | Search tags |

---

## Utils (Mock Data structure)

```
frontend/src/utils/
└── mock-all-data-used.ts             # Centralized mock data
    ├── MOCK_USER                     # User data
    ├── MOCK_USERS                    # Multiple users
    ├── UNIFIED_LISTINGS              # All listings
    ├── mockSaleListings              # Sale listings
    ├── mockWantedListings            # Wanted listings
    ├── MOCK_ACHIEVEMENTS             # Achievements
    ├── placeholderActivities         # Activities
    ├── messagesData                  # Messages
    ├── conversationsData             # Conversations
    ├── SIDEBAR_CHAT_HISTORY          # AI chat history
    ├── MOCK_FAQ_BUY                  # Buy listing FAQs
    ├── MOCK_FAQ_SELL                 # Sell listing FAQs
    ├── databaseTags                  # Available tags
    └── suggestedTags                 # AI suggested tags
```

---

## 📋 Data Structure Summary

| Table | Primary Files | Components Using It |
|-------|--------------|---------------------|
| users | mock-all-data-used.ts, profile/page.tsx | 6+ |
| listings | mock-all-data-used.ts, listings/page.tsx | 15+ |
| tags | tag-generator.tsx, mock-all-data-used.ts | 3+ |
| matches | AIMatchingContainer.tsx, matches/page.tsx | 9+ |
| threads | messages/page.tsx, ConversationList.tsx | 4+ |
| messages | ChatWindow.tsx, mock-all-data-used.ts | 7+ |
| achievements | profile/page.tsx, mock-all-data-used.ts | 2+ |
| activities | profile/activity/page.tsx | 2+ |
| faqs | faq/page.tsx, faq-generator.tsx | 4+ |
| chat_history | chat/history/page.tsx | 2+ |

---

## 🚀 Getting Started

### 1. Run the Schema

```bash
# PostgreSQL
psql -U postgres -d ngamje -f schema.sql

# MySQL
mysql -u root -p ngamje < schema.sql
```

### 2. Seed the Database

```bash
# Run seed data
psql -U postgres -d ngamje -f seed.sql
```

### 3. Connect Backend

Update your backend connection string in `backend/.env`:

```env
DATABASE_URL="postgresql://user:pass@localhost:5432/ngamje"
```

---

## 📊 Entity Relationship Diagram (ERD)

```
┌─────────────┐
│    users    │
└──────┬──────┘
       │
       ├──────────┬────────────┬──────────────┐
       │          │            │              │
       ▼          ▼            ▼              ▼
┌──────────┐ ┌─────────┐ ┌──────────┐ ┌────────────┐
│ listings │ │ threads │ │ messages │ │achievements│
└────┬─────┘ └────┬────┘ └──────────┘ └────────────┘
     │            │
     ├─────┬──────┼────────┐
     │     │      │        │
     ▼     ▼      ▼        ▼
┌──────┐┌────────┐┌─────┐┌────────────┐
│ tags ││matches ││faqs ││activities  │
└──────┘└────────┘└─────┘└────────────┘
```

---

## 📝 Notes

- **String IDs:** Listings use string IDs ("sale-53", "wanted-1") to match frontend
- **Currency:** Default currency is MYR (Malaysian Ringgit)
- **Gallery:** Uses JSONB in PostgreSQL for multiple images
- **Timestamps:** All tables have created_at and updated_at
- **Foreign Keys:** Proper CASCADE rules for data integrity
- **Indexes:** Added on frequently queried fields
