# 🧩 Ngam-Je Database Schema Documentation (v-4)
### Marketplace Platform - Table Descriptions Based on FrontEnd

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
|------------|----------|
| ✅ **READ** | Browse, search, view matches |
| ✅ **WRITE** | Create listings, send messages, post FAQs |
| ✅ **UPDATE** | Mark messages as read, update stats |
| ✅ **JOIN** | Get listings with user info, matches with details |
| ✅ **AGGREGATE** | Count views, calculate ratings, stats |

---

## 🧱 Database Table ↔ FrontEnd Mapping

---

### 🧑‍💼 `users`
**Used By:**
- `frontend/src/utils/mock-user-data.ts`
- `frontend/src/app/profile/page.tsx`
- `frontend/src/components/layout/Header.tsx`
- `frontend/src/components/layout/Sidebar.tsx`
- `frontend/src/lib/auth/AuthContext.tsx`
- `frontend/src/lib/auth/providers/MockAuthProvider.tsx`

**Field Mappings:**
| DB Field | Frontend Field |
|-----------|----------------|
| id | User.id |
| full_name | User.name |
| email | User.email |
| avatar_url | User.avatar |
| is_verified | User.verified |
| seller_rating | User.rating |
| rating_count | User.ratingCount |
| total_listings | User.totalListings |
| completed_deals | User.completedDeals |
| created_at | User.joinedDate |

---

### 🧵 `threads`
**Used By:**
- `frontend/src/utils/mock-threads-data.ts`
- `frontend/src/app/threads/page.tsx`
- `frontend/src/app/threads/[threadCategory]/page.tsx`
- `frontend/src/components/threads/ThreadCard.tsx`
- `frontend/src/components/threads/ThreadsGrid.tsx`
- `frontend/src/components/threads/NgamOverview.tsx`
- `frontend/src/components/threads/PageHeader.tsx`

**Field Mappings:**
| DB Field | Frontend Field |
|-----------|----------------|
| id | ThreadData.id |
| title | ThreadData.title |
| description | ThreadData.description |
| image_url | ThreadData.imageUrl |
| category | ThreadData.category |
| tags | ThreadData.tags |
| comments_count | ThreadData.comments |
| views_count | ThreadData.views |
| upvotes_count | ThreadData.upvotes |
| current_tokens | ThreadData.currentTokens |
| goal_tokens | ThreadData.goalTokens |
| contributions_count | ThreadData.contributions |
| is_pinned | ThreadData.isPinned |
| is_hot | ThreadData.isHot |
| time_ago | ThreadData.timeAgo |
| online_users | ThreadData.onlineUsers |
| total_users | ThreadData.totalUsers |

---

### 🛒 `listings`
**Used By:**
- Multiple files (15+), including mock data, page routes, and components for listing display, creation, and threads integration.

**Field Mappings:**
| DB Field | Frontend Field |
|-----------|----------------|
| id | Listing.id |
| title | Listing.title |
| description | Listing.description |
| price | Listing.price |
| budget | Listing.budget |
| location | Listing.location |
| timestamp | Listing.timestamp |
| image_url | Listing.imageUrl |
| views_count | Listing.views |
| likes_count | Listing.likes |
| category | Listing.category |
| expires_at | Listing.expiresAt |
| subscription_tier | Listing.subscriptionTier |
| user_id | isOwner (joined via users) |

---

### 🤝 `listing_matches`
**Used By:** Matching & AI components

**Field Mappings:**
| DB Field | Frontend Field |
|-----------|----------------|
| id | ListingMatch.id |
| source_listing_id | ListingMatch.yourListingId |
| matched_listing_id | ListingMatch.matchedListing |
| match_score | ListingMatch.matchScore |
| match_quality | ListingMatch.matchQuality |
| match_reasons | ListingMatch.matchReasons |
| distance | ListingMatch.distance |
| status | ListingMatch.status |
| price_compatible | ListingMatch.compatibility.priceMatch |
| location_compatible | ListingMatch.compatibility.locationMatch |
| category_compatible | ListingMatch.compatibility.categoryMatch |
| created_at | ListingMatch.createdAt |

