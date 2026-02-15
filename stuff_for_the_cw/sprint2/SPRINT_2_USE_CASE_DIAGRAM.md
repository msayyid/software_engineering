# SPRINT 2: USE CASE DIAGRAM
## Community Item Sharing Platform - Items Only

---

## ACTORS

### 1. Visitor (Unregistered User)
- **Description:** Anyone browsing the platform without an account
- **Goal:** Explore items, view users, decide whether to register
- **Characteristics:** No login required, limited actions

### 2. Registered User (Community Member)
- **Description:** Authenticated user with an account
- **Goal:** Share items, request items, build reputation
- **Characteristics:** Full platform access, can create listings and requests

### 3. System
- **Description:** Automated platform processes
- **Goal:** Send notifications, calculate ratings, update availability
- **Characteristics:** Background processes, no UI

---

## USE CASES

### PUBLIC USE CASES (Visitor)

**UC-001: Browse Listings**
- **Actor:** Visitor
- **Description:** View all available items on the platform
- **Preconditions:** None
- **Main Flow:**
  1. Visitor navigates to "Browse Items" page
  2. System displays all available listings
  3. Visitor can filter by category, exchange type
  4. Visitor can search by keyword
  5. Visitor clicks item to view details
- **Postconditions:** Visitor sees items available for sharing
- **Alternative Flows:**
  - 2a. No items available → Display "No items yet, be first to list!"

**UC-002: View Listing Detail**
- **Actor:** Visitor
- **Description:** View complete information about a specific item
- **Preconditions:** Listing exists and is available
- **Main Flow:**
  1. Visitor clicks on listing from browse page
  2. System displays full listing details (photos, description, condition, owner info)
  3. System increments view_count
  4. Visitor can view owner's profile
  5. Visitor sees "Sign up to request this item" prompt
- **Postconditions:** Visitor has detailed information about item
- **Alternative Flows:**
  - If logged in → Show "Request This Item" button instead

**UC-003: View User List**
- **Actor:** Visitor
- **Description:** Browse all community members
- **Preconditions:** None
- **Main Flow:**
  1. Visitor navigates to "Users" page
  2. System displays all active users (name, profile pic, location, member since, item count)
  3. Visitor can search users by name
  4. Visitor can sort by newest/most active
  5. Visitor clicks user to view profile
- **Postconditions:** Visitor sees community members

**UC-004: View User Profile**
- **Actor:** Visitor
- **Description:** View detailed information about a specific user
- **Preconditions:** User exists
- **Main Flow:**
  1. Visitor clicks user from list or listing
  2. System displays user profile (bio, location, member since, stats)
  3. System displays all user's active listings
  4. Visitor can click listings to view details
- **Postconditions:** Visitor knows about community member
- **Alternative Flows:**
  - If viewing own profile (logged in) → Show "Edit Profile" button

**UC-005: View Categories**
- **Actor:** Visitor
- **Description:** Browse items organized by category
- **Preconditions:** None
- **Main Flow:**
  1. Visitor navigates to "Categories" page
  2. System displays all categories with counts
  3. Visitor clicks category
  4. System filters listings by selected category
- **Postconditions:** Visitor browses specific category

**UC-006: Search Items**
- **Actor:** Visitor
- **Description:** Find items using keyword search
- **Preconditions:** None
- **Main Flow:**
  1. Visitor enters search term
  2. System searches title, description, tags
  3. System displays matching results
  4. Visitor can click results to view details
- **Postconditions:** Visitor finds relevant items
- **Alternative Flows:**
  - 3a. No results → Display "No items match your search"

---

### AUTHENTICATION USE CASES

**UC-007: Register Account**
- **Actor:** Visitor
- **Description:** Create new user account
- **Preconditions:** Valid email not already registered
- **Main Flow:**
  1. Visitor clicks "Sign Up"
  2. Visitor enters email, password, password confirmation
  3. System validates input (email format, password strength)
  4. System creates user account
  5. System sends verification email
  6. Visitor is redirected to profile setup
  7. Visitor completes profile (name, bio, location, photo)
  8. System saves profile
  9. Visitor is redirected to dashboard
