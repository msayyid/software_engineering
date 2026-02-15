# DATABASE SCHEMA - ITEMS ONLY
## Community Item Sharing Platform

---

## COMPLETE DATABASE SCHEMA

### Sprint 3 Tables (Core/Essential)

#### 1. USERS TABLE
```sql
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    bio TEXT,
    location VARCHAR(255),  -- "Richmond, London"
    latitude DECIMAL(10, 8),  -- For Sprint 4 maps
    longitude DECIMAL(11, 8),  -- For Sprint 4 maps
    profile_pic VARCHAR(255) DEFAULT 'default-avatar.png',
    points INT DEFAULT 50,  -- Start with 50 welcome points
    average_rating DECIMAL(3, 2) DEFAULT 0.00,  -- Sprint 4
    total_ratings INT DEFAULT 0,  -- Sprint 4
    items_lent INT DEFAULT 0,
    items_borrowed INT DEFAULT 0,
    items_given INT DEFAULT 0,
    items_received INT DEFAULT 0,
    is_active BOOLEAN DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    INDEX idx_location (latitude, longitude),
    INDEX idx_email (email),
    INDEX idx_points (points)
);
```

**Example Data:**
```sql
INSERT INTO users (email, password_hash, first_name, last_name, bio, location, latitude, longitude) VALUES
('rashida7@roehampton.ac.uk', '$2b$10$...', 'Sarah', 'Johnson', 
 'Second year CS student. Always looking for textbooks and study materials!', 
 'Roehampton, London', 51.4567, -0.2634),
 
('norbaevm@roehampton.ac.uk', '$2b$10$...', 'David', 'Wilson',
 'Retired, downsizing. Have lots of tools and equipment to share!',
 'Richmond, London', 51.4613, -0.3037),
 
('salees@roehampton.ac.uk', '$2b$10$...', 'Maya', 'Patel',
 'Working mum of two. Love swapping baby items as kids outgrow them!',
 'Kingston, London', 51.4123, -0.3007);
```

---

#### 2. LISTINGS TABLE
```sql
CREATE TABLE listings (
    listing_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    category VARCHAR(100) NOT NULL,
    -- Categories: Tools & Equipment, Books & Media, Baby & Kids Items, 
    --            Sports & Outdoors, Household Items, Electronics, Other
    
    exchange_type ENUM('lending', 'swap', 'giveaway') NOT NULL,
    
    -- Item details
    condition_status ENUM('like_new', 'good', 'fair', 'well_used') NOT NULL,
    condition_notes TEXT,  -- Additional condition details
    
    -- Photos
    photo_url_1 VARCHAR(255),  -- Main photo
    photo_url_2 VARCHAR(255),  -- Additional photos
    photo_url_3 VARCHAR(255),
    
    -- Availability
    is_available BOOLEAN DEFAULT 1,
    
    -- For swaps: what they're looking for
    swap_preferences TEXT,  -- "Looking for: baby clothes 18-24 months"
    
    -- Stats
    view_count INT DEFAULT 0,
    request_count INT DEFAULT 0,
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    
    INDEX idx_category (category),
    INDEX idx_exchange_type (exchange_type),
    INDEX idx_user (user_id),
    INDEX idx_available (is_available),
    INDEX idx_created (created_at)
);
```

**Example Data:**
```sql
INSERT INTO listings (user_id, title, description, category, exchange_type, condition_status, photo_url_1) VALUES
(1, 'Statistics for Business Textbook', 
 'Intro to Statistics textbook, 3rd edition. Some highlighting but good condition. Perfect for business/CS students.',
 'Books & Media', 'lending', 'good', 'stats-book.jpg'),
 
(2, 'Cordless Power Drill Set',
 'Bosch 18V cordless drill with charger and 20-piece bit set. Barely used, great condition.',
 'Tools & Equipment', 'lending', 'like_new', 'drill.jpg'),
 
(3, 'Baby Clothes Bundle 6-12 months',
 'Bundle of 20 baby outfits, sizes 6-12 months. Boys clothes, excellent condition. Swap for 18-24 month clothes!',
 'Baby & Kids Items', 'swap', 'like_new', 'baby-clothes.jpg'),

(2, 'Old Garden Tools',
 'Collection of hand tools: trowels, pruners, hand rake. Getting new set, these free to good home.',
 'Tools & Equipment', 'giveaway', 'well_used', 'garden-tools.jpg');
```

