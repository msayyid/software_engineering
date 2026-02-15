# SPRINT 2: USER STORIES
## Community Item Sharing Platform - Items Only

**Total User Stories:** 42 stories organized by feature and priority

**Format:** As a [user type], I want to [action], so that [benefit]

**Priority Legend:**
- **MUST HAVE** = Sprint 3 Core (essential for MVP)
- **SHOULD HAVE** = Sprint 3 Nice-to-have (enhance UX)
- **COULD HAVE** = Sprint 4 Advanced (if time permits)

---

## EPIC 1: USER MANAGEMENT & AUTHENTICATION

### MUST HAVE (Sprint 3)

**US-001:** As a new user, I want to register with my email and password, so that I can create an account on the platform.
- **Acceptance Criteria:**
  - Email validation (must be valid format)
  - Password requirements (min 8 characters, 1 number)
  - Email verification sent
  - Account created in database
  - Redirect to profile setup

**US-002:** As a registered user, I want to log in with my email and password, so that I can access my account.
- **Acceptance Criteria:**
  - Email and password validated
  - Session created on successful login
  - Redirect to dashboard
  - Error message for invalid credentials
  - "Remember me" option

**US-003:** As a logged-in user, I want to log out, so that my account is secure when I'm done.
- **Acceptance Criteria:**
  - Session destroyed
  - Redirect to homepage
  - Confirmation message shown
  - Cannot access protected pages after logout

**US-004:** As a new user, I want to create my profile with name, bio, and location, so that others know about me.
- **Acceptance Criteria:**
  - First name and last name required
  - Bio optional (500 char max)
  - Location required (general area, not exact address)
  - Profile picture upload optional
  - Save to database
  - Redirect to dashboard

**US-005:** As a registered user, I want to edit my profile information, so that I can keep my details up to date.
- **Acceptance Criteria:**
  - All profile fields editable
  - Changes saved to database
  - Confirmation message displayed
  - Can change profile picture
  - Cannot change email (security)

**US-006:** As any visitor, I want to view a list of all users, so that I can see who's in the community.
- **Acceptance Criteria:**
  - Display all active users
  - Show: name, profile pic, location (general), member since
  - Show number of items each user has listed
  - Sortable by: newest members, most active
  - Searchable by name
  - Click user to view full profile

**US-007:** As any visitor, I want to view a specific user's profile, so that I can learn about them before requesting items.
- **Acceptance Criteria:**
  - Display: full name, bio, location, profile pic, member since
  - Show all their active listings
  - Show their stats (items lent, borrowed, given away - Sprint 4: points, rating)
  - Listings clickable to view details
  - If viewing own profile, show "Edit Profile" button

### SHOULD HAVE (Sprint 3)

**US-008:** As a registered user, I want to receive email verification after registering, so that my account is verified.
- **Acceptance Criteria:**
  - Verification email sent on registration
  - Email contains verification link
  - Clicking link activates account
  - "Verified" badge shown on profile
  - Unverified users reminded to verify

### COULD HAVE (Sprint 4)

**US-009:** As a user, I want to reset my password if I forget it, so that I can regain access to my account.
- **Acceptance Criteria:**
  - "Forgot password" link on login page
  - Email sent with reset link
  - Reset link expires after 1 hour
  - New password must meet requirements
  - Confirmation email sent after reset

---

## EPIC 2: ITEM LISTINGS

### MUST HAVE (Sprint 3)

**US-010:** As a registered user, I want to create a listing for an item I want to share, so that others can find it.
- **Acceptance Criteria:**
  - Title required (max 100 chars)
  - Description required (max 500 chars)
  - Category dropdown required
  - Exchange type required (lending/swap/giveaway)
  - Condition required (like new/good/fair/well-used)
  - Photo upload (at least 1, max 3)
  - Save to database with user_id
  - Redirect to listing detail page
  - Success message displayed

**US-011:** As a registered user, I want to upload photos of my item, so that others can see what it looks like.
- **Acceptance Criteria:**
  - Support JPG, PNG formats
  - Max file size 5MB per photo
  - Up to 3 photos per listing
  - Preview before upload
  - Drag-and-drop or button upload
  - Photos stored in /public/images/uploads/

**US-012:** As a registered user, I want to select a category for my item, so that it's easier for others to find.
- **Acceptance Criteria:**
  - Dropdown with categories: Tools & Equipment, Books & Media, Baby & Kids, Sports & Outdoors, Household Items, Electronics, Other
  - One category required per listing
  - Category saved to database