- **Postconditions:** New user account created, user logged in
- **Alternative Flows:**
  - 3a. Email already exists → Display error, suggest login
  - 3b. Weak password → Display requirements, ask to retry
  - 5a. Email fails → Log error, allow manual verification later

**UC-008: Log In**
- **Actor:** Visitor
- **Description:** Access existing account
- **Preconditions:** User has registered account
- **Main Flow:**
  1. Visitor clicks "Log In"
  2. Visitor enters email and password
  3. System validates credentials
  4. System creates session
  5. System redirects to dashboard
- **Postconditions:** User authenticated and logged in
- **Alternative Flows:**
  - 3a. Invalid credentials → Display error, allow retry
  - 3b. After 5 failed attempts → Lock account for 15 minutes

**UC-009: Log Out**
- **Actor:** Registered User
- **Description:** End current session
- **Preconditions:** User is logged in
- **Main Flow:**
  1. User clicks "Log Out"
  2. System destroys session
  3. System redirects to homepage
  4. System displays "Logged out successfully"
- **Postconditions:** User logged out, session ended

**UC-010: Edit Profile**
- **Actor:** Registered User
- **Description:** Update profile information
- **Preconditions:** User is logged in
- **Main Flow:**
  1. User navigates to "Edit Profile"
  2. System displays current profile data in form
  3. User modifies fields (name, bio, location, photo)
  4. User clicks "Save Changes"
  5. System validates input
  6. System updates database
  7. System displays "Profile updated"
- **Postconditions:** Profile information updated
- **Alternative Flows:**
  - 5a. Invalid data → Display errors, allow correction

---

### LISTING MANAGEMENT USE CASES

**UC-011: Create Listing**
- **Actor:** Registered User
- **Description:** List an item for sharing
- **Preconditions:** User is logged in
- **Main Flow:**
  1. User clicks "Create Listing"
  2. System displays listing form
  3. User enters: title, description, category, exchange type, condition
  4. User uploads photos (1-3)
  5. User adds tags (optional)
  6. User clicks "Publish"
  7. System validates input
  8. System saves listing to database
  9. System redirects to listing detail page
  10. System displays "Listing published!"
- **Postconditions:** New listing created and visible
- **Alternative Flows:**
  - 7a. Missing required fields → Display errors
  - 4a. Photo too large → Compress or reject
  - User can save as draft (future enhancement)

**UC-012: Edit Listing**
- **Actor:** Registered User
- **Description:** Modify existing listing
- **Preconditions:** User is logged in, user owns the listing
- **Main Flow:**
  1. User views own listing
  2. User clicks "Edit"
  3. System displays pre-filled form
  4. User modifies fields
  5. User clicks "Save Changes"
  6. System validates input
  7. System updates database
  8. System displays "Listing updated"
- **Postconditions:** Listing information updated
- **Alternative Flows:**
  - 6a. Invalid input → Display errors

**UC-013: Delete Listing**
- **Actor:** Registered User
- **Description:** Remove listing from platform
- **Preconditions:** User is logged in, user owns the listing
- **Main Flow:**
  1. User views own listing
  2. User clicks "Delete"
  3. System displays confirmation: "Are you sure? This cannot be undone"
  4. User confirms
  5. System marks listing as deleted (is_available = 0)
  6. System notifies requesters if pending requests exist
  7. System redirects to dashboard
  8. System displays "Listing deleted"
- **Postconditions:** Listing no longer visible publicly
- **Alternative Flows:**
  - 4a. User cancels → Return to listing page

**UC-014: Mark Listing Unavailable**
- **Actor:** Registered User
- **Description:** Temporarily hide listing without deleting
- **Preconditions:** User is logged in, user owns listing, listing is available
- **Main Flow:**
  1. User views own listing
  2. User toggles "Available" switch to OFF
  3. System updates is_available = 0
  4. System removes from public browse
  5. System displays "Listing marked unavailable"