---

#### 3. CATEGORIES TABLE
```sql
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    icon VARCHAR(50),  -- Icon name for UI
    listing_count INT DEFAULT 0,  -- Cached count for performance
    
    INDEX idx_name (category_name)
);
```

**Example Data:**
```sql
INSERT INTO categories (category_name, description, icon) VALUES
('Tools & Equipment', 'Power tools, hand tools, DIY equipment, garden tools', 'wrench'),
('Books & Media', 'Textbooks, novels, magazines, DVDs, video games', 'book'),
('Baby & Kids Items', 'Clothes, toys, equipment, furniture for babies and children', 'baby'),
('Sports & Outdoors', 'Sports equipment, camping gear, bicycles, outdoor items', 'football'),
('Household Items', 'Kitchen items, furniture, decor, appliances', 'home'),
('Electronics', 'Gadgets, cables, accessories (no phones/laptops for safety)', 'laptop'),
('Other', 'Items that don\'t fit other categories', 'tag');
```

---

#### 4. TAGS TABLE
```sql
CREATE TABLE tags (
    tag_id INT AUTO_INCREMENT PRIMARY KEY,
    tag_name VARCHAR(50) UNIQUE NOT NULL,
    usage_count INT DEFAULT 0,
    
    INDEX idx_tag_name (tag_name)
);
```

**Example Data:**
```sql
INSERT INTO tags (tag_name) VALUES
('textbook'), ('study'), ('CS'), ('business'),
('power-tools'), ('DIY'), ('cordless'), ('bosch'),
('baby'), ('clothes'), ('6-12-months'), ('boys'),
('camping'), ('tent'), ('sleeping-bag'),
('kitchen'), ('cookware'), ('sports'), ('bicycle');
```

---

#### 5. LISTING_TAGS TABLE (Junction)
```sql
CREATE TABLE listing_tags (
    listing_id INT NOT NULL,
    tag_id INT NOT NULL,
    
    PRIMARY KEY (listing_id, tag_id),
    FOREIGN KEY (listing_id) REFERENCES listings(listing_id) ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES tags(tag_id) ON DELETE CASCADE,
    
    INDEX idx_listing (listing_id),
    INDEX idx_tag (tag_id)
);
```

---

#### 6. REQUESTS TABLE
```sql
CREATE TABLE requests (
    request_id INT AUTO_INCREMENT PRIMARY KEY,
    listing_id INT NOT NULL,
    requester_id INT NOT NULL,
    
    status ENUM('pending', 'accepted', 'declined', 'completed', 'cancelled') DEFAULT 'pending',
    
    -- Request details
    message TEXT,  -- "Hi, can I borrow this for the weekend?"
    requested_duration VARCHAR(100),  -- "a weekend", "2 weeks", "until end of month"
    
    -- For swaps: what requester is offering
    swap_offer_description TEXT,  -- "I can swap for my toddler clothes 18-24m"
    
    -- Timestamps
    requested_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    responded_date TIMESTAMP NULL,
    completed_date TIMESTAMP NULL,  -- When item returned/swap done
    
    -- Admin
    owner_notes TEXT,  -- Private notes for item owner
    
    FOREIGN KEY (listing_id) REFERENCES listings(listing_id) ON DELETE CASCADE,
    FOREIGN KEY (requester_id) REFERENCES users(user_id) ON DELETE CASCADE,
    
    INDEX idx_listing (listing_id),
    INDEX idx_requester (requester_id),
    INDEX idx_status (status),
    INDEX idx_requested_date (requested_date)
);
```

