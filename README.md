# Ngam-Je Database Schema Documentation (v-4)
## Marketplace Platform - Table Descriptions Based on FrontEnd


📊 Data Flow Summary:
User Journey Flow:
Browse Threads → User sees communities/categories
View Listings → User clicks thread, sees items for sale/wanted
AI Matching → System generates matches based on compatibility
View Matches → User sees recommended listings
Contact Seller → User sends message
Ask Questions → User posts FAQ on listing
AI Chat → User asks AI for help finding items
Track Activity → System logs user actions
Earn Achievements → System unlocks badges
Key Database Interactions:
✅ READ operations: Browse, search, view matches
✅ WRITE operations: Create listings, send messages, post FAQs
✅ UPDATE operations: Mark messages as read, update stats
✅ JOIN operations: Get listings with user info, matches with details
✅ AGGREGATE operations: Count views, calculate ratings, stats

-- ============================================
-- DATABASE TABLE TO FRONTEND FILE MAPPING
-- Shows which files interact with each table
-- ============================================

-- ============================================
-- TABLE: users
-- ============================================
-- USED BY:
-- ✓ frontend/src/utils/mock-user-data.ts
-- ✓ frontend/src/app/profile/page.tsx
-- ✓ frontend/src/components/layout/Header.tsx
-- ✓ frontend/src/components/layout/Sidebar.tsx
-- ✓ frontend/src/lib/auth/AuthContext.tsx
-- ✓ frontend/src/lib/auth/providers/MockAuthProvider.tsx

-- FIELDS MAPPED:
-- id → User.id
-- full_name → User.name
-- email → User.email
-- avatar_url → User.avatar
-- is_verified → User.verified
-- seller_rating → User.rating
-- rating_count → User.ratingCount
-- total_listings → User.totalListings
-- completed_deals → User.completedDeals
-- created_at → User.joinedDate

-- ============================================
-- TABLE: threads
-- ============================================
-- USED BY:
-- ✓ frontend/src/utils/mock-threads-data.ts
-- ✓ frontend/src/app/threads/page.tsx
-- ✓ frontend/src/app/threads/[threadCategory]/page.tsx
-- ✓ frontend/src/components/threads/ThreadCard.tsx
-- ✓ frontend/src/components/threads/ThreadsGrid.tsx
-- ✓ frontend/src/components/threads/NgamOverview.tsx
-- ✓ frontend/src/components/threads/PageHeader.tsx

-- FIELDS MAPPED:
-- id → ThreadData.id
-- title → ThreadData.title
-- description → ThreadData.description
-- image_url → ThreadData.imageUrl
-- category → ThreadData.category
-- tags → ThreadData.tags
-- comments_count → ThreadData.comments
-- views_count → ThreadData.views
-- upvotes_count → ThreadData.upvotes
-- current_tokens → ThreadData.currentTokens
-- goal_tokens → ThreadData.goalTokens
-- contributions_count → ThreadData.contributions
-- is_pinned → ThreadData.isPinned
-- is_hot → ThreadData.isHot
-- time_ago → ThreadData.timeAgo
-- online_users → ThreadData.onlineUsers
-- total_users → ThreadData.totalUsers

-- ============================================
-- TABLE: listings
-- ============================================
-- USED BY:
-- ✓ frontend/src/utils/mock-listings-data.ts
-- ✓ frontend/src/utils/mock-threads-data.ts (ProductListingData)
-- ✓ frontend/src/app/listings/page.tsx
-- ✓ frontend/src/app/create-listing/page.tsx
-- ✓ frontend/src/app/threads/[threadCategory]/page.tsx
-- ✓ frontend/src/app/threads/[threadCategory]/[listingId]/page.tsx
-- ✓ frontend/src/components/threads/category/ListingCard.tsx
-- ✓ frontend/src/components/threads/product/ProductDetails.tsx
-- ✓ frontend/src/components/threads/product/ProductDetailsTop.tsx
-- ✓ frontend/src/components/threads/product/ProductDetailsMiddle.tsx
-- ✓ frontend/src/components/threads/product/ProductDetailsBottom.tsx
-- ✓ frontend/src/components/threads/product/ProductHeader.tsx
-- ✓ frontend/src/components/sidebar/menu-items/BuyListingsMenuItem.tsx
-- ✓ frontend/src/components/sidebar/menu-items/SellListingsMenuItem.tsx
-- ✓ frontend/src/components/sidebar/menu-items/MatchedListingsMenuItem.tsx

-- FIELDS MAPPED:
-- id → Listing.id
-- title → Listing.title
-- description → Listing.description
-- price → Listing.price (for sale listings)
-- budget → Listing.budget (for wanted listings)
-- location → Listing.location
-- timestamp → Listing.timestamp
-- image_url → Listing.imageUrl
-- views_count → Listing.views
-- likes_count → Listing.likes
-- category → Listing.category
-- expires_at → Listing.expiresAt
-- subscription_tier → Listing.subscriptionTier
-- user_id (joined) → isOwner flag