- **Postconditions:** Listing hidden but can be reactivated
- **Alternative Flows:**
  - User can reactivate by toggling switch to ON

---

### REQUEST MANAGEMENT USE CASES

**UC-015: Request Item**
- **Actor:** Registered User
- **Description:** Request to borrow/swap/receive an item
- **Preconditions:** User is logged in, user does not own the listing, listing is available
- **Main Flow:**
  1. User views listing detail
  2. User clicks "Request This Item"
  3. System displays request form
  4. User enters message (required)
  5. If lending: User enters duration needed
  6. If swap: User describes what they can offer
  7. User clicks "Send Request"
  8. System creates request (status = pending)
  9. System notifies owner
  10. System displays "Request sent!"
  11. System redirects to "My Requests"
- **Postconditions:** Request created, owner notified
- **Alternative Flows:**
  - User not logged in → Redirect to login first
  - User owns item → Show error, cannot request own item

**UC-016: View My Requests**
- **Actor:** Registered User
- **Description:** See all requests user has made
- **Preconditions:** User is logged in
- **Main Flow:**
  1. User navigates to "My Requests"
  2. System retrieves all requests where requester_id = user_id
  3. System displays requests (item, owner, status, date)
  4. User can filter by status
  5. User can click request to view details
- **Postconditions:** User sees their request history

**UC-017: View Requests on My Items**
- **Actor:** Registered User
- **Description:** See all requests on user's listings
- **Preconditions:** User is logged in, user has listings
- **Main Flow:**
  1. User navigates to "Requests on My Items" (dashboard section)
  2. System retrieves all requests on user's listings
  3. System displays pending requests first
  4. User sees: item, requester info, message, date
  5. User can accept or decline each request
- **Postconditions:** User manages incoming requests

**UC-018: Accept Request**
- **Actor:** Registered User (item owner)
- **Description:** Approve a request and proceed with exchange
- **Preconditions:** User owns the listing, request status is pending
- **Main Flow:**
  1. User views request detail
  2. User clicks "Accept"
  3. System displays confirmation: "Accept this request?"
  4. User confirms
  5. System updates request status to "accepted"
  6. System updates responded_date
  7. System notifies requester
  8. System awards points to requester (Sprint 4: +10)
  9. System may mark item as unavailable (configurable)
  10. System displays "Request accepted!"
- **Postconditions:** Request accepted, exchange can proceed, requester notified
- **Alternative Flows:**
  - User can message requester to coordinate (Sprint 4)

**UC-019: Decline Request**
- **Actor:** Registered User (item owner)
- **Description:** Reject a request
- **Preconditions:** User owns the listing, request status is pending
- **Main Flow:**
  1. User views request detail
  2. User clicks "Decline"
  3. System displays optional reason field
  4. User confirms
  5. System updates request status to "declined"
  6. System updates responded_date
  7. System notifies requester
  8. System displays "Request declined"
- **Postconditions:** Request declined, item remains available, requester notified
- **Alternative Flows:**
  - Owner can provide polite decline message

**UC-020: Cancel Request**
- **Actor:** Registered User (requester)
- **Description:** Withdraw a pending request
- **Preconditions:** User made the request, request status is pending
- **Main Flow:**
  1. User views request detail
  2. User clicks "Cancel Request"
  3. System displays confirmation
  4. User confirms
  5. System updates status to "cancelled"
  6. System notifies owner
  7. System displays "Request cancelled"
- **Postconditions:** Request cancelled, item available for others

**UC-021: Mark Exchange Complete**
- **Actor:** Registered User (owner or requester)
- **Description:** Confirm exchange successfully completed
- **Preconditions:** Request status is "accepted", exchange has occurred
- **Main Flow:**
  1. User views request detail
  2. User clicks "Mark as Completed"
  3. System displays confirmation
  4. User confirms
  5. System updates status to "completed"
  6. System updates completed_date
  7. System awards points (Sprint 4)
  8. System prompts both users to rate each other (Sprint 4)
  9. If lending: System makes item available again
  10. If swap/giveaway: Item remains unavailable
  11. System displays "Exchange marked complete!"