**Example Data:**
```sql
INSERT INTO requests (listing_id, requester_id, status, message, requested_duration) VALUES
(1, 3, 'accepted', 
 'Hi Sarah! Need this for my stats exam next month. Can collect anytime!', 
 '4 weeks'),
 
(2, 1, 'pending',
 'Hi David! Need to drill some holes for shelving this weekend. Can I borrow Friday-Sunday?',
 'weekend'),
 
(3, 2, 'completed',
 'Hi Maya! These are perfect for my granddaughter. I have some 18-24m clothes to swap!',
 NULL);  -- Swap, so duration not applicable
```

---

### Sprint 4 Tables (Advanced Features)

#### 7. RATINGS TABLE
```sql
CREATE TABLE ratings (
    rating_id INT AUTO_INCREMENT PRIMARY KEY,
    request_id INT NOT NULL,  -- Which exchange being rated
    rater_id INT NOT NULL,  -- Who gave the rating
    rated_id INT NOT NULL,  -- Who being rated
    
    score INT NOT NULL CHECK (score BETWEEN 1 AND 5),
    comment TEXT,
    
    -- Context
    rating_type ENUM('as_lender', 'as_borrower', 'as_swapper', 'as_giver', 'as_receiver'),
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (request_id) REFERENCES requests(request_id) ON DELETE CASCADE,
    FOREIGN KEY (rater_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (rated_id) REFERENCES users(user_id) ON DELETE CASCADE,
    
    -- Each user can only rate once per request
    UNIQUE KEY unique_rating (request_id, rater_id),
    
    INDEX idx_rated_user (rated_id),
    INDEX idx_score (score),
    INDEX idx_created (created_at)
);
```

**Example Data:**
```sql
INSERT INTO ratings (request_id, rater_id, rated_id, score, comment, rating_type) VALUES
(1, 3, 1, 5, 
 'Sarah was super helpful! Book was exactly as described and in great condition.',
 'as_lender'),
 
(1, 1, 3, 5,
 'Maya returned the book on time and in perfect condition. Great borrower!',
 'as_borrower'),
 
(3, 2, 3, 5,
 'Smooth swap! Maya\'s baby clothes were perfect. Highly recommend!',
 'as_swapper');
```

---

#### 8. MESSAGES TABLE
```sql
CREATE TABLE messages (
    message_id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id INT NOT NULL,
    receiver_id INT NOT NULL,
    
    -- Context
    request_id INT,  -- Optional: link to specific request/item
    listing_id INT,  -- Optional: link to specific listing
    
    content TEXT NOT NULL,
    
    is_read BOOLEAN DEFAULT 0,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (sender_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (request_id) REFERENCES requests(request_id) ON DELETE SET NULL,
    FOREIGN KEY (listing_id) REFERENCES listings(listing_id) ON DELETE SET NULL,
    
    INDEX idx_sender (sender_id),
    INDEX idx_receiver (receiver_id),
    INDEX idx_conversation (sender_id, receiver_id),
    INDEX idx_unread (receiver_id, is_read),
    INDEX idx_sent (sent_at)
);
```

**Example Data:**
```sql
INSERT INTO messages (sender_id, receiver_id, request_id, content) VALUES
(1, 2, 2, 'Hi David! Is the drill still available?'),
(2, 1, 2, 'Hi Sarah! Yes, available this weekend. When do you need it?'),
(1, 2, 2, 'Perfect! Can I pick up Friday evening around 6pm?'),
(2, 1, 2, 'Friday 6pm works great! My address is 123 Oak Street. See you then!');
```

---

#### 9. USER_PREFERENCES TABLE (Optional - for matching)
```sql
CREATE TABLE user_preferences (
    preference_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    
    -- Preferences
    preferred_categories JSON,  -- ["Books & Media", "Electronics"]
    max_distance_km INT DEFAULT 10,
    notification_enabled BOOLEAN DEFAULT 1,
    email_notifications BOOLEAN DEFAULT 1,
    
    -- Interests (for matching algorithm)
    recent_searches JSON,  -- Last 10 searches
    browsing_history JSON,  -- Last 20 viewed items
    
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);
```