**US-013:** As a registered user, I want to specify the exchange type (lend/swap/giveaway), so that others know what I'm offering.
- **Acceptance Criteria:**
  - Radio buttons or dropdown for: Lending, Swap, Giveaway
  - One option required
  - Clear labels and icons for each type
  - Saved to database as exchange_type

**US-014:** As a registered user, I want to describe my item's condition honestly, so that borrowers know what to expect.
- **Acceptance Criteria:**
  - Dropdown: Like New, Good, Fair, Well-Used
  - Optional condition notes field (200 chars)
  - Condition clearly displayed on listing
  - Tooltip explaining each condition level

**US-015:** As a registered user listing a swap, I want to specify what I'm looking for, so that people know what to offer.
- **Acceptance Criteria:**
  - "Swap preferences" field appears only if exchange_type = swap
  - Optional but recommended (300 chars)
  - Example text: "Looking for: baby clothes 18-24 months"
  - Displayed prominently on listing detail

**US-016:** As any visitor, I want to browse all available items, so that I can see what's available in the community.
- **Acceptance Criteria:**
  - Display all listings where is_available = 1
  - Show: title, photo, category, exchange type, owner name, location
  - Grid layout (3-4 items per row)
  - Sorted by newest first (default)
  - Pagination if >20 items
  - Click item to view full details

**US-017:** As any visitor, I want to search for items by keyword, so that I can find specific things quickly.
- **Acceptance Criteria:**
  - Search bar at top of listings page
  - Search in: title, description, category, tags
  - Display results matching keyword
  - Show "no results" message if nothing found
  - Clear search button

**US-018:** As any visitor, I want to filter items by category, so that I only see items I'm interested in.
- **Acceptance Criteria:**
  - Filter sidebar or dropdown
  - Checkboxes for each category
  - Multiple categories selectable
  - "All" option to clear filters
  - URL updates with filter params
  - Filter count shown (e.g., "Tools & Equipment (12)")

**US-019:** As any visitor, I want to filter items by exchange type, so that I see only lending/swap/giveaway items.
- **Acceptance Criteria:**
  - Filter by: Lending, Swap, Giveaway
  - Checkboxes or radio buttons
  - Can select multiple types
  - Combined with category filters
  - Clear indication of active filters

**US-020:** As any visitor, I want to view detailed information about a specific item, so that I can decide if I want to request it.
- **Acceptance Criteria:**
  - Display: all photos (carousel/gallery), full description, category, exchange type, condition, owner info (name, profile pic, member since)
  - Show owner's other listings
  - "Request This Item" button (if logged in and not own item)
  - "Back to Listings" link
  - View count incremented

**US-021:** As a registered user, I want to edit my own listings, so that I can update information or correct mistakes.
- **Acceptance Criteria:**
  - "Edit" button visible only to listing owner
  - Pre-filled form with current data
  - All fields editable except creation date
  - Save changes to database
  - Confirmation message
  - Can add/remove photos

**US-022:** As a registered user, I want to delete my own listings, so that I can remove items I no longer want to share.
- **Acceptance Criteria:**
  - "Delete" button visible only to owner
  - Confirmation prompt: "Are you sure?"
  - Soft delete (set is_available = 0) or hard delete
  - Redirect to dashboard
  - Associated requests handled (notify requesters?)

**US-023:** As a registered user, I want to mark my listing as unavailable, so that others know it's not currently available.
- **Acceptance Criteria:**
  - Toggle switch or button: "Mark as Unavailable"
  - is_available set to 0 in database
  - Listing hidden from public browse
  - Still visible on owner's dashboard (greyed out)
  - Can reactivate later

### SHOULD HAVE (Sprint 3)

**US-024:** As any visitor, I want to view items by category on a dedicated categories page, so that I can browse organized content.
- **Acceptance Criteria:**
  - Page showing all categories as cards/tiles
  - Each card shows: category name, icon, count of items
  - Click card to filter listings by that category
  - Visual and appealing layout

**US-025:** As any visitor, I want to sort listings by different criteria, so that I can find items more easily.
- **Acceptance Criteria:**
  - Sort dropdown with options: Newest, Oldest, Most Requested (future: Nearest - Sprint 4)
  - Default: Newest
  - Sorting applied to current filters
  - URL updates with sort parameter

**US-026:** As a registered user, I want to add tags to my listing, so that it's easier to find through search.
- **Acceptance Criteria:**
  - Tag input field (comma-separated or chips)
  - Suggest existing tags as user types
  - Max 10 tags per listing
  - Tags saved to listing_tags table
  - Tags displayed as clickable chips on listing detail

