# SPRINT 2: SEQUENCE DIAGRAMS
## Community Item Sharing Platform - Items Only

Sequence diagrams show how objects/components interact over time for specific scenarios.

---

## DIAGRAM 1: USER REGISTRATION SEQUENCE

### Description:
Shows interaction between User, Browser, Express Server, and MySQL Database during registration.

### Participants:
- **User**: Person registering
- **Browser**: Frontend (HTML/PUG/JavaScript)
- **Express Server**: Backend Node.js application
- **MySQL Database**: Data storage

### Sequence Flow:

```
User          Browser         Express Server      MySQL Database
 |               |                    |                   |
 |--[1. Click "Sign Up"]-->           |                   |
 |               |                    |                   |
 |               |--[2. GET /register]-->                 |
 |               |                    |                   |
 |               |<--[3. Render registration form]--------|
 |               |                    |                   |
 |<--[4. Display form]----            |                   |
 |               |                    |                   |
 |--[5. Fill form & submit]-->        |                   |
 |               |                    |                   |
 |               |--[6. POST /register (email, password)]-->
 |               |                    |                   |
 |               |              [7. Validate input]       |
 |               |                    |                   |
 |               |              [8. Hash password (bcrypt)]
 |               |                    |                   |
 |               |           [9. Check email exists?]---->|
 |               |                    |                   |
 |               |                    |<--[10. Query result]
 |               |                    |                   |
 |               |             [11. Email available?]     |
 |               |                    |                   |
 |               |           [YES - Continue]             |
 |               |                    |                   |
 |               |           [12. INSERT INTO users]----->|
 |               |                    |                   |
 |               |                    |<--[13. user_id returned]
 |               |                    |                   |
 |               |             [14. Create session]       |
 |               |                    |                   |
 |               |             [15. Send verification email]
 |               |                    |                   |
 |               |<--[16. Redirect to /profile/setup]-----|
 |               |                    |                   |
 |<--[17. Load profile setup page]---|                   |
 |               |                    |                   |
 |--[18. Complete profile]-->         |                   |
 |               |                    |                   |
 |               |--[19. POST /profile (name, bio, location)]-->
 |               |                    |                   |
 |               |           [20. UPDATE users SET...]---->|
 |               |                    |                   |
 |               |                    |<--[21. Success]---|
 |               |                    |                   |
 |               |<--[22. Redirect to /dashboard]---------|
 |               |                    |                   |
 |<--[23. Display dashboard]---------|                   |
 |               |                    |                   |
```

### Alternative Flows:

**If email already exists (step 9-11):**
```
Express Server      MySQL Database
      |                    |
[9. Check email]---------->|
      |                    |
      |<--[10. Email found]|
      |                    |
[11. Email NOT available]  |
      |                    |
[Send error response]      |
      |                    |
Browser receives 400 error |
"Email already registered" |
```

---

## DIAGRAM 2: REQUEST ITEM SEQUENCE

### Description:
Shows interaction when a user requests an item from another user.

### Participants:
- **Requester**: User requesting item
- **Browser**: Frontend
- **Express Server**: Backend
- **MySQL Database**: Storage
- **Owner**: Item owner (receives notification)

### Sequence Flow:

```
Requester    Browser    Express Server    MySQL DB    Owner
    |           |              |              |          |
    |--[1. Browse listings]--->|              |          |
    |           |              |              |          |
    |           |--[2. GET /listings]-------->|          |
    |           |              |              |          |
    |           |        [3. SELECT * FROM listings WHERE available=1]-->
    |           |              |              |          |
    |           |              |<--[4. Listings data]----|
    |           |              |              |          |
    |           |<--[5. Render listings page]------------|
    |           |              |              |          |
    |<--[6. Display items]----|              |          |
    |           |              |              |          |
    |--[7. Click item of interest]-->        |          |
    |           |              |              |          |
    |           |--[8. GET /listings/:id]--->|          |
    |           |              |              |          |
    |           |        [9. SELECT * FROM listings WHERE id=?]-->
    |           |              |              |          |
    |           |              |<--[10. Listing details]|
    |           |              |              |          |
    |           |<--[11. Render detail page]-------------|
    |           |              |              |          |
    |<--[12. Display item detail]------------|          |
    |           |              |              |          |
    |--[13. Click "Request This Item"]----->|          |
    |           |              |              |          |
    |           |<--[14. Show request form]-------------|
    |           |              |              |          |
    |<--[15. Display form]----|              |          |
    |           |              |              |          |
    |--[16. Fill message, duration]-------->|          |
    |           |              |              |          |
    |--[17. Click "Send Request"]---------->|          |
    |           |              |              |          |
    |           |--[18. POST /requests (listing_id, message, duration)]-->
    |           |              |              |          |
    |           |      [19. Validate input]  |          |
    |           |              |              |          |
    |           |      [20. Check user owns item?]----->|
    |           |              |              |          |
    |           |              |<--[21. Not owner]------|
    |           |              |              |          |
    |           |      [22. INSERT INTO requests]------>|
    |           |              |              |          |
    |           |              |<--[23. request_id]-----|
    |           |              |              |          |
    |           |      [24. Get owner_id from listing]->|
    |           |              |              |          |
    |           |      [25. Create notification]        |
    |           |              |              |          |
    |           |              |              |    [26. Notification created for owner]
    |           |              |              |          |
    |           |<--[27. Success response]-------------- |
    |           |              |              |          |
    |<--[28. Display "Request sent!"]--------|          |
    |           |              |              |          |
    |           |<--[29. Redirect to /my-requests]------|
    |           |              |              |          |
```

### When Owner Logs In Next:

```
Owner      Browser    Express Server    MySQL DB
  |           |              |              |
  |--[1. Log in]------------>|              |
  |           |              |              |
  |           |--[2. GET /dashboard]------->|
  |           |              |              |
  |           |   [3. SELECT requests WHERE listing.owner=user]-->
  |           |              |              |
  |           |              |<--[4. Pending requests (including new one)]
  |           |              |              |
  |           |<--[5. Render dashboard with notification badge "1 new request"]
  |           |              |              |
  |<--[6. See notification]----------------|
```

---

## DIAGRAM 3: ACCEPT REQUEST SEQUENCE

### Description:
Shows what happens when owner accepts a request (includes Sprint 4 points system).

### Participants:
- **Owner**: Item owner
- **Browser**: Frontend
- **Express Server**: Backend
- **MySQL Database**: Storage
- **Requester**: User who made request

### Sequence Flow:

```
Owner      Browser    Express Server    MySQL DB    Requester
  |           |              |              |            |
  |--[1. View "Requests on My Items"]---->|            |
  |           |              |              |            |
  |           |--[2. GET /requests/received]----------->|
  |           |              |              |            |
  |           |   [3. SELECT requests WHERE listing.user_id=?]-->
  |           |              |              |            |
  |           |              |<--[4. Pending requests]--|
  |           |              |              |            |
  |           |<--[5. Render requests list]-------------|
  |           |              |              |            |
  |<--[6. Display requests]----------------|            |
  |           |              |              |            |
  |--[7. Click specific request]--------->|            |
  |           |              |              |            |
  |           |--[8. GET /requests/:id]--->|            |
  |           |              |              |            |
  |           |   [9. SELECT * FROM requests WHERE id=?]-->
  |           |              |              |            |
  |           |              |<--[10. Request details]--|
  |           |              |              |            |
  |           |   [11. SELECT * FROM users WHERE id=requester_id]-->
  |           |              |              |            |
  |           |              |<--[12. Requester profile]|
  |           |              |              |            |
  |           |<--[13. Render request detail]----------|
  |           |              |              |            |
  |<--[14. Display full request + requester info]-----|
  |           |              |              |            |
  |--[15. Click "Accept"]----------------->|            |
  |           |              |              |            |
  |           |<--[16. Confirmation modal]-------------|
  |           |              |              |            |
  |<--[17. "Accept request?"]--------------|            |
  |           |              |              |            |
  |--[18. Confirm "Yes"]------------------>|            |
  |           |              |              |            |
  |           |--[19. POST /requests/:id/accept]------->|
  |           |              |              |            |
  |           |    [20. BEGIN TRANSACTION]              |
  |           |              |              |            |
  |           |    [21. UPDATE requests SET status='accepted', responded_date=NOW()]-->
  |           |              |              |            |
  |           |              |<--[22. Success]----------|
  |           |              |              |            |
  |           |    [23. UPDATE users SET points=points+10 WHERE id=requester_id]-->
  |           |              |              |            |
  |           |              |<--[24. Requester points updated]
  |           |              |              |            |
  |           |    [25. UPDATE users SET points=points+5 WHERE id=owner_id]-->
  |           |              |              |            |
  |           |              |<--[26. Owner points updated]
  |           |              |              |            |
  |           |    [27. INSERT INTO notifications (requester_id, type, message)]-->
  |           |              |              |            |
  |           |              |<--[28. Notification created]
  |           |              |              |            |
  |           |    [29. UPDATE listings SET is_available=? WHERE id=?]-->
  |           |              |              |            |(optional)
  |           |              |<--[30. Availability updated]
  |           |              |              |            |
  |           |    [31. COMMIT TRANSACTION]             |
  |           |              |              |            |
  |           |<--[32. Success response]----------------|
  |           |              |              |            |
  |<--[33. Display "Request accepted!"]---|            |
  |           |              |              |            |
  |           |<--[34. Redirect or show messaging]-----|
  |           |              |              |            |
  |           |              |              |      [35. Requester notification created]
  |           |              |              |            |
```

### When Requester Logs In Next:

```
Requester  Browser    Express Server    MySQL DB
    |         |              |              |
    |--[1. Log in]--------->|              |
    |         |              |              |
    |         |--[2. GET /dashboard]------>|
    |         |              |              |
    |         |   [3. SELECT notifications WHERE user_id=? AND is_read=0]-->
    |         |              |              |
    |         |              |<--[4. "Your request was accepted!"]
    |         |              |              |
    |         |<--[5. Display notification banner + updated points]
    |         |              |              |
    |<--[6. See acceptance notification]---|
```

---

## DIAGRAM 4: MESSAGING SEQUENCE (Sprint 4)

### Description:
Shows real-time-ish messaging between users (polling approach, not WebSockets).

### Participants:
- **User A (Sender)**: Sends message
- **Browser A**: Sender's browser
- **Express Server**: Backend
- **MySQL Database**: Storage
- **Browser B**: Receiver's browser
- **User B (Receiver)**: Receives message

### Sequence Flow:

```
User A    Browser A    Express Server    MySQL DB    Browser B    User B
  |           |              |              |            |           |
  |--[1. Open messages]----->|              |            |           |
  |           |              |              |            |           |
  |           |--[2. GET /messages/conversation/:userId]-->          |
  |           |              |              |            |           |
  |           |   [3. SELECT * FROM messages WHERE sender/receiver match]-->
  |           |              |              |            |           |
  |           |              |<--[4. Message history]---|            |
  |           |              |              |            |           |
  |           |<--[5. Render conversation]-------------- |           |
  |           |              |              |            |           |
  |<--[6. Display messages]----------------|            |           |
  |           |              |              |            |           |
  |           |    [7. Start polling every 5 seconds]   |           |
  |           |              |              |            |           |
  |--[8. Type message]------>|              |            |           |
  |           |              |              |            |           |
  |--[9. Click "Send"]------>|              |            |           |
  |           |              |              |            |           |
  |           |--[10. POST /messages (receiver_id, content)]-------->|
  |           |              |              |            |           |
  |           |   [11. INSERT INTO messages (sender_id, receiver_id, content, is_read=0)]-->
  |           |              |              |            |           |
  |           |              |<--[12. message_id]-------|            |
  |           |              |              |            |           |
  |           |<--[13. Success response]----------------|            |
  |           |              |              |            |           |
  |<--[14. Message appears in conversation]------------|            |
  |           |              |              |            |           |
  |           |              |              |     [15. Browser B polling]
  |           |              |              |            |           |
  |           |              |<--[16. GET /messages/new]-------------|
  |           |              |              |            |           |
  |           |   [17. SELECT * FROM messages WHERE receiver_id=? AND is_read=0]-->
  |           |              |              |            |           |
  |           |              |<--[18. New messages (including User A's)]
  |           |              |              |            |           |
  |           |              |--[19. Return new messages]----------->|
  |           |              |              |            |           |
  |           |              |              |    [20. Update UI with new message]
  |           |              |              |            |           |
  |           |              |              |            |<--[21. Display message]
  |           |              |              |            |           |
  |           |              |              |    [22. User B opens conversation]
  |           |              |              |            |           |
  |           |              |<--[23. GET /messages/conversation/:userId]
  |           |              |              |            |           |
  |           |   [24. UPDATE messages SET is_read=1 WHERE receiver_id=? AND sender_id=?]-->
  |           |              |              |            |           |
  |           |              |<--[25. Messages marked as read]      |
  |           |              |              |            |           |
  |           |              |--[26. Return conversation]---------->|
  |           |              |              |            |           |
  |           |              |              |<--[27. Display full conversation]
  |           |              |              |            |           |
```

### Polling Mechanism (JavaScript):

```javascript
// Browser A and Browser B both run this
setInterval(async () => {
    const response = await fetch('/api/messages/new');
    const newMessages = await response.json();
    
    if (newMessages.length > 0) {
        // Append new messages to conversation
        newMessages.forEach(msg => {
            appendMessageToUI(msg);
        });
        
        // Update unread count
        updateUnreadBadge();
        
        // Play notification sound (optional)
        playNotificationSound();
    }
}, 5000); // Poll every 5 seconds
```

---

## DIAGRAM 5: COMPLETE EXCHANGE WITH RATING SEQUENCE (Sprint 4)

### Description:
Shows the full flow of marking exchange complete and rating each other.

### Participants:
- **Owner**: Item owner
- **Requester**: Item requester
- **Browser**: Frontend (both users)
- **Express Server**: Backend
- **MySQL Database**: Storage

### Sequence Flow:

```
Requester  Browser    Express Server    MySQL DB    Owner
    |         |              |              |          |
    |         |       [Item exchange happened offline]          |
    |         |              |              |          |
    |--[1. Item returned]-------------------------------->      |
    |         |              |              |          |
    |--[2. Log in]--------->|              |          |
    |         |              |              |          |
    |         |--[3. Navigate to request detail]----->|
    |         |              |              |          |
    |         |--[4. Click "Mark as Completed"]------>|
    |         |              |              |          |
    |         |<--[5. Confirmation modal]-------------|
    |         |              |              |          |
    |<--[6. "Confirm exchange complete?"]--|          |
    |         |              |              |          |
    |--[7. Confirm "Yes"]------------------>|          |
    |         |              |              |          |
    |         |--[8. POST /requests/:id/complete]---->|
    |         |              |              |          |
    |         |    [9. BEGIN TRANSACTION]  |          |
    |         |              |              |          |
    |         |    [10. UPDATE requests SET status='completed', completed_date=NOW()]-->
    |         |              |              |          |
    |         |              |<--[11. Success]---------|
    |         |              |              |          |
    |         |    [12. Award points]                 |
    |         |    UPDATE users SET points=points+5 WHERE id=owner_id]-->
    |         |    UPDATE users SET points=points+10 WHERE id=requester_id]-->
    |         |              |              |          |
    |         |              |<--[13. Points updated]--|
    |         |              |              |          |
    |         |    [14. Update stats]                 |
    |         |    UPDATE users SET items_lent=items_lent+1 WHERE id=owner]-->
    |         |    UPDATE users SET items_borrowed=items_borrowed+1 WHERE id=requester]-->
    |         |              |              |          |
    |         |              |<--[15. Stats updated]---|
    |         |              |              |          |
    |         |    [16. IF lending: UPDATE listings SET is_available=1]-->
    |         |              |              |          |
    |         |              |<--[17. Item available again]
    |         |              |              |          |
    |         |    [18. COMMIT TRANSACTION]           |
    |         |              |              |          |
    |         |<--[19. Success response]--------------|
    |         |              |              |          |
    |<--[20. Display "Exchange completed! Please rate"]
    |         |              |              |          |
    |         |<--[21. Show rating modal for Owner]---|
    |         |              |              |          |
    |<--[22. Rating form: 1-5 stars + comment]-------|
    |         |              |              |          |
    |--[23. Select 5 stars, enter comment]---------->|
    |         |              |              |          |
    |--[24. Submit rating]----------------------->   |
    |         |              |              |          |
    |         |--[25. POST /ratings (rated_id=owner, score=5, comment)]-->
    |         |              |              |          |
    |         |    [26. INSERT INTO ratings]--------->|
    |         |              |              |          |
    |         |              |<--[27. rating_id]------|
    |         |              |              |          |
    |         |    [28. SELECT AVG(score) FROM ratings WHERE rated_id=owner]-->
    |         |              |              |          |
    |         |              |<--[29. New average: 4.8]
    |         |              |              |          |
    |         |    [30. UPDATE users SET average_rating=4.8 WHERE id=owner]-->
    |         |              |              |          |
    |         |              |<--[31. Rating updated]--|
    |         |              |              |          |
    |         |<--[32. Success]------------------------| 
    |         |              |              |          |
    |<--[33. "Thank you for rating!"]----------------|
    |         |              |              |          |
    |         |              |              |    [34. Notify owner to rate requester]
    |         |              |              |          |
```

### When Owner Logs In:

```
Owner     Browser    Express Server    MySQL DB
  |          |              |              |
  |--[1. Log in]---------->|              |
  |          |              |              |
  |          |--[2. GET /dashboard]------>|
  |          |              |              |
  |          |   [3. Check pending ratings]-->
  |          |              |              |
  |          |              |<--[4. "Please rate Requester"]
  |          |              |              |
  |          |<--[5. Show rating prompt]--|
  |          |              |              |
  |<--[6. Click "Rate Now"]---------------|
  |          |              |              |
  |--[7. Submit rating for Requester]---->|
  |          |              |              |
  |          |   [Same flow as above: INSERT rating, UPDATE average]
  |          |              |              |
```

---

## SUMMARY: KEY INTERACTIONS

These sequence diagrams show:

1. **Registration**: User → Browser → Express → Database → Email Service
2. **Request Item**: Requester → Database → Notification → Owner
3. **Accept Request**: Owner → Database → Points awarded → Requester notified
4. **Messaging**: Sender → Database → Polling → Receiver
5. **Complete & Rate**: Both users → Database → Points & Ratings updated

All critical flows for your platform are documented!

---

## HOW TO DRAW SEQUENCE DIAGRAMS

### Software Options:
- **PlantUML** - code-based, excellent for sequence diagrams
- **Draw.io** - drag-and-drop
- **Lucidchart** - professional
- **SequenceDiagram.org** - simple online tool
- **Hand-drawn** - acceptable!

### Key Elements:
```
Participant    = Vertical lifeline (dotted line)
Message        = Horizontal arrow →
Return message = Horizontal dashed arrow ← - -
Activation     = Rectangle on lifeline (when object is active)
Note           = Floating text box
```

### Tips:
1. Time flows top to bottom
2. Read left-to-right for each message
3. Show return values with dashed arrows
4. Use activation boxes to show when object is processing
5. Number steps for clarity
6. Use notes to explain complex logic

---

These sequence diagrams cover all your key interactions in detail!