-- ============================================
-- TABLE: listing_matches
-- ============================================
-- USED BY:
-- ✓ frontend/src/utils/mock-match-data.ts
-- ✓ frontend/src/utils/mock-ai-matching-data.ts
-- ✓ frontend/src/app/listings/[listingId]/matches/page.tsx
-- ✓ frontend/src/components/matching/AIMatchingContainer.tsx
-- ✓ frontend/src/components/matching/desktop/AIMatchingKanban.tsx
-- ✓ frontend/src/components/matching/mobile/AIMatchingSwipe.tsx
-- ✓ frontend/src/components/matching/shared/MatchCard.tsx
-- ✓ frontend/src/components/matching/shared/useMatchingLogic.ts
-- ✓ frontend/src/components/matching/ListingComparisonModal.tsx

-- FIELDS MAPPED:
-- id → ListingMatch.id
-- source_listing_id → ListingMatch.yourListingId
-- matched_listing_id → ListingMatch.matchedListing (joined)
-- match_score → ListingMatch.matchScore
-- match_quality → ListingMatch.matchQuality
-- match_reasons → ListingMatch.matchReasons (JSONB array)
-- distance → ListingMatch.distance
-- status → ListingMatch.status
-- price_compatible → ListingMatch.compatibility.priceMatch
-- location_compatible → ListingMatch.compatibility.locationMatch
-- category_compatible → ListingMatch.compatibility.categoryMatch
-- created_at → ListingMatch.createdAt

-- ============================================
-- TABLE: listing_faqs
-- ============================================
-- USED BY:
-- ✓ frontend/src/utils/mock-threads-faq-data.ts
-- ✓ frontend/src/app/threads/[threadCategory]/[listingId]/faq/page.tsx
-- ✓ frontend/src/components/threads/product/ProductFAQSummary.tsx
-- ✓ frontend/src/components/threads/product-faq/Question.tsx
-- ✓ frontend/src/components/threads/product-faq/Answer.tsx
-- ✓ frontend/src/components/threads/product-faq/AISummary.tsx

-- FIELDS MAPPED:
-- id → Question.id
-- question → Question.question
-- description → Question.description
-- is_answered_by_poster → Question.isAnsweredByPoster

-- ============================================
-- TABLE: faq_answers
-- ============================================
-- USED BY:
-- ✓ frontend/src/utils/mock-threads-faq-data.ts
-- ✓ frontend/src/app/threads/[threadCategory]/[listingId]/faq/page.tsx
-- ✓ frontend/src/components/threads/product-faq/Answer.tsx

-- FIELDS MAPPED:
-- id → Answer.id / Reply.id
-- user_name → Answer.user / Reply.user
-- text → Answer.text / Reply.text
-- is_accepted → Answer.isAccepted
-- likes_count → Answer.likes / Reply.likes
-- dislikes_count → Answer.dislikes / Reply.dislikes
-- parent_answer_id → determines if it's a reply (nested)

-- ============================================
-- TABLE: messages
-- ============================================
-- USED BY:
-- ✓ frontend/src/utils/mock-messages.ts
-- ✓ frontend/src/app/messages/page.tsx
-- ✓ frontend/src/components/messages/ChatWindow.tsx
-- ✓ frontend/src/components/messages/ChatInput.tsx
-- ✓ frontend/src/components/messages/ConversationList.tsx
-- ✓ frontend/src/components/messages/ConversationItem.tsx
-- ✓ frontend/src/components/messages/MessageBubble.tsx

-- FIELDS MAPPED:
-- id → MessagePreview.id / ConversationMessage.id
-- sender_id → ConversationMessage.sender (with logic "me" vs "them")
-- recipient_id → used to filter conversations
-- content → MessagePreview.message / ConversationMessage.content
-- is_read → determines unread count
-- product_info → MessagePreview.product / ConversationMessage.product (JSONB)
-- created_at → MessagePreview.time / ConversationMessage.timestamp

-- ============================================
-- TABLE: ai_chat_sessions
-- ============================================
-- USED BY:
-- ✓ frontend/src/utils/mock-search-history.ts
-- ✓ frontend/src/app/chat/history/page.tsx
-- ✓ frontend/src/components/sidebar/SidebarAIChat.tsx
-- ✓ frontend/src/components/sidebar/SearchHistory.tsx
-- ✓ frontend/src/components/sidebar/ChatHistoryPage.tsx

-- FIELDS MAPPED:
-- id → ChatHistoryItem.id / SearchSuggestion.id
-- title → ChatHistoryItem.title / SearchSuggestion.title
-- created_at → ChatHistoryItem.created_at
-- (calculated) timestamp → ChatHistoryItem.timestamp ("2 hours ago")