- **Postconditions:** Exchange recorded as successful, points awarded, ratings prompted
- **Alternative Flows:**
  - Both users should ideally confirm completion

---

### DASHBOARD USE CASE

**UC-022: View Dashboard**
- **Actor:** Registered User
- **Description:** Access personal activity hub
- **Preconditions:** User is logged in
- **Main Flow:**
  1. User clicks "Dashboard" in navigation
  2. System displays:
     - Quick stats (items listed, borrowed, given, points)
     - My active listings (grid with edit/delete)
     - Pending requests on my items (accept/decline)
     - My recent requests (status updates)
     - Quick action buttons
  3. User can navigate to detailed sections
- **Postconditions:** User sees overview of all activity

---

### MAPS USE CASES (Sprint 4)

**UC-023: View Items on Map**
- **Actor:** Visitor or Registered User
- **Description:** Visualize items on geographical map
- **Preconditions:** None
- **Main Flow:**
  1. User clicks "Map View"
  2. System requests location permission (optional)
  3. System displays Google Map
  4. System plots all available items as pins
  5. Pins are color-coded by category
  6. User can click pin to see item preview
  7. User can click "View Details" from popup
- **Postconditions:** User sees spatial distribution of items
- **Alternative Flows:**
  - User denies location → Center map on default location (university)

**UC-024: Filter Map by Distance**
- **Actor:** Visitor or Registered User
- **Description:** Show only items within specified range
- **Preconditions:** Map view open
- **Main Flow:**
  1. User adjusts distance slider (1km, 3km, 5km, 10km, 20km)
  2. System filters items by distance from user location
  3. System updates map pins
  4. System displays count: "X items within Y km"
- **Postconditions:** Map shows filtered results

---

### MESSAGING USE CASES (Sprint 4)

**UC-025: Send Message**
- **Actor:** Registered User
- **Description:** Send direct message to another user
- **Preconditions:** User is logged in
- **Main Flow:**
  1. User clicks "Message" button on profile or request
  2. System opens messaging interface
  3. User types message (max 500 chars)
  4. User clicks "Send"
  5. System saves message to database
  6. System notifies receiver
  7. Message appears in conversation
- **Postconditions:** Message sent and stored

**UC-026: View Messages**
- **Actor:** Registered User
- **Description:** Access message conversations
- **Preconditions:** User is logged in
- **Main Flow:**
  1. User clicks "Messages" in navigation
  2. System displays list of conversations
  3. System shows unread count badge
  4. User clicks conversation
  5. System displays full message history
  6. System marks messages as read
  7. User can reply
- **Postconditions:** User accesses messages, unread marked as read

---

### RATING USE CASE (Sprint 4)

**UC-027: Rate User**
- **Actor:** Registered User
- **Description:** Rate another user after completed exchange
- **Preconditions:** Exchange marked as completed, user hasn't rated yet
- **Main Flow:**
  1. System prompts user to rate after completion
  2. User clicks "Rate [Name]"
  3. User selects 1-5 stars
  4. User enters optional comment (200 chars)
  5. User selects rating type (as_lender, as_borrower, etc.)
  6. User clicks "Submit Rating"
  7. System saves rating to database
  8. System recalculates rated user's average_rating
  9. System displays "Thank you for rating!"
- **Postconditions:** Rating saved, user's reputation updated

---

### SYSTEM USE CASES (Automated)

**UC-028: Send Notifications**
- **Actor:** System
- **Description:** Notify users of important events
- **Triggers:** Request received, request accepted/declined, exchange completed, new message
- **Actions:**
  - Update dashboard notification count
  - (Sprint 4) Send in-app notification
  - (Sprint 4) Send email if enabled

