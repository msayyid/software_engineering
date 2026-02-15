# SPRINT 2: ACTIVITY DIAGRAMS
## Community Item Sharing Platform - Items Only

Activity diagrams show the flow of actions from start to finish for key user interactions.

---

## DIAGRAM 1: USER REGISTRATION & LOGIN FLOW

### Text Description:
This diagram shows how a new user registers and completes their profile setup.

### Detailed Flow:

**START**

1. User lands on homepage
2. User clicks "Sign Up" button
3. System displays registration form
4. User fills in: email, password, confirm password
5. User clicks "Create Account"

**DECISION: Valid data?**
- **NO** → System displays error messages (email format, password too weak, passwords don't match) → Return to step 4
- **YES** → Continue to step 6

6. System validates email format
7. System checks if email already exists in database

**DECISION: Email available?**
- **NO** → Display "Email already registered. Try logging in?" → Return to step 4 or go to login
- **YES** → Continue to step 8

8. System hashes password using bcrypt
9. System creates user record in database
10. System sends verification email
11. System creates session (logs user in)
12. System redirects to "Complete Your Profile" page
13. User enters: first name, last name, bio (optional), location
14. User uploads profile picture (optional)
15. User clicks "Save Profile"

**DECISION: Required fields filled?**
- **NO** → Display validation errors → Return to step 13
- **YES** → Continue to step 16

16. System saves profile data to database
17. System displays success message: "Welcome to the community!"
18. System redirects to Dashboard

**END**

### ASCII Diagram:

```
    (START)
       │
       ▼
[User lands on homepage]
       │
       ▼
[User clicks "Sign Up"]
       │
       ▼
[System displays registration form]
       │
       ▼
[User fills email, password, confirm password]
       │
       ▼
[User clicks "Create Account"]
       │
       ▼
   ◇ Valid data? ◇
    /         \
  NO           YES
   │            │
   │            ▼
   │    [System validates email format]
   │            │
   │            ▼
   │        ◇ Email available? ◇
   │         /             \
   │       NO               YES
   │        │                │
   │ [Show "Email exists"]   ▼
   │        │         [Hash password (bcrypt)]
   │        │                │
   └────────┼────────────────▼
            │         [Create user in database]
            │                │
            │                ▼
            │         [Send verification email]
            │                │
            │                ▼
            │         [Create session / login]
            │                │
            │                ▼
            │         [Redirect to "Complete Profile"]
            │                │
            │                ▼
            │         [User enters: name, bio, location]
            │                │
            │                ▼
            │         [User uploads photo (optional)]
            │                │
            │                ▼
            │         [User clicks "Save Profile"]
            │                │
            │                ▼
            │         ◇ Required fields? ◇
            │          /              \
            │        NO                YES
            │         │                 │
[Show validation errors]                ▼
            │                 [Save profile to database]
            │                           │
            └───────────────────────────▼
                               [Display success message]
                                        │
                                        ▼
                               [Redirect to Dashboard]
                                        │
                                        ▼
                                     (END)
```

---

## DIAGRAM 2: CREATE LISTING FLOW

### Text Description:
This diagram shows how a registered user creates a new item listing.

### Detailed Flow:

**START** (User must be logged in)

1. User navigates to Dashboard
2. User clicks "Create New Listing" button
3. System displays listing creation form
4. User enters title (required, max 100 chars)
5. User writes description (required, max 500 chars)
6. User selects category from dropdown (required)
7. User selects exchange type: Lending / Swap / Giveaway (required)
8. User selects condition: Like New / Good / Fair / Well-Used (required)

**DECISION: Exchange type = Swap?**
- **YES** → User sees "What are you looking for?" field → User enters swap preferences (optional) → Continue to step 9
- **NO** → Continue directly to step 9

9. User adds condition notes (optional, max 200 chars)
10. User clicks "Upload Photos"
11. System opens file picker
12. User selects 1-3 photos

**FOR EACH PHOTO:**
  **DECISION: Photo valid?** (size < 5MB, format JPG/PNG)
  - **NO** → Display error "Photo too large or wrong format" → User can retry or skip
  - **YES** → Upload photo to server, generate thumbnail, display preview

13. User adds tags (optional, comma-separated or chips)
14. User reviews listing preview
15. User clicks "Publish Listing"

**DECISION: All required fields filled?**
- **NO** → Highlight missing fields → Return to form
- **YES** → Continue to step 16

16. System validates all inputs
17. System saves listing to database (is_available = 1)
18. System uploads photos to /public/images/uploads/
19. System creates listing_tags records if tags entered
20. System increments category count
21. System displays success message: "Listing published!"
22. System redirects to listing detail page (user can see their new listing)

**END**

### ASCII Diagram:

```
        (START - User logged in)
                │
                ▼
    [User on Dashboard]
                │
                ▼
    [User clicks "Create New Listing"]
                │
                ▼
    [System displays listing form]
                │
                ▼
    [User enters title (required)]
                │
                ▼
    [User writes description (required)]
                │
                ▼
    [User selects category (dropdown)]
                │
                ▼
    [User selects exchange type: Lending/Swap/Giveaway]
                │
                ▼
    [User selects condition: Like New/Good/Fair/Well-Used]
                │
                ▼
         ◇ Exchange type = Swap? ◇
           /                    \
         YES                     NO
          │                       │
          ▼                       │
[Enter swap preferences]          │
          │                       │
          └───────────┬───────────┘
                      ▼
      [User adds condition notes (optional)]
                      │
                      ▼
      [User clicks "Upload Photos"]
                      │
                      ▼
      [User selects 1-3 photos]
                      │
        ┌─────────────┴─────────────┐
        │  FOR EACH PHOTO            │
        │                            │
        │    ◇ Photo valid? ◇        │
        │     /            \         │
        │   NO              YES      │
        │    │               │       │
        │ [Error]      [Upload photo]│
        │    │               │       │
        │    │          [Show preview]│
        │    │               │       │
        └────┴───────────────┴───────┘
                      │
                      ▼
      [User adds tags (optional)]
                      │
                      ▼
      [User reviews listing preview]
                      │
                      ▼
      [User clicks "Publish Listing"]
                      │
                      ▼
         ◇ All required fields? ◇
           /                    \
         NO                      YES
          │                       │
[Highlight missing fields]        ▼
          │              [Validate all inputs]
          └──────────────────────┤
                                 ▼
                    [Save listing to database]
                                 │
                                 ▼
                    [Upload photos to server]
                                 │
                                 ▼
                    [Create listing_tags records]
                                 │
                                 ▼
                    [Display "Listing published!"]
                                 │
                                 ▼
                    [Redirect to listing detail]
                                 │
                                 ▼
                              (END)
```

---

## DIAGRAM 3: REQUEST ITEM FLOW

### Text Description:
This diagram shows how a user requests an item from another community member.

### Detailed Flow:

**START**

1. User browses listings page
2. User sees item of interest
3. User clicks item to view detail page
4. System displays full listing information
5. User reviews: photos, description, condition, owner info

**DECISION: User logged in?**
- **NO** → Display "Sign up or log in to request items" → User clicks "Log In" → After login, return to listing → Continue to step 6
- **YES** → Continue to step 6

**DECISION: User owns this item?**
- **YES** → Display "You own this item" (cannot request own item) → Show "Edit Listing" button instead → **END**
- **NO** → Continue to step 7

7. User clicks "Request This Item" button
8. System displays request form modal/page
9. System shows item summary (title, photo, owner name)
10. User enters message (required, max 300 chars)
   Example: "Hi! I'd love to borrow this for the weekend. I'll take good care of it!"

**DECISION: Exchange type = Lending?**
- **YES** → Display "How long do you need it?" field → User enters duration (e.g., "2 days", "a weekend", "until end of month") → Continue to step 11
- **NO** → Skip duration, continue to step 11

**DECISION: Exchange type = Swap?**
- **YES** → Display "What can you offer in return?" field → User describes swap offer (e.g., "I have baby clothes 18-24 months to swap") → Continue to step 11
- **NO** → Continue to step 11

11. User reviews request details
12. User clicks "Send Request"

**DECISION: Message field filled?**
- **NO** → Display validation error → Return to step 10
- **YES** → Continue to step 13

13. System validates input
14. System creates request record in database:
    - listing_id
    - requester_id = current user
    - status = 'pending'
    - message
    - requested_duration (if lending)
    - swap_offer_description (if swap)
    - requested_date = now
15. System awards points to requester (Sprint 4: +10 points for request accepted later)
16. System creates notification for owner
17. System displays success message: "Request sent to [Owner Name]!"
18. System redirects to "My Requests" page
19. User sees request with status "Pending"

**END**

### ASCII Diagram:

```
          (START)
             │
             ▼
  [User browses listings]
             │
             ▼
  [User clicks item of interest]
             │
             ▼
  [System displays listing detail]
             │
             ▼
  [User reviews item information]
             │
             ▼
      ◇ User logged in? ◇
        /            \
      NO              YES
       │               │
       ▼               ▼
[Redirect to login]  ◇ User owns item? ◇
       │              /              \
       │            YES               NO
       │             │                 │
       └─────────────┤                 ▼
              [Show "Edit"    [User clicks "Request This Item"]
               instead]                │
                  │                    ▼
                (END)       [System shows request form]
                                       │
                                       ▼
                           [User enters message (required)]
                                       │
                                       ▼
                            ◇ Exchange type? ◇
                          /         |         \
                    Lending       Swap      Giveaway
                        │           │           │
                        ▼           ▼           │
            [Enter duration] [Enter swap offer] │
                        │           │           │
                        └─────┬─────┴───────────┘
                              ▼
                  [User reviews request]
                              │
                              ▼
                  [User clicks "Send Request"]
                              │
                              ▼
                     ◇ Message filled? ◇
                       /            \
                     NO              YES
                      │               │
           [Show validation error]    ▼
                      │        [Validate input]
                      │               │
                      └───────────────▼
                         [Create request in database]
                                      │
                                      ▼
                         [Set status = 'pending']
                                      │
                                      ▼
                         [Notify owner]
                                      │
                                      ▼
                         [Display "Request sent!"]
                                      │
                                      ▼
                         [Redirect to "My Requests"]
                                      │
                                      ▼
                                   (END)
```

---

## DIAGRAM 4: ACCEPT/DECLINE REQUEST FLOW

### Text Description:
This diagram shows how an item owner responds to requests on their listings.

### Detailed Flow:

**START** (Owner logged in)

1. Owner logs in to platform
2. System displays Dashboard
3. Dashboard shows notification badge: "3 pending requests"
4. Owner clicks "Requests on My Items" section
5. System displays all pending requests with:
   - Item title & photo
   - Requester name & profile pic
   - Requester's message
   - Requester's rating/points (Sprint 4)
   - Request date
6. Owner reviews requests
7. Owner clicks on specific request to view details
8. System displays full request information
9. Owner reviews requester's profile (click name)
10. Owner considers: item availability, requester's message, requester's reputation

**DECISION: Accept or Decline?**

### PATH A: ACCEPT
11a. Owner clicks "Accept" button
12a. System displays confirmation: "Accept this request from [Requester Name]?"
13a. Owner confirms

**DECISION: Confirm acceptance?**
- **NO** → Return to step 8
- **YES** → Continue to step 14a

14a. System updates request.status = 'accepted'
15a. System updates request.responded_date = now
16a. System awards +10 points to requester (Sprint 4)
17a. System awards +5 points to owner (Sprint 4)
18a. System creates notification for requester
19a. System displays success: "Request accepted! You can now coordinate with [Requester]"

**DECISION: Messaging enabled? (Sprint 4)**
- **YES** → System prompts: "Send a message to coordinate pickup?" → Open messaging interface
- **NO** → Show requester's contact method (if shared)

20a. System may mark listing as unavailable (configurable)
21a. Owner can message requester to arrange exchange
22a. System redirects to request detail or messaging
**END (Path A)**

### PATH B: DECLINE
11b. Owner clicks "Decline" button
12b. System displays optional reason field
13b. Owner optionally enters polite decline message
    Example: "Sorry, I've lent this to someone else already"
14b. Owner clicks "Confirm Decline"
15b. System updates request.status = 'declined'
16b. System updates request.responded_date = now
17b. System creates notification for requester
18b. System displays: "Request declined"
19b. Item remains available for other requests
20b. No points deducted from either party
**END (Path B)**

### ASCII Diagram:

```
              (START - Owner logged in)
                        │
                        ▼
              [Owner views Dashboard]
                        │
                        ▼
              [Sees "3 pending requests" badge]
                        │
                        ▼
              [Owner clicks "Requests on My Items"]
                        │
                        ▼
              [System displays pending requests]
                        │
                        ▼
              [Owner reviews each request]
                        │
                        ▼
              [Owner clicks request to view details]
                        │
                        ▼
              [System shows full request info]
                        │
                        ▼
              [Owner reviews requester's profile]
                        │
                        ▼
                 ◇ Accept or Decline? ◇
                  /                  \
              ACCEPT                DECLINE
                 │                     │
                 ▼                     ▼
     [Owner clicks "Accept"]  [Owner clicks "Decline"]
                 │                     │
                 ▼                     ▼
  [System shows confirmation]  [System shows optional
        "Accept request?"       reason field]
                 │                     │
                 ▼                     ▼
       ◇ Confirm? ◇           [Owner enters reason
        /         \            (optional)]
      NO          YES                  │
       │           │                   ▼
[Cancel]          ▼           [Owner confirms decline]
  │        [Update status='accepted']        │
  │               │                          ▼
  └───────────────┤         [Update status='declined']
                  │                          │
                  ▼                          ▼
      [Update responded_date]   [Update responded_date]
                  │                          │
                  ▼                          ▼
      [Award +10 pts to requester]  [Notify requester]
                  │                          │
                  ▼                          ▼
      [Award +5 pts to owner]   [Display "Request declined"]
                  │                          │
                  ▼                          ▼
      [Notify requester]        [Item remains available]
                  │                          │
                  ▼                          │
[Display "Request accepted!"]               │
                  │                          │
                  ▼                          │
        ◇ Messaging enabled? ◇              │
         /                \                 │
       YES                NO                │
        │                  │                │
        ▼                  ▼                │
  [Open messaging]   [Show contact info]   │
        │                  │                │
        └────────┬─────────┴────────────────┘
                 ▼
        [Owner can coordinate]
                 │
                 ▼
              (END)
```

---

## DIAGRAM 5: COMPLETE EXCHANGE FLOW

### Text Description:
This diagram shows how users mark an exchange as completed after the item has been borrowed/swapped/given away.

### Detailed Flow:

**START** (Exchange in progress, request status = 'accepted')

**SCENARIO: LENDING (Item to be returned)**

1. Requester has item
2. Time passes (duration agreed: weekend, 2 weeks, etc.)
3. Requester returns item to owner
4. Both parties meet for return
5. Owner inspects item condition

**DECISION: Item in acceptable condition?**
- **NO** → Owner and requester discuss damage → May lead to compensation discussion → Resolve outside platform → Still mark as completed (with note in rating)
- **YES** → Continue to step 6

6. Either owner OR requester logs into platform
7. User navigates to request detail
8. User clicks "Mark as Completed" button
9. System displays confirmation: "Confirm exchange completed successfully?"

**DECISION: Confirm completion?**
- **NO** → Return to request detail
- **YES** → Continue to step 10

10. System updates request.status = 'completed'
11. System updates request.completed_date = now
12. System awards points (Sprint 4):
    - +5 points to owner (for successful lending)
    - +10 points to requester (for successful borrowing and return)
13. System updates owner's stats: items_lent++
14. System updates requester's stats: items_borrowed++
15. System marks listing as available again (is_available = 1)

**Sprint 4: Rating Prompt**
16. System prompts owner: "Rate [Requester Name]'s borrowing experience"
17. System prompts requester: "Rate [Owner Name]'s lending experience"
18. Both users can rate 1-5 stars + optional comment
19. Ratings saved to database
20. Average ratings recalculated

21. System displays: "Exchange completed! Thank you for participating!"
22. System redirects to dashboard

**END (Lending)**

**SCENARIO: SWAP/GIVEAWAY (Permanent)**

Similar flow but:
- Step 5: No return inspection needed
- Step 15: Listing stays unavailable (item no longer owned)
- Step 12: Points for swap/giveaway (+20 each for swap, +5 for giveaway)

**END (Swap/Giveaway)**

### ASCII Diagram:

```
        (START - Request accepted, exchange happening)
                        │
                        ▼
                 ◇ Exchange type? ◇
                  /           \
              LENDING     SWAP/GIVEAWAY
                 │               │
                 ▼               ▼
    [Requester borrows item]  [Permanent exchange happens]
                 │               │
                 ▼               │
    [Time passes - duration]    │
                 │               │
                 ▼               │
    [Requester returns item]    │
                 │               │
                 ▼               │
    [Owner inspects condition]  │
                 │               │
                 ▼               │
       ◇ Condition OK? ◇        │
        /            \           │
      NO              YES        │
       │               │         │
       ▼               │         │
  [Discuss damage]     │         │
       │               │         │
       └───────┬───────┴─────────┘
               ▼
    [Either party logs in]
               │
               ▼
    [Navigate to request detail]
               │
               ▼
    [Click "Mark as Completed"]
               │
               ▼
    [System shows confirmation]
               │
               ▼
         ◇ Confirm? ◇
          /        \
        NO          YES
         │           │
    [Cancel]        ▼
         │   [Update status='completed']
         │           │
         └───────────▼
         [Update completed_date = now]
                     │
                     ▼
              ◇ Exchange type? ◇
               /            \
           LENDING      SWAP/GIVEAWAY
              │                │
              ▼                ▼
    [Award +5 to owner]  [Award +20 to both]
    [Award +10 to requester]   │
              │                │
              ▼                ▼
    [Update stats: lent++]  [Update stats: swapped++]
              │                │
              ▼                ▼
    [Mark item available]  [Keep item unavailable]
              │                │
              └────────┬───────┘
                       ▼
            ──── SPRINT 4 ────
                       │
                       ▼
         [Prompt both users to rate]
                       │
                       ▼
         [Owner rates requester]
                       │
                       ▼
         [Requester rates owner]
                       │
                       ▼
         [Save ratings to database]
                       │
                       ▼
         [Recalculate average_rating]
                       │
            ──── END SPRINT 4 ────
                       │
                       ▼
         [Display "Exchange completed!"]
                       │
                       ▼
         [Redirect to Dashboard]
                       │
                       ▼
                    (END)
```

---

## SUMMARY OF ACTIVITY DIAGRAMS

These 5 activity diagrams cover:

1. **User Registration & Login** - How users join the platform
2. **Create Listing** - How items are added to the platform
3. **Request Item** - How users initiate exchanges
4. **Accept/Decline Request** - How owners respond to requests
5. **Complete Exchange** - How exchanges are finalized

Together, these represent the complete user journey through your platform from registration to successful item sharing!

---

## HOW TO DRAW THESE DIAGRAMS

### Symbols to Use:

```
○  = Start/End (circle)
□  = Activity/Action (rectangle)
◇  = Decision (diamond)
→  = Flow direction (arrow)
├─ = Split/Fork
└─ = Join/Merge
```

### Software Options:
- **Draw.io** - easiest, drag-and-drop
- **Lucidchart** - professional looking
- **PlantUML** - code-based, version controllable
- **Microsoft Visio** - if available
- **Hand-drawn** - perfectly acceptable!

### Tips for Drawing:
1. Start with START node at top
2. Flow generally goes top-to-bottom
3. Use swimlanes if showing multiple actors (optional)
4. Keep decisions clear with YES/NO labels
5. Merge paths back together when possible
6. End with END node at bottom
7. Add notes/annotations for clarity

---

These activity diagrams show every critical flow in your platform!