---

## EPIC 3: REQUEST SYSTEM

### MUST HAVE (Sprint 3)

**US-027:** As a registered user, I want to request an item from another user, so that I can borrow/swap/receive it.
- **Acceptance Criteria:**
  - "Request This Item" button on listing detail (only if not own item)
  - Modal or page with request form
  - Message field required (max 300 chars)
  - If lending: "How long do you need it?" field (flexible text, e.g., "a weekend")
  - If swap: "What can you offer in return?" field
  - Submit creates request in database (status = pending)
  - Owner notified (basic: on dashboard, Sprint 4: email/in-app)
  - Confirmation message: "Request sent!"
  - Redirect to "My Requests" page

**US-028:** As a registered user, I want to view all requests I've made, so that I can track their status.
- **Acceptance Criteria:**
  - "My Requests" page accessible from dashboard
  - Display all requests where requester_id = current_user
  - Show: item title, photo, owner name, status (pending/accepted/declined/completed/cancelled), requested date
  - Color-coded status badges
  - Click to view request details
  - Filter by status
  - Sorted by newest first

**US-029:** As a registered user, I want to view all requests on my items, so that I can decide whether to accept them.
- **Acceptance Criteria:**
  - "Requests on My Items" section on dashboard
  - Display all requests on user's listings where status = pending
  - Show: item title, requester name, profile pic, message, requested date, requester's rating (Sprint 4)
  - "Accept" and "Decline" buttons for each request
  - Click requester name to view their profile
  - Notification badge showing count of pending requests

**US-030:** As an item owner, I want to accept a request, so that the exchange can proceed.
- **Acceptance Criteria:**
  - "Accept" button on request detail
  - Confirmation prompt: "Accept this request?"
  - Update request status to "accepted" in database
  - Update responded_date timestamp
  - Award points to requester (Sprint 4: +10 points)
  - Requester notified (dashboard update, Sprint 4: in-app message)
  - Item marked as unavailable (or at least for that period - discuss)
  - Redirect to messaging or request detail

**US-031:** As an item owner, I want to decline a request, so that I can control who borrows my items.
- **Acceptance Criteria:**
  - "Decline" button on request detail
  - Optional: reason field (polite decline message)
  - Update request status to "declined"
  - Update responded_date timestamp
  - Requester notified
  - Item remains available for other requests
  - No negative consequences for owner

**US-032:** As a requester, I want to cancel my request, so that I can change my mind.
- **Acceptance Criteria:**
  - "Cancel Request" button on request detail (only if status = pending)
  - Confirmation prompt: "Cancel this request?"
  - Update status to "cancelled"
  - Owner notified (no longer shows in their pending requests)
  - Item becomes available again

**US-033:** As a requester or owner, I want to mark an exchange as completed, so that it's recorded in the system.
- **Acceptance Criteria:**
  - "Mark as Completed" button visible to both parties (only if status = accepted)
  - Confirmation prompt
  - Update status to "completed"
  - Update completed_date timestamp
  - Award points to both users (Sprint 4)
  - Prompt both users to rate each other (Sprint 4)
  - Item becomes available again (if lending) or stays unavailable (if swap/giveaway)

### SHOULD HAVE (Sprint 3)

**US-034:** As a requester, I want to see the request history for an item, so that I know if it's popular or reliable.
- **Acceptance Criteria:**
  - On listing detail, show: "Requested X times"
  - If item has successful exchanges, show "Successfully exchanged Y times"
  - Builds trust in item and owner

---

## EPIC 4: USER DASHBOARD

### MUST HAVE (Sprint 3)

**US-035:** As a registered user, I want a personal dashboard, so that I can manage all my activity in one place.
- **Acceptance Criteria:**
  - Dashboard shows:
    * Quick stats (items listed, items borrowed, pending requests)
    * My active listings (grid view with edit/delete buttons)
    * Requests on my items (pending only, with accept/decline)
    * Requests I've made (all statuses)
    * Quick actions: "Create New Listing", "Browse Items"
  - Navigation tabs or sections
  - Responsive layout
  - Accessible from main navigation

---

## EPIC 5: MAPS & LOCATION (Sprint 4)

### COULD HAVE (Sprint 4)