**UC-029: Calculate Ratings**
- **Actor:** System
- **Description:** Update user's average rating after new rating received
- **Triggers:** New rating submitted
- **Actions:**
  - Calculate AVG(score) for rated user
  - Update user.average_rating
  - Update user.total_ratings count

**UC-030: Award Points**
- **Actor:** System
- **Description:** Award points for platform participation
- **Triggers:** Request accepted, exchange completed, item lent/given
- **Actions:**
  - Update user.points in database
  - Log transaction in exchange_history (optional)

**UC-031: Update Item Availability**
- **Actor:** System
- **Description:** Manage item availability based on requests
- **Triggers:** Request accepted, exchange completed, request cancelled
- **Actions:**
  - Set is_available based on rules
  - For lending: unavailable during use, available after return
  - For swap/giveaway: unavailable after exchange

---

## USE CASE DIAGRAM (ASCII Representation)

```
                    COMMUNITY ITEM SHARING PLATFORM
                           USE CASE DIAGRAM

┌────────────────────────────────────────────────────────────────────────────┐
│                                                                            │
│                                                                            │
│        ┌─────────┐                                                        │
│        │ Visitor │                                                        │
│        │  (Actor)│                                                        │
│        └────┬────┘                                                        │
│             │                                                              │
│             │                                                              │
│             ├──────────► (Browse Listings)                                │
│             │                                                              │
│             ├──────────► (View Listing Detail)                            │
│             │                                                              │
│             ├──────────► (View User List)                                 │
│             │                                                              │
│             ├──────────► (View User Profile)                              │
│             │                                                              │
│             ├──────────► (View Categories)                                │
│             │                                                              │
│             ├──────────► (Search Items)                                   │
│             │                                                              │
│             ├──────────► (Register Account)                               │
│             │                     │                                        │
│             │                     │                                        │
│             │                     ▼                                        │
│             │            ┌────────────────┐                               │
│             └──────────► │   Log In       │                               │
│                          └────────┬───────┘                               │
│                                   │                                        │
│                                   │                                        │
│                                   ▼                                        │
│                          ┌─────────────┐                                  │
│                          │ Registered  │                                  │
│                          │    User     │                                  │
│                          │   (Actor)   │                                  │
│                          └──────┬──────┘                                  │
│                                 │                                          │
│                                 │                                          │
│                                 ├──────────► (Log Out)                    │
│                                 │                                          │
│                                 ├──────────► (Edit Profile)               │
│                                 │                                          │
│                                 ├──────────► (View Dashboard)             │
│                                 │                                          │
│        ┌────────────────────────┼────────────────────────┐               │
│        │  LISTING MANAGEMENT    │                        │               │
│        │                        │                        │               │
│        │                        ├──────────► (Create Listing)            │
│        │                        │                                        │
│        │                        ├──────────► (Edit Listing)              │
│        │                        │                                        │
│        │                        ├──────────► (Delete Listing)            │
│        │                        │                                        │
│        │                        ├──────────► (Mark Unavailable)          │
│        │                        │                                        │
│        └────────────────────────┼────────────────────────┘               │
│                                 │                                          │
│        ┌────────────────────────┼────────────────────────┐               │
│        │  REQUEST MANAGEMENT    │                        │               │
│        │                        │                        │               │
│        │                        ├──────────► (Request Item)              │
│        │                        │                                        │
│        │                        ├──────────► (View My Requests)          │
│        │                        │                                        │
│        │                        ├──────────► (View Requests on My Items) │
│        │                        │                                        │
│        │                        ├──────────► (Accept Request)            │
│        │                        │                                        │
│        │                        ├──────────► (Decline Request)           │
│        │                        │                                        │
│        │                        ├──────────► (Cancel Request)            │
│        │                        │                                        │
│        │                        ├──────────► (Mark Exchange Complete)    │
│        │                        │                                        │
│        └────────────────────────┼────────────────────────┘               │
│                                 │                                          │
│        ┌────────────────────────┼────────────────────────┐               │
│        │  SPRINT 4 FEATURES     │                        │               │
│        │                        │                        │               │
│        │                        ├──────────► (View Items on Map)         │
│        │                        │                                        │
│        │                        ├──────────► (Filter Map by Distance)    │
│        │                        │                                        │
│        │                        ├──────────► (Send Message)              │
│        │                        │                                        │
│        │                        ├──────────► (View Messages)             │
│        │                        │                                        │
│        │                        ├──────────► (Rate User)                 │
│        │                        │                                        │
│        └────────────────────────┼────────────────────────┘               │
│                                 │                                          │
│                                 │                                          │
│                                 │                                          │
│                          ┌──────▼──────┐                                  │
│                          │   System    │                                  │
│                          │   (Actor)   │                                  │
│                          └──────┬──────┘                                  │
│                                 │                                          │
│                                 ├──────────► (Send Notifications)         │
│                                 │                                          │
│                                 ├──────────► (Calculate Ratings)          │
│                                 │                                          │
│                                 ├──────────► (Award Points)               │
│                                 │                                          │
│                                 └──────────► (Update Item Availability)   │
│                                                                            │
│                                                                            │
└────────────────────────────────────────────────────────────────────────────┘


RELATIONSHIPS:
─────────►  = Association (actor interacts with use case)
◄- - - - -  = Include (use case always includes another - not shown for clarity)
◄- - - - -► = Extend (use case optionally includes another - not shown for clarity)
```