---

#### 10. EXCHANGE_HISTORY TABLE (Optional - track completed exchanges)
```sql
CREATE TABLE exchange_history (
    exchange_id INT AUTO_INCREMENT PRIMARY KEY,
    request_id INT NOT NULL,
    listing_id INT NOT NULL,
    
    owner_id INT NOT NULL,
    requester_id INT NOT NULL,
    
    exchange_type ENUM('lending', 'swap', 'giveaway'),
    
    -- Points awarded
    points_to_owner INT DEFAULT 0,
    points_to_requester INT DEFAULT 0,
    
    completed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (request_id) REFERENCES requests(request_id),
    FOREIGN KEY (listing_id) REFERENCES listings(listing_id),
    FOREIGN KEY (owner_id) REFERENCES users(user_id),
    FOREIGN KEY (requester_id) REFERENCES users(user_id),
    
    INDEX idx_owner (owner_id),
    INDEX idx_requester (requester_id),
    INDEX idx_completed (completed_at)
);
```

---

## DATABASE RELATIONSHIPS (ERD)

```
┌─────────────────┐
│     USERS       │
│─────────────────│
│ user_id (PK)    │◄────┐
│ email           │     │
│ password_hash   │     │
│ first_name      │     │
│ last_name       │     │
│ bio             │     │
│ location        │     │ ONE USER
│ latitude        │     │ HAS MANY
│ longitude       │     │ LISTINGS
│ points          │     │
│ average_rating  │     │
│ items_lent      │     │
│ items_borrowed  │     │
└─────────────────┘     │
        ▲               │
        │               │
        │ ONE USER      │
        │ MAKES MANY    │
        │ REQUESTS      │
        │               │
        │         ┌─────────────────┐
        │         │    LISTINGS     │
        │         │─────────────────│
        └─────────┤ listing_id (PK) │
                  │ user_id (FK)    │◄────┐
                  │ title           │     │
                  │ description     │     │
                  │ category        │     │
                  │ exchange_type   │     │ ONE LISTING
                  │ condition       │     │ HAS MANY
                  │ photo_url_1/2/3 │     │ REQUESTS
                  │ is_available    │     │
                  └─────────────────┘     │
                          ▲               │
                          │               │
                          │ MANY-TO-MANY  │
                          │ WITH TAGS     │
                          │               │
                  ┌───────┴──────────┐    │
                  │  LISTING_TAGS    │    │
                  │──────────────────│    │
                  │ listing_id (FK)  │    │
                  │ tag_id (FK)      │    │
                  └──────────────────┘    │
                          │               │
                          ▼               │
                  ┌─────────────────┐     │
                  │      TAGS       │     │
                  │─────────────────│     │
                  │ tag_id (PK)     │     │
                  │ tag_name        │     │
                  └─────────────────┘     │
                                          │
                  ┌─────────────────┐     │
                  │   CATEGORIES    │     │
                  │─────────────────│     │
                  │ category_id(PK) │     │
                  │ category_name   │     │
                  │ description     │     │
                  └─────────────────┘     │
                                          │
        ┌─────────────────────────────────┘
        │
        ▼
┌─────────────────┐
│    REQUESTS     │
│─────────────────│
│ request_id (PK) │◄────┐
│ listing_id (FK) │     │
│ requester_id(FK)│     │ ONE REQUEST
│ status          │     │ CAN HAVE
│ message         │     │ MULTIPLE
│ duration        │     │ RATINGS
│ requested_date  │     │
│ completed_date  │     │
└─────────────────┘     │
        │               │
        │ ONE REQUEST   │
        │ HAS MESSAGES  │
        │               │
        ▼         ┌─────────────────┐
┌─────────────────┐     │    RATINGS      │
│    MESSAGES     │     │─────────────────│
│─────────────────│     │ rating_id (PK)  │
│ message_id (PK) │     │ request_id (FK) │
│ sender_id (FK)  │     │ rater_id (FK)   │
│ receiver_id(FK) │     │ rated_id (FK)   │
│ request_id (FK) │────►│ score (1-5)     │
│ listing_id (FK) │     │ comment         │
│ content         │     │ rating_type     │
│ is_read         │     └─────────────────┘
│ sent_at         │
└─────────────────┘
```