**US-036:** As any visitor, I want to see items on a map, so that I can visualize what's available nearby.
- **Acceptance Criteria:**
  - Map view page using Google Maps JavaScript API
  - Show all available items as map pins
  - Pins color-coded by category
  - Click pin to see item preview (title, photo, owner)
  - "View Details" link from popup
  - Center map on user's location (or default to university)
  - Zoom controls working

**US-037:** As any visitor, I want to filter map results by distance, so that I only see items within a reasonable range.
- **Acceptance Criteria:**
  - Distance filter: 1km, 3km, 5km, 10km, 20km
  - Slider or dropdown control
  - Map updates as filter changes
  - Show "X items within Y km"
  - Save preference in session

**US-038:** As any visitor, I want to see distance to items on listing pages, so that I know how far I'd need to travel.
- **Acceptance Criteria:**
  - Show "X.X km away" on each listing card
  - Calculate using Haversine formula
  - Requires user location (ask permission or use IP geolocation)
  - Sort by distance option

---

## EPIC 6: MESSAGING (Sprint 4)

### COULD HAVE (Sprint 4)

**US-039:** As a registered user, I want to message another user directly, so that we can coordinate the exchange.
- **Acceptance Criteria:**
  - "Message" button on user profile and request pages
  - Opens messaging interface
  - Send text messages (max 500 chars each)
  - Messages saved to database
  - Real-time or polling updates
  - Message history preserved
  - Can attach to specific request/listing (context)

**US-040:** As a registered user, I want to see my message conversations, so that I can find and continue discussions.
- **Acceptance Criteria:**
  - "Messages" page listing all conversations
  - Show: other user's name, profile pic, last message preview, timestamp, unread indicator
  - Click to open full conversation
  - Mark messages as read when opened
  - Delete conversation option

**US-041:** As a registered user, I want to be notified of new messages, so that I can respond promptly.
- **Acceptance Criteria:**
  - Unread message count badge on "Messages" navigation link
  - Notification dot on dashboard
  - Messages page shows unread first
  - (Optional: Email notification if user has enabled)

---

## EPIC 7: TRUST & REPUTATION (Sprint 4)

### COULD HAVE (Sprint 4)

**US-042:** As a registered user, I want to rate another user after an exchange, so that reputation is visible.
- **Acceptance Criteria:**
  - After marking exchange as completed, prompt to rate
  - 1-5 star rating required
  - Optional comment (200 chars)
  - Select rating type (as_lender, as_borrower, as_swapper, as_giver, as_receiver)
  - Submit saves to ratings table
  - Recalculate rated user's average_rating
  - Can only rate once per exchange
  - Both parties can rate each other

---

## USER STORY SUMMARY BY PRIORITY

### MUST HAVE (Sprint 3): 28 stories
- Epic 1 (User Management): 7 stories
- Epic 2 (Listings): 13 stories
- Epic 3 (Requests): 7 stories
- Epic 4 (Dashboard): 1 story

### SHOULD HAVE (Sprint 3): 4 stories
- Epic 1: 1 story
- Epic 2: 2 stories
- Epic 3: 1 story

### COULD HAVE (Sprint 4): 10 stories
- Epic 1: 1 story
- Epic 5 (Maps): 3 stories
- Epic 6 (Messaging): 3 stories
- Epic 7 (Ratings): 1 story
- Additional advanced features: 2 stories implied (points system, matching algorithm - to be detailed in Sprint 4 planning)

**Total: 42 User Stories**

---

## NOTES FOR DEVELOPMENT

### Sprint 3 Focus (MUST HAVE + SHOULD HAVE)
Build core functionality first: authentication, listings, requests, dashboard. These 32 stories are your MVP.

### Sprint 4 Focus (COULD HAVE)
Add advanced features: maps, messaging, ratings. These 10 stories + matching algorithm + points system complete the platform.

### Story Point Estimates (For Planning)
- Simple (1-2 points): US-003, US-012, US-013, US-022, US-023, US-031, US-032
- Medium (3-5 points): US-001, US-002, US-004, US-005, US-010, US-016, US-027, US-028, US-029
- Complex (8-13 points): US-011, US-020, US-030, US-033, US-035, US-036, US-039, US-042

### Dependencies
- US-027 (Request item) depends on US-010 (Create listing) and US-002 (Login)
- US-030, US-031 (Accept/Decline) depend on US-027 (Request sent)
- US-042 (Rate user) depends on US-033 (Completed exchange)
- US-039 (Messaging) depends on US-002 (Login) and works best with US-027 (Requests)

---

These 42 user stories provide comprehensive coverage of your platform while remaining achievable within the Sprint timeline!