---

## HOW TO DRAW THIS DIAGRAM (For Your Submission)

### Software Options:
1. **Draw.io** (free, online) - https://app.diagrams.net/
2. **Lucidchart** (free tier)
3. **PlantUML** (code-based, good for version control)
4. **Microsoft Visio** (if you have it)
5. **Hand-drawn** (scan/photo - acceptable for submission!)

### Drawing Instructions:

**Step 1: Draw Actors (Stick Figures)**
- Left side: Visitor (stick figure)
- Left-center: Registered User (stick figure)
- Bottom-right: System (stick figure or gear icon)

**Step 2: Draw System Boundary**
- Large rectangle encompassing all use cases
- Label at top: "Community Item Sharing Platform"

**Step 3: Draw Use Cases (Ovals)**
- Inside system boundary
- Group logically:
  * Top: Public use cases (Browse, View, Search)
  * Middle-left: Authentication (Register, Login, Logout)
  * Middle: Listing Management
  * Middle-right: Request Management
  * Bottom: Sprint 4 features
  * Far right: System use cases

**Step 4: Draw Associations (Lines)**
- Visitor to public use cases
- Visitor to Register/Login
- Registered User to all user features
- System to automated use cases

**Step 5: Optional - Show Relationships**
- «include» arrows: e.g., "Request Item" includes "View Listing Detail"
- «extend» arrows: e.g., "View Dashboard" extends to specific sections

**Step 6: Add Legend**
- Actor symbols
- Use case ovals
- Association lines
- Include/extend relationships (if used)

---

## USE CASE PRIORITIES

### Sprint 3 (MUST implement):
- UC-001 to UC-022 (all core use cases)

### Sprint 4 (Advanced features):
- UC-023 to UC-031 (maps, messaging, ratings, system automation)

---

## RELATIONSHIPS BETWEEN USE CASES

### «include» Relationships (Always Happens):
- UC-015 (Request Item) **includes** UC-002 (View Listing Detail) - must view item first
- UC-011 (Create Listing) **includes** UC-008 (Log In) - must be logged in
- UC-018 (Accept Request) **includes** UC-030 (Award Points) - always awards points in Sprint 4

### «extend» Relationships (Sometimes Happens):
- UC-002 (View Listing Detail) **extends to** UC-015 (Request Item) - if logged in and interested
- UC-021 (Mark Exchange Complete) **extends to** UC-027 (Rate User) - prompts rating after completion
- UC-015 (Request Item) **extends to** UC-025 (Send Message) - can message owner in Sprint 4

---

This use case diagram shows all functionality of your items-only sharing platform!