-- ============================================
-- TABLE: ai_chat_messages
-- ============================================
-- USED BY:
-- ✓ frontend/src/utils/mock-search-history.ts
-- ✓ frontend/src/app/chat/history/page.tsx
-- ✓ frontend/src/components/sidebar/SidebarAIChat.tsx
-- ✓ frontend/src/components/sidebar/ChatHistoryPage.tsx

-- FIELDS MAPPED:
-- id → Message.id
-- role → Message.role
-- content → Message.content
-- tool_calls → Message.toolCalls (JSONB array)
-- timestamp → Message.timestamp

-- ============================================
-- TABLE: activities
-- ============================================
-- USED BY:
-- ✓ frontend/src/utils/mock-activity-data.ts
-- ✓ frontend/src/app/profile/activity/page.tsx

-- FIELDS MAPPED:
-- activity_type → Activity.type
-- message → Activity.message
-- date → Activity.date

-- ============================================
-- TABLE: achievements
-- ============================================
-- USED BY:
-- ✓ frontend/src/utils/mock-achievements-data.ts
-- ✓ frontend/src/app/profile/page.tsx

-- FIELDS MAPPED:
-- id → Achievement.id
-- label → Achievement.label
-- description → Achievement.description
-- icon → Achievement.icon
-- unlocked → Achievement.unlocked
-- unlocked_at → Achievement.unlockedAt

-- ============================================
-- CROSS-TABLE QUERIES (Multiple files)
-- ============================================

-- QUERY: Get listings with owner info
-- USED BY: Most listing display components
SELECT 
  l.*,
  u.full_name as seller_name,
  u.seller_rating,
  u.is_verified as seller_verified,
  u.avatar_url as seller_avatar
FROM listings l
JOIN users u ON l.user_id = u.id;
-- FILES:
-- ✓ frontend/src/app/threads/[threadCategory]/page.tsx
-- ✓ frontend/src/components/threads/category/ListingCard.tsx
-- ✓ frontend/src/components/threads/product/ProductDetailsTop.tsx

-- QUERY: Get matches with listing details
-- USED BY: Matching system components
SELECT 
  m.*,
  ml.title, ml.price, ml.location, ml.image_url,
  u.full_name, u.seller_rating, u.is_verified
FROM listing_matches m
JOIN listings ml ON m.matched_listing_id = ml.id
JOIN users u ON ml.user_id = u.id;
-- FILES:
-- ✓ frontend/src/components/matching/AIMatchingContainer.tsx
-- ✓ frontend/src/components/matching/desktop/AIMatchingKanban.tsx
-- ✓ frontend/src/components/matching/mobile/AIMatchingSwipe.tsx
-- ✓ frontend/src/components/matching/shared/MatchCard.tsx

-- QUERY: Get FAQs with nested replies
-- USED BY: FAQ display components
WITH RECURSIVE faq_tree AS (
  SELECT f.*, a.* FROM listing_faqs f
  LEFT JOIN faq_answers a ON f.id = a.faq_id
  -- ... recursive logic
);
-- FILES:
-- ✓ frontend/src/app/threads/[threadCategory]/[listingId]/faq/page.tsx
-- ✓ frontend/src/components/threads/product-faq/Question.tsx
-- ✓ frontend/src/components/threads/product-faq/Answer.tsx

-- QUERY: Get conversation messages
-- USED BY: Messaging components
SELECT 
  m.*,
  u.full_name, u.avatar_url, u.is_verified
FROM messages m
JOIN users u ON (m.sender_id = u.id OR m.recipient_id = u.id)
WHERE m.sender_id = ? OR m.recipient_id = ?;
-- FILES:
-- ✓ frontend/src/app/messages/page.tsx
-- ✓ frontend/src/components/messages/ChatWindow.tsx
-- ✓ frontend/src/components/messages/ConversationList.tsx

-- QUERY: Get AI chat history
-- USED BY: AI chat components
SELECT 
  s.id, s.title,
  array_agg(m.*) as messages
FROM ai_chat_sessions s
LEFT JOIN ai_chat_messages m ON s.id = m.session_id
GROUP BY s.id;
-- FILES:
-- ✓ frontend/src/app/chat/history/page.tsx
-- ✓ frontend/src/components/sidebar/SidebarAIChat.tsx
-- ✓ frontend/src/components/sidebar/ChatHistoryPage.tsx

-- ============================================
-- API ENDPOINT SUGGESTIONS
-- ============================================

