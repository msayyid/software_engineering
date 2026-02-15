# SPRINT 2: ERD (ENTITY RELATIONSHIP DIAGRAM)
## Community Item Sharing Platform - Items Only

The ERD shows database tables and their relationships.

---

## ENTITIES (TABLES) - SPRINT 3

### 1. USERS
**Attributes:**
- user_id (PK, INT, AUTO_INCREMENT)
- email (VARCHAR, UNIQUE, NOT NULL)
- password_hash (VARCHAR, NOT NULL)
- first_name (VARCHAR, NOT NULL)
- last_name (VARCHAR, NOT NULL)
- bio (TEXT, NULLABLE)
- location (VARCHAR, NOT NULL)
- latitude (DECIMAL, NULLABLE) - Sprint 4
- longitude (DECIMAL, NULLABLE) - Sprint 4
- profile_pic (VARCHAR, DEFAULT 'default-avatar.png')
- points (INT, DEFAULT 50) - Sprint 4
- average_rating (DECIMAL, DEFAULT 0.00) - Sprint 4
- total_ratings (INT, DEFAULT 0) - Sprint 4
- items_lent (INT, DEFAULT 0)
- items_borrowed (INT, DEFAULT 0)
- items_given (INT, DEFAULT 0)
- is_active (BOOLEAN, DEFAULT 1)
- created_at (TIMESTAMP)
- updated_at (TIMESTAMP)

### 2. LISTINGS
**Attributes:**
- listing_id (PK, INT, AUTO_INCREMENT)
- user_id (FK → users.user_id, NOT NULL)
- title (VARCHAR, NOT NULL)
- description (TEXT, NOT NULL)
- category (VARCHAR, NOT NULL)
- exchange_type (ENUM: 'lending', 'swap', 'giveaway', NOT NULL)
- condition_status (ENUM: 'like_new', 'good', 'fair', 'well_used', NOT NULL)
- condition_notes (TEXT, NULLABLE)
- photo_url_1 (VARCHAR, NULLABLE)
- photo_url_2 (VARCHAR, NULLABLE)
- photo_url_3 (VARCHAR, NULLABLE)
- swap_preferences (TEXT, NULLABLE)
- is_available (BOOLEAN, DEFAULT 1)
- view_count (INT, DEFAULT 0)
- request_count (INT, DEFAULT 0)
- created_at (TIMESTAMP)
- updated_at (TIMESTAMP)

