# Ngam-Je Database Schema Documentation (v-2)
## Marketplace Platform - Table Descriptions
Schema: 

---

## 📊 Core Tables

### **users**
Stores all user account information including profile details, verification status, token balance, and seller ratings. This is the central table that connects to almost all other tables in the system.

**Key Fields:** email, username, is_verified, tokens_balance, seller_rating, total_sales

---

### **threads**
Represents discussion/marketplace threads (e.g., "Pre-loved Apple", "Nintendo Lovers"). Each thread acts as a container for related listings and has its own boost level determined by community contributions.

**Key Fields:** id, title, category, boost_level, boost_points, is_hot, is_pinned

---

### **listings**
Individual marketplace items posted by users. Can be either "for-sale" or "want-to-buy" (WTB). Each listing belongs to a thread and has an expiration date that can be extended based on thread boost level.

**Key Fields:** id, user_id, thread_id, listing_type, price, status, expires_at

---

## 🔗 Relationship Tables

### **thread_members**
Tracks which users have joined which threads. Users must join a thread to participate in it (create listings, view matches, etc.).

**Key Fields:** user_id, thread_id, joined_at, is_favorite

---

### **listing_matches**
AI-generated matches between compatible listings (e.g., a WTB listing matched with a for-sale listing). Each match has a score (0-100) and quality rating (excellent/good/possible).

**Key Fields:** source_listing_id, matched_listing_id, match_score, match_quality, status

---

### **mutual_matches**
Created when both buyer and seller show interest in each other's listings. Represents an active connection between two users ready to negotiate.

**Key Fields:** buyer_listing_id, seller_listing_id, buyer_user_id, seller_user_id, is_mutual, status

---

### **match_interactions**
Tracks user actions on listing matches (viewed, interested, contacted, dismissed, reported). Used for analytics and to prevent showing the same match repeatedly.

**Key Fields:** user_id, match_id, action_type, metadata

---

## 💬 Communication Tables

### **messages**
Direct messages between users. Can be linked to a specific listing or mutual match for context. Used for negotiations and deal-making.

**Key Fields:** sender_id, recipient_id, listing_id, mutual_match_id, content, is_read

---

### **listing_faqs**
Public Q&A on listings. Users can ask questions, sellers can answer, and others can reply. Supports threaded conversations with parent-child relationships.

**Key Fields:** listing_id, user_id, parent_id, type (question/answer/reply), is_accepted

---

## 🤖 AI Tables

### **ai_chat_sessions**
Represents a conversation session between a user and the AI assistant. Each session has a mode (reactive/proactive) and can span multiple messages.

**Key Fields:** user_id, title, mode, created_at

---

### **ai_chat_messages**
Individual messages within an AI chat session. Stores both user messages and AI responses, along with metadata about tool usage.

**Key Fields:** session_id, role (user/assistant), content, tool_calls, tool_results

---

### **ai_actions**
Logs specific actions taken by the AI on behalf of users (e.g., searching listings, sending messages, setting reminders). Tracks execution status and results.

**Key Fields:** session_id, message_id, action_type, action_input, action_output, status

---

## 🚀 Boost System Tables

### **boost_levels_config**
Defines the boost tier system (Bronze/Silver/Gold). Each level requires a certain number of boost points and grants specific perks like extended listing duration.

**Key Fields:** level, points_required, perks_granted (JSON), description

---

### **thread_boost_contributions**
Records individual user contributions (tokens) to boost a thread. Aggregate contributions determine the thread's boost level.

**Key Fields:** user_id, thread_id, amount, contributed_at

---

## 🔄 Data Flow Summary

**User Journey:**
1. User joins thread → `thread_members`
2. User creates listing → `listings`
3. AI finds matches → `listing_matches`
4. User views match → `match_interactions`
5. Both users interested → `mutual_matches`
6. Users message each other → `messages`
7. Public asks questions → `listing_faqs`
8. User uses AI help → `ai_chat_sessions` → `ai_chat_messages` → `ai_actions`
9. User boosts thread → `thread_boost_contributions` → updates `threads.boost_level`

---

## 📈 Key Metrics Tracked

- **User Engagement:** thread joins, listing views, match interactions
- **Marketplace Activity:** active listings, successful matches, message volume
- **AI Usage:** session count, action completion rate, user satisfaction
- **Community Health:** boost contributions, FAQ participation, response times
- **Transaction Success:** mutual matches, deal completion rate

---

## 🔐 Important Notes

### Foreign Key Relationships
- All user-related tables CASCADE on user deletion
- Listing deletions SET NULL on messages (preserves history)
- Thread deletions CASCADE through all related data

### Indexes
Every table has performance indexes on:
- Foreign keys (user_id, thread_id, listing_id)
- Frequently queried fields (status, created_at, expires_at)
- Search fields (match_score, price, category)

### Data Retention
- Expired listings remain in DB with status='expired'
- Completed matches stay for analytics (status='deal_made')
- AI chat history retained for context and learning