---

## KEY SQL QUERIES FOR COMMON OPERATIONS

### 1. Browse All Available Items (Listings Page)
```sql
SELECT 
    l.*,
    u.first_name,
    u.last_name,
    u.average_rating,
    u.location,
    GROUP_CONCAT(DISTINCT t.tag_name) as tags,
    COUNT(DISTINCT r.request_id) as total_requests
FROM listings l
JOIN users u ON l.user_id = u.user_id
LEFT JOIN listing_tags lt ON l.listing_id = lt.listing_id
LEFT JOIN tags t ON lt.tag_id = t.tag_id
LEFT JOIN requests r ON l.listing_id = r.listing_id
WHERE l.is_available = 1
GROUP BY l.listing_id
ORDER BY l.created_at DESC;
```

---

### 2. Get Single Listing Detail
```sql
SELECT 
    l.*,
    u.user_id,
    u.first_name,
    u.last_name,
    u.bio,
    u.location,
    u.profile_pic,
    u.average_rating,
    u.points,
    u.items_lent,
    u.items_given
FROM listings l
JOIN users u ON l.user_id = u.user_id
WHERE l.listing_id = ?;

-- Get tags for this listing
SELECT t.* 
FROM tags t
JOIN listing_tags lt ON t.tag_id = lt.tag_id
WHERE lt.listing_id = ?;
```

---

### 3. Search Items
```sql
SELECT DISTINCT
    l.*,
    u.first_name,
    u.last_name,
    u.location
FROM listings l
JOIN users u ON l.user_id = u.user_id
LEFT JOIN listing_tags lt ON l.listing_id = lt.listing_id
LEFT JOIN tags t ON lt.tag_id = t.tag_id
WHERE l.is_available = 1
AND (
    l.title LIKE CONCAT('%', ?, '%')
    OR l.description LIKE CONCAT('%', ?, '%')
    OR l.category LIKE CONCAT('%', ?, '%')
    OR t.tag_name LIKE CONCAT('%', ?, '%')
)
ORDER BY l.created_at DESC;
```

---

### 4. Filter by Category and Exchange Type
```sql
SELECT l.*, u.first_name, u.last_name
FROM listings l
JOIN users u ON l.user_id = u.user_id
WHERE l.is_available = 1
AND l.category = ?  -- 'Books & Media'
AND l.exchange_type = ?  -- 'lending'
ORDER BY l.created_at DESC;
```

---

### 5. Get Nearby Items (Sprint 4 - Maps)
```sql
SELECT 
    l.*,
    u.first_name,
    u.last_name,
    u.latitude,
    u.longitude,
    ( 6371 * acos( 
        cos( radians(?) ) 
        * cos( radians( u.latitude ) ) 
        * cos( radians( u.longitude ) - radians(?) ) 
        + sin( radians(?) ) 
        * sin( radians( u.latitude ) ) 
    )) AS distance_km
FROM listings l
JOIN users u ON l.user_id = u.user_id
WHERE l.is_available = 1
AND u.latitude IS NOT NULL
AND u.longitude IS NOT NULL
HAVING distance_km < ?  -- e.g., 10km
ORDER BY distance_km ASC;
```

---

### 6. User Dashboard - My Listings
```sql
-- My active listings
SELECT l.*, COUNT(r.request_id) as pending_requests
FROM listings l
LEFT JOIN requests r ON l.listing_id = r.listing_id AND r.status = 'pending'
WHERE l.user_id = ?
GROUP BY l.listing_id
ORDER BY l.created_at DESC;
```

---