### 3. REQUESTS
**Attributes:**
- request_id (PK, INT, AUTO_INCREMENT)
- listing_id (FK → listings.listing_id, NOT NULL)
- requester_id (FK → users.user_id, NOT NULL)
- status (ENUM: 'pending', 'accepted', 'declined', 'completed', 'cancelled', DEFAULT 'pending')
- message (TEXT, NOT NULL)
- requested_duration (VARCHAR, NULLABLE)
- swap_offer_description (TEXT, NULLABLE)
- requested_date (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
- responded_date (TIMESTAMP, NULLABLE)
- completed_date (TIMESTAMP, NULLABLE)
- owner_notes (TEXT, NULLABLE)

### 4. CATEGORIES
**Attributes:**
- category_id (PK, INT, AUTO_INCREMENT)
- category_name (VARCHAR, UNIQUE, NOT NULL)
- description (TEXT, NULLABLE)
- icon (VARCHAR, NULLABLE)
- listing_count (INT, DEFAULT 0)

### 5. TAGS
**Attributes:**
- tag_id (PK, INT, AUTO_INCREMENT)
- tag_name (VARCHAR, UNIQUE, NOT NULL)
- usage_count (INT, DEFAULT 0)

### 6. LISTING_TAGS (Junction Table)
**Attributes:**
- listing_id (FK → listings.listing_id, NOT NULL)
- tag_id (FK → tags.tag_id, NOT NULL)
- PRIMARY KEY (listing_id, tag_id)

---

## ENTITIES (TABLES) - SPRINT 4

### 7. RATINGS
**Attributes:**
- rating_id (PK, INT, AUTO_INCREMENT)
- request_id (FK → requests.request_id, NOT NULL)
- rater_id (FK → users.user_id, NOT NULL)
- rated_id (FK → users.user_id, NOT NULL)
- score (INT, CHECK 1-5, NOT NULL)
- comment (TEXT, NULLABLE)
- rating_type (ENUM: 'as_lender', 'as_borrower', 'as_swapper', 'as_giver', 'as_receiver')
- created_at (TIMESTAMP)

### 8. MESSAGES
**Attributes:**
- message_id (PK, INT, AUTO_INCREMENT)
- sender_id (FK → users.user_id, NOT NULL)
- receiver_id (FK → users.user_id, NOT NULL)
- request_id (FK → requests.request_id, NULLABLE)
- listing_id (FK → listings.listing_id, NULLABLE)
- content (TEXT, NOT NULL)
- is_read (BOOLEAN, DEFAULT 0)
- sent_at (TIMESTAMP)

---

## RELATIONSHIPS

### ONE-TO-MANY Relationships:

1. **USERS → LISTINGS** (1:N)
   - One user can create many listings
   - FK: listings.user_id → users.user_id
   - ON DELETE: CASCADE (if user deleted, delete their listings)

2. **LISTINGS → REQUESTS** (1:N)
   - One listing can have many requests
   - FK: requests.listing_id → listings.listing_id
   - ON DELETE: CASCADE (if listing deleted, delete requests)

3. **USERS → REQUESTS** (1:N)
   - One user can make many requests
   - FK: requests.requester_id → users.user_id
   - ON DELETE: CASCADE (if user deleted, delete their requests)

4. **REQUESTS → RATINGS** (1:N) - Sprint 4
   - One request can have multiple ratings (both parties rate each other)
   - FK: ratings.request_id → requests.request_id
   - ON DELETE: CASCADE

5. **USERS → RATINGS (as rater)** (1:N) - Sprint 4
   - One user can give many ratings
   - FK: ratings.rater_id → users.user_id
   - ON DELETE: CASCADE

6. **USERS → RATINGS (as rated)** (1:N) - Sprint 4
   - One user can receive many ratings
   - FK: ratings.rated_id → users.user_id
   - ON DELETE: CASCADE

7. **USERS → MESSAGES (as sender)** (1:N) - Sprint 4
   - One user can send many messages
   - FK: messages.sender_id → users.user_id
   - ON DELETE: CASCADE

8. **USERS → MESSAGES (as receiver)** (1:N) - Sprint 4
   - One user can receive many messages
   - FK: messages.receiver_id → users.user_id
   - ON DELETE: CASCADE

### MANY-TO-MANY Relationships:

9. **LISTINGS ↔ TAGS** (M:N)
   - One listing can have many tags
   - One tag can be on many listings
   - Junction table: LISTING_TAGS
   - FK1: listing_tags.listing_id → listings.listing_id
   - FK2: listing_tags.tag_id → tags.tag_id

---

## ERD DIAGRAM (ASCII)

```
┌────────────────────────┐
│        USERS           │
│────────────────────────│
│ PK user_id             │
│    email               │
│    password_hash       │
│    first_name          │
│    last_name           │
│    bio                 │
│    location            │
│    latitude            │◄────┐
│    longitude           │     │
│    profile_pic         │     │
│    points              │     │ ONE USER
│    average_rating      │     │ HAS MANY
│    created_at          │     │ LISTINGS
└────────────┬───────────┘     │
             │                 │
             │ 1               │
             │                 │
             │                 │
      ┌──────┴──────────┐      │
      │ ONE USER        │      │
      │ MAKES MANY      │      │
      │ REQUESTS        │      │
      └─────────────────┘      │
             │                 │
             │ N               │
             ▼                 │
┌────────────────────────┐     │
│      REQUESTS          │     │
│────────────────────────│     │
│ PK request_id          │     │
│ FK listing_id          │◄────┼─────┐
│ FK requester_id        │◄────┘     │
│    status              │           │ ONE LISTING
│    message             │           │ HAS MANY
│    duration            │           │ REQUESTS
│    swap_offer          │           │
│    requested_date      │           │
│    responded_date      │           │
│    completed_date      │           │
└────────────┬───────────┘           │
             │                       │
             │ 1                     │
             │                       │
             │ REQUESTS              │
             │ CAN HAVE              │
             │ RATINGS               │
             │                       │
             │ N                     │
             ▼                       │
┌────────────────────────┐           │
│       RATINGS          │           │
│  (Sprint 4)            │           │
│────────────────────────│           │
│ PK rating_id           │           │
│ FK request_id          │           │
│ FK rater_id            │           │
│ FK rated_id            │           │
│    score               │           │
│    comment             │           │
│    rating_type         │           │
│    created_at          │           │
└────────────────────────┘           │
                                     │
                                     │ 1
                                     │
┌────────────────────────┐           │
│      LISTINGS          │◄──────────┘
│────────────────────────│
│ PK listing_id          │
│ FK user_id             │
│    title               │
│    description         │
│    category            │
│    exchange_type       │
│    condition_status    │
│    condition_notes     │
│    photo_url_1         │
│    photo_url_2         │
│    photo_url_3         │
│    swap_preferences    │
│    is_available        │
│    view_count          │
│    created_at          │
└────────────┬───────────┘
             │
             │ N
             │
      ┌──────┴─────────┐
      │ MANY-TO-MANY   │
      │ WITH TAGS      │
      └────────────────┘
             │
             │
             ▼
┌────────────────────────┐
│    LISTING_TAGS        │
│  (Junction Table)      │
│────────────────────────│
│ PK,FK listing_id       │
│ PK,FK tag_id           │
└────────────┬───────────┘
             │
             │ N
             ▼
┌────────────────────────┐
│        TAGS            │
│────────────────────────│
│ PK tag_id              │
│    tag_name            │
│    usage_count         │
└────────────────────────┘


┌────────────────────────┐
│      CATEGORIES        │
│  (Reference Table)     │
│────────────────────────│
│ PK category_id         │
│    category_name       │
│    description         │
│    icon                │
│    listing_count       │
└────────────────────────┘


┌────────────────────────┐
│      MESSAGES          │
│  (Sprint 4)            │
│────────────────────────│
│ PK message_id          │
│ FK sender_id           │
│ FK receiver_id         │
│ FK request_id          │
│ FK listing_id          │
│    content             │
│    is_read             │
│    sent_at             │
└────────────────────────┘
```

---

## CARDINALITY SUMMARY

| Relationship | Cardinality | Description |
|---|---|---|
| Users → Listings | 1:N | One user creates many listings |
| Users → Requests (requester) | 1:N | One user makes many requests |
| Listings → Requests | 1:N | One listing gets many requests |
| Requests → Ratings | 1:N | One request gets multiple ratings |
| Users → Ratings (rater) | 1:N | One user gives many ratings |
| Users → Ratings (rated) | 1:N | One user receives many ratings |
| Listings ↔ Tags | M:N | Many-to-many via LISTING_TAGS |
| Users → Messages (sender) | 1:N | One user sends many messages |
| Users → Messages (receiver) | 1:N | One user receives many messages |

---

## KEY CONSTRAINTS

1. **Email uniqueness**: UNIQUE constraint on users.email
2. **Tag uniqueness**: UNIQUE constraint on tags.tag_name
3. **Category uniqueness**: UNIQUE constraint on categories.category_name
4. **Composite PK**: listing_tags has composite primary key (listing_id, tag_id)
5. **One rating per exchange per user**: UNIQUE constraint on ratings(request_id, rater_id)
6. **Check constraint**: ratings.score must be between 1 and 5
7. **Cascade deletes**: Most foreign keys CASCADE on delete

---

## INDEXES FOR PERFORMANCE

- users.email (UNIQUE automatically indexed)
- users.latitude, users.longitude (for Sprint 4 distance queries)
- listings.user_id, listings.category, listings.is_available
- requests.listing_id, requests.requester_id, requests.status
- listing_tags.listing_id, listing_tags.tag_id
- ratings.rated_id (for calculating average_rating)
- messages.sender_id, messages.receiver_id, messages.is_read

---

This ERD represents your complete database structure!