---

### ❓ `listing_faqs` & 💬 `faq_answers`

**FAQ Fields:**
| DB Field | Frontend Field |
|-----------|----------------|
| id | Question.id |
| question | Question.question |
| description | Question.description |
| is_answered_by_poster | Question.isAnsweredByPoster |

**Answer Fields:**
| DB Field | Frontend Field |
|-----------|----------------|
| id | Answer.id / Reply.id |
| user_name | Answer.user / Reply.user |
| text | Answer.text / Reply.text |
| is_accepted | Answer.isAccepted |
| likes_count | Answer.likes |
| dislikes_count | Answer.dislikes |
| parent_answer_id | Nested reply logic |

---

### 💌 `messages`
**Used By:** Messaging system components

**Field Mappings:**
| DB Field | Frontend Field |
|-----------|----------------|
| id | MessagePreview.id |
| sender_id | ConversationMessage.sender |
| recipient_id | Conversation filter |
| content | MessagePreview.message |
| is_read | Unread counter |
| product_info | MessagePreview.product |
| created_at | ConversationMessage.timestamp |

---

### 🤖 `ai_chat_sessions` & `ai_chat_messages`
**Used By:** AI Chat and Sidebar History Components

**Session Fields:**
| DB Field | Frontend Field |
|-----------|----------------|
| id | ChatHistoryItem.id |
| title | ChatHistoryItem.title |
| created_at | ChatHistoryItem.created_at |
| (calculated) | ChatHistoryItem.timestamp ("2 hours ago") |

**Message Fields:**
| DB Field | Frontend Field |
|-----------|----------------|
| id | Message.id |
| role | Message.role |
| content | Message.content |
| tool_calls | Message.toolCalls |
| timestamp | Message.timestamp |

---

### 🧭 `activities` & 🏅 `achievements`
| Table | Used By | Fields |
|--------|----------|--------|
| `activities` | `/profile/activity/page.tsx` | `activity_type`, `message`, `date` |
| `achievements` | `/profile/page.tsx` | `id`, `label`, `description`, `icon`, `unlocked`, `unlocked_at` |

---

## 🔗 Cross-Table Queries

### 🧍 Get Listings with Owner Info
```sql
SELECT 
  l.*,
  u.full_name AS seller_name,
  u.seller_rating,
  u.is_verified AS seller_verified,
  u.avatar_url AS seller_avatar
FROM listings l
JOIN users u ON l.user_id = u.id;

### Get Matches with Listing Details

```sql
SELECT 
  m.*,
  ml.title, ml.price, ml.location, ml.image_url,
  u.full_name, u.seller_rating, u.is_verified
FROM listing_matches m
JOIN listings ml ON m.matched_listing_id = ml.id
JOIN users u ON ml.user_id = u.id;
```

### Get FAQs with Nested Replies

```sql
WITH RECURSIVE faq_tree AS (
  SELECT f.*, a.* FROM listing_faqs f
  LEFT JOIN faq_answers a ON f.id = a.faq_id
  -- ... recursive logic
);
```

### Get Conversation Messages

```sql
SELECT 
  m.*,
  u.full_name, u.avatar_url, u.is_verified
FROM messages m
JOIN users u ON (m.sender_id = u.id OR m.recipient_id = u.id)
WHERE m.sender_id = ? OR m.recipient_id = ?;
```

### Get AI Chat History

```sql
SELECT 
  s.id, s.title,
  array_agg(m.*) AS messages
FROM ai_chat_sessions s
LEFT JOIN ai_chat_messages m ON s.id = m.session_id
GROUP BY s.id;
```

## 🌐 API Endpoints

### Users

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/users/me` | Get current user profile |
| `GET` | `/api/users/:id` | Get user by ID |
| `PATCH` | `/api/users/me` | Update current user profile |