/*
Based on the file usage, here are the API endpoints you'll need:

USERS:
  GET    /api/users/me                          → Get current user profile
  GET    /api/users/:id                         → Get user by ID
  PATCH  /api/users/me                          → Update user profile
  
THREADS:
  GET    /api/threads                           → List all threads/communities
  GET    /api/threads/:id                       → Get thread details
  GET    /api/threads/:id/stats                 → Get thread statistics
  
LISTINGS:
  GET    /api/listings                          → List all listings (with filters)
  GET    /api/listings/:id                      → Get listing details
  POST   /api/listings                          → Create new listing
  PATCH  /api/listings/:id                      → Update listing
  DELETE /api/listings/:id                      → Delete listing
  GET    /api/threads/:threadId/listings        → Get listings in thread
  
MATCHES:
  GET    /api/listings/:id/matches              → Get matches for listing
  POST   /api/matches/generate                  → Generate AI matches
  PATCH  /api/matches/:id                       → Update match status
  
FAQS:
  GET    /api/listings/:id/faqs                 → Get FAQs for listing
  POST   /api/listings/:id/faqs                 → Create new question
  POST   /api/faqs/:id/answers                  → Answer a question
  POST   /api/answers/:id/replies               → Reply to an answer
  PATCH  /api/answers/:id/vote                  → Vote on answer (like/dislike)
  
MESSAGES:
  GET    /api/messages                          → Get all conversations
  GET    /api/messages/conversation/:userId     → Get conversation with user
  POST   /api/messages                          → Send new message
  PATCH  /api/messages/:id/read                 → Mark message as read
  
AI CHAT:
  GET    /api/ai/sessions                       → Get chat history
  GET    /api/ai/sessions/:id                   → Get session messages
  POST   /api/ai/chat                           → Send message to AI
  DELETE /api/ai/sessions/:id                   → Delete chat session
  
ACTIVITIES:
  GET    /api/users/me/activities               → Get user activity feed
  
ACHIEVEMENTS:
  GET    /api/users/me/achievements             → Get user achievements
  PATCH  /api/achievements/:id/unlock           → Unlock achievement
*/

-- ============================================
-- FILE STRUCTURE SUMMARY
-- ============================================

/*
PAGES (Route Handlers):
├── /app/threads/page.tsx                      → threads table
├── /app/threads/[threadCategory]/page.tsx     → threads, listings tables
├── /app/threads/.../[listingId]/page.tsx      → listings, users tables
├── /app/threads/.../faq/page.tsx              → listing_faqs, faq_answers tables
├── /app/listings/page.tsx                     → listings, users tables
├── /app/listings/[listingId]/matches/page.tsx → listing_matches table
├── /app/messages/page.tsx                     → messages table
├── /app/chat/history/page.tsx                 → ai_chat_sessions, ai_chat_messages
├── /app/profile/page.tsx                      → users, achievements tables
└── /app/profile/activity/page.tsx             → activities table

COMPONENTS (Reusable UI):
├── /components/threads/*                      → threads, listings tables
├── /components/matching/*                     → listing_matches table
├── /components/messages/*                     → messages table
├── /components/sidebar/*                      → ai_chat_sessions, listings tables
└── /components/threads/product-faq/*          → listing_faqs, faq_answers tables

UTILS (Mock Data - Replace with API calls):
├── /utils/mock-user-data.ts                   → users table
├── /utils/mock-threads-data.ts                → threads, listings tables
├── /utils/mock-listings-data.ts               → listings table
├── /utils/mock-match-data.ts                  → listing_matches table
├── /utils/mock-threads-faq-data.ts            → listing_faqs, faq_answers tables
├── /utils/mock-messages.ts                    → messages table
├── /utils/mock-search-history.ts              → ai_chat_sessions, ai_chat_messages
├── /utils/mock-activity-data.ts               → activities table
└── /utils/mock-achievements-data.ts           → achievements table
*/
📋 Summary Table:
Table	Primary Files	Component Count
users	mock-user-data.ts, profile/page.tsx, Header.tsx	6 files
threads	mock-threads-data.ts, threads/page.tsx, ThreadCard.tsx	7 files
listings	mock-listings-data.ts, listings/page.tsx, ProductDetails.tsx	15+ files
listing_matches	mock-match-data.ts, AIMatchingContainer.tsx	9 files
listing_faqs	mock-threads-faq-data.ts, faq/page.tsx	6 files
faq_answers	mock-threads-faq-data.ts, Answer.tsx	3 files
messages	mock-messages.ts, messages/page.tsx, ChatWindow.tsx	7 files
ai_chat_sessions	mock-search-history.ts, chat/history/page.tsx	4 files
ai_chat_messages	mock-search-history.ts, ChatHistoryPage.tsx	4 files
activities	mock-activity-data.ts, profile/activity/page.tsx	2 files
achievements	mock-achievements-data.ts, profile/page.tsx	2 files
This mapping shows exactly which files need to be updated when you replace mock data with real API calls!