### 7. User Dashboard - My Requests
```sql
-- Requests I've made
SELECT 
    r.*,
    l.title,
    l.exchange_type,
    l.photo_url_1,
    u.first_name,
    u.last_name
FROM requests r
JOIN listings l ON r.listing_id = l.listing_id
JOIN users u ON l.user_id = u.user_id
WHERE r.requester_id = ?
ORDER BY r.requested_date DESC;

-- Requests on my listings
SELECT 
    r.*,
    l.title,
    l.exchange_type,
    u.first_name,
    u.last_name,
    u.profile_pic,
    u.average_rating
FROM requests r
JOIN listings l ON r.listing_id = l.listing_id
JOIN users u ON r.requester_id = u.user_id
WHERE l.user_id = ?
AND r.status = 'pending'
ORDER BY r.requested_date DESC;
```

---

### 8. Award Points (Sprint 4)
```sql
-- When request accepted - award points to requester
UPDATE users
SET points = points + 10
WHERE user_id = ?;

-- When item lent - award points to owner
UPDATE users
SET points = points + 5,
    items_lent = items_lent + 1
WHERE user_id = ?;

-- When swap completed - both get points
UPDATE users
SET points = points + 20,
    items_given = items_given + 1
WHERE user_id IN (?, ?);
```

---

### 9. Calculate Average Rating (Sprint 4)
```sql
-- After new rating submitted
SELECT 
    AVG(score) as avg_rating, 
    COUNT(*) as rating_count
FROM ratings
WHERE rated_id = ?;

-- Update user's rating
UPDATE users
SET average_rating = ?,
    total_ratings = ?
WHERE user_id = ?;
```

---

### 10. Get Recommendations (Sprint 4 - Matching Algorithm)
```sql
-- Based on user's request history and location
SELECT 
    l.*,
    u.first_name,
    u.last_name,
    ( 6371 * acos( cos( radians(?) ) 
    * cos( radians( u.latitude ) ) 
    * cos( radians( u.longitude ) - radians(?) ) 
    + sin( radians(?) ) 
    * sin( radians( u.latitude ) ) ) ) AS distance_km,
    COUNT(r.request_id) as popularity_score
FROM listings l
JOIN users u ON l.user_id = u.user_id
LEFT JOIN requests r ON l.listing_id = r.listing_id
WHERE l.is_available = 1
AND l.user_id != ?  -- Not own items
AND l.category IN (
    -- Categories user has requested before
    SELECT DISTINCT l2.category
    FROM requests r2
    JOIN listings l2 ON r2.listing_id = l2.listing_id
    WHERE r2.requester_id = ?
)
GROUP BY l.listing_id
HAVING distance_km < 10
ORDER BY 
    popularity_score DESC,
    distance_km ASC
LIMIT 10;
```

---

### 11. Message Conversation
```sql
-- Get conversation between two users
SELECT 
    m.*,
    u1.first_name as sender_name,
    u2.first_name as receiver_name
FROM messages m
JOIN users u1 ON m.sender_id = u1.user_id
JOIN users u2 ON m.receiver_id = u2.user_id
WHERE (m.sender_id = ? AND m.receiver_id = ?)
   OR (m.sender_id = ? AND m.receiver_id = ?)
ORDER BY m.sent_at ASC;

-- Mark messages as read
UPDATE messages
SET is_read = 1
WHERE receiver_id = ?
AND sender_id = ?
AND is_read = 0;

-- Get unread message count
SELECT COUNT(*) as unread_count
FROM messages
WHERE receiver_id = ?
AND is_read = 0;
```

---

## INDEXES EXPLAINED

Key indexes for performance:

1. **Location indexes** (latitude, longitude) - Fast geospatial queries for maps
2. **Status indexes** - Quick filtering of available items, pending requests
3. **User indexes** - Fast lookups for profiles and listings
4. **Date indexes** - Efficient sorting by newest/oldest
5. **Conversation indexes** - Fast message retrieval

---

This database schema is optimized for **item sharing only** with three exchange types (lending, swapping, giving away) and supports all Sprint 4 advanced features!