### Threads

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/threads` | Get all threads |
| `GET` | `/api/threads/:id` | Get thread by ID |
| `GET` | `/api/threads/:id/stats` | Get thread statistics |

### Listings

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/listings` | Get all listings |
| `GET` | `/api/listings/:id` | Get listing by ID |
| `POST` | `/api/listings` | Create new listing |
| `PATCH` | `/api/listings/:id` | Update listing |
| `DELETE` | `/api/listings/:id` | Delete listing |
| `GET` | `/api/threads/:threadId/listings` | Get listings by thread |

### Matches

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/listings/:id/matches` | Get matches for listing |
| `POST` | `/api/matches/generate` | Generate new matches |
| `PATCH` | `/api/matches/:id` | Update match |

### FAQs

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/listings/:id/faqs` | Get FAQs for listing |
| `POST` | `/api/listings/:id/faqs` | Create FAQ |
| `POST` | `/api/faqs/:id/answers` | Add answer to FAQ |
| `POST` | `/api/answers/:id/replies` | Reply to answer |
| `PATCH` | `/api/answers/:id/vote` | Vote on answer |

### Messages

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/messages` | Get all messages |
| `GET` | `/api/messages/conversation/:userId` | Get conversation with user |
| `POST` | `/api/messages` | Send message |
| `PATCH` | `/api/messages/:id/read` | Mark message as read |

### AI Chat

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/ai/sessions` | Get all AI chat sessions |
| `GET` | `/api/ai/sessions/:id` | Get session by ID |
| `POST` | `/api/ai/chat` | Send AI chat message |
| `DELETE` | `/api/ai/sessions/:id` | Delete session |

### Activities

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/users/me/activities` | Get user activities |

### Achievements

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/users/me/achievements` | Get user achievements |
| `PATCH` | `/api/achievements/:id/unlock` | Unlock achievement |

## 🗂️ File Structure

### Pages (Routes)

```
/app
├── threads
│   ├── page.tsx
│   ├── [threadCategory]
│   │   └── page.tsx
│   └── [...]/[listingId]
│       ├── page.tsx
│       └── faq
│           └── page.tsx
├── listings
│   ├── page.tsx
│   └── [listingId]/matches
│       └── page.tsx
├── messages
│   └── page.tsx
├── chat/history
│   └── page.tsx
└── profile
    ├── page.tsx
    └── activity
        └── page.tsx
```

### Components (UI)

```
/components
├── threads/
├── matching/
├── messages/
├── sidebar/
└── threads/product-faq/
```

### Utils (Mock Data)

```
/utils
├── mock-user-data.ts
├── mock-threads-data.ts
├── mock-listings-data.ts
├── mock-match-data.ts
├── mock-threads-faq-data.ts
├── mock-messages.ts
├── mock-search-history.ts
├── mock-activity-data.ts
└── mock-achievements-data.ts
```

## 📋 Data Structure Summary

| Table | Primary Files | Component Count |
|-------|---------------|-----------------|
| **users** | `mock-user-data.ts`, `profile/page.tsx`, `Header.tsx` | 6 |
| **threads** | `mock-threads-data.ts`, `threads/page.tsx`, `ThreadCard.tsx` | 7 |
| **listings** | `mock-listings-data.ts`, `listings/page.tsx`, `ProductDetails.tsx` | 15+ |
| **listing_matches** | `mock-match-data.ts`, `AIMatchingContainer.tsx` | 9 |
| **listing_faqs** | `mock-threads-faq-data.ts`, `faq/page.tsx` | 6 |
| **faq_answers** | `mock-threads-faq-data.ts`, `Answer.tsx` | 3 |
| **messages** | `mock-messages.ts`, `messages/page.tsx`, `ChatWindow.tsx` | 7 |
| **ai_chat_sessions** | `mock-search-history.ts`, `chat/history/page.tsx` | 4 |
| **ai_chat_messages** | `mock-search-history.ts`, `ChatHistoryPage.tsx` | 4 |
| **activities** | `mock-activity-data.ts`, `profile/activity/page.tsx` | 2 |
| **achievements** | `mock-achievements-data.ts`, `profile/page.tsx` | 2 |

---

 




