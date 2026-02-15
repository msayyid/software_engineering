# SPRINT 2: CLASS DIAGRAM
## Community Item Sharing Platform - MVC Architecture

Class diagram shows the structure of your Express.js application using MVC pattern.

---

## MVC ARCHITECTURE OVERVIEW

```
┌─────────────────────────────────────────────────────────────┐
│                      CLIENT (BROWSER)                        │
│                     HTML / CSS / JavaScript                   │
└───────────────────────────┬─────────────────────────────────┘
                            │
                    HTTP Requests/Responses
                            │
┌───────────────────────────▼─────────────────────────────────┐
│                        VIEW LAYER                            │
│                      (PUG Templates)                          │
├──────────────────────────────────────────────────────────────┤
│  layout.pug  │  index.pug  │  users/  │  listings/  │ etc. │
└───────────────────────────┬─────────────────────────────────┘
                            │
                    Renders with data
                            │
┌───────────────────────────▼─────────────────────────────────┐
│                     CONTROLLER LAYER                         │
│                     (Express Routes)                          │
├──────────────────────────────────────────────────────────────┤
│  authController  │  userController  │  listingController    │
│  requestController │ messageController │ ratingController   │
└───────────────────────────┬─────────────────────────────────┘
                            │
                    Business Logic / Data Operations
                            │
┌───────────────────────────▼─────────────────────────────────┐
│                       MODEL LAYER                            │
│                  (Data Access Objects)                        │
├──────────────────────────────────────────────────────────────┤
│  User Model  │  Listing Model  │  Request Model  │  etc.   │
└───────────────────────────┬─────────────────────────────────┘
                            │
                      SQL Queries
                            │
┌───────────────────────────▼─────────────────────────────────┐
│                      DATA LAYER                              │
│                     (MySQL Database)                          │
└──────────────────────────────────────────────────────────────┘
```

---

## CLASS DEFINITIONS

### CONTROLLER CLASSES

#### AuthController
```javascript
class AuthController {
    // Properties
    - db: DatabaseConnection
    
    // Methods
    + showRegisterPage(req, res): void
    + register(req, res): Promise<void>
    + showLoginPage(req, res): void
    + login(req, res): Promise<void>
    + logout(req, res): void
    + verifyEmail(req, res): Promise<void>
    
    // Private helpers
    - validateRegistrationInput(data): Object
    - hashPassword(password): Promise<string>
    - comparePassword(plain, hash): Promise<boolean>
    - createSession(userId): string
}
```

#### UserController
```javascript
class UserController {
    // Properties
    - db: DatabaseConnection
    
    // Methods
    + getAllUsers(req, res): Promise<void>
    + getUserById(req, res): Promise<void>
    + showEditProfile(req, res): Promise<void>
    + updateProfile(req, res): Promise<void>
    + uploadProfilePicture(req, res): Promise<void>
    
    // Private helpers
    - validateProfileData(data): Object
    - checkOwnership(userId, profileId): boolean
}
```

#### ListingController
```javascript
class ListingController {
    // Properties
    - db: DatabaseConnection
    
    // Methods
    + getAllListings(req, res): Promise<void>
    + getListingById(req, res): Promise<void>
    + showCreateForm(req, res): void
    + createListing(req, res): Promise<void>
    + showEditForm(req, res): Promise<void>
    + updateListing(req, res): Promise<void>
    + deleteListing(req, res): Promise<void>
    + toggleAvailability(req, res): Promise<void>
    + searchListings(req, res): Promise<void>
    + filterByCategory(req, res): Promise<void>
    
    // Private helpers
    - validateListingData(data): Object
    - uploadPhotos(files): Promise<string[]>
    - incrementViewCount(listingId): Promise<void>
}
```

#### RequestController
```javascript
class RequestController {
    // Properties
    - db: DatabaseConnection
    - notificationService: NotificationService
    
    // Methods
    + createRequest(req, res): Promise<void>
    + getMyRequests(req, res): Promise<void>
    + getRequestsOnMyItems(req, res): Promise<void>
    + getRequestById(req, res): Promise<void>
    + acceptRequest(req, res): Promise<void>
    + declineRequest(req, res): Promise<void>
    + cancelRequest(req, res): Promise<void>
    + markComplete(req, res): Promise<void>
    
    // Private helpers
    - validateRequest(data): Object
    - awardPoints(userId, amount): Promise<void>
    - notifyOwner(ownerId, request): Promise<void>
    - notifyRequester(requesterId, status): Promise<void>
}
```

#### MessageController (Sprint 4)
```javascript
class MessageController {
    // Properties
    - db: DatabaseConnection
    
    // Methods
    + sendMessage(req, res): Promise<void>
    + getConversation(req, res): Promise<void>
    + getNewMessages(req, res): Promise<void>
    + markAsRead(req, res): Promise<void>
    + getUnreadCount(req, res): Promise<void>
    
    // Private helpers
    - validateMessage(content): boolean
}
```

#### RatingController (Sprint 4)
```javascript
class RatingController {
    // Properties
    - db: DatabaseConnection
    
    // Methods
    + submitRating(req, res): Promise<void>
    + getUserRatings(req, res): Promise<void>
    + calculateAverageRating(userId): Promise<number>
    
    // Private helpers
    - validateRating(data): Object
    - updateUserRating(userId): Promise<void>
}
```

---

### MODEL CLASSES

#### User
```javascript
class User {
    // Properties
    + userId: number
    + email: string
    + passwordHash: string
    + firstName: string
    + lastName: string
    + bio: string
    + location: string
    + latitude: number
    + longitude: number
    + profilePic: string
    + points: number
    + averageRating: number
    + totalRatings: number
    + itemsLent: number
    + itemsBorrowed: number
    + itemsGiven: number
    + isActive: boolean
    + createdAt: Date
    + updatedAt: Date
    
    // Methods
    + static findById(userId): Promise<User>
    + static findByEmail(email): Promise<User>
    + static findAll(): Promise<User[]>
    + static create(userData): Promise<User>
    + update(userData): Promise<boolean>
    + delete(): Promise<boolean>
    + getListings(): Promise<Listing[]>
    + getRequests(): Promise<Request[]>
    + getRatings(): Promise<Rating[]>
    + addPoints(amount): Promise<void>
    + calculateDistance(otherUser): number
}
```

#### Listing
```javascript
class Listing {
    // Properties
    + listingId: number
    + userId: number
    + title: string
    + description: string
    + category: string
    + exchangeType: string  // 'lending', 'swap', 'giveaway'
    + conditionStatus: string  // 'like_new', 'good', 'fair', 'well_used'
    + conditionNotes: string
    + photoUrl1: string
    + photoUrl2: string
    + photoUrl3: string
    + swapPreferences: string
    + isAvailable: boolean
    + viewCount: number
    + requestCount: number
    + createdAt: Date
    + updatedAt: Date
    
    // Relationships
    - owner: User
    - tags: Tag[]
    - requests: Request[]
    
    // Methods
    + static findById(listingId): Promise<Listing>
    + static findByUserId(userId): Promise<Listing[]>
    + static findAll(filters): Promise<Listing[]>
    + static create(listingData): Promise<Listing>
    + update(listingData): Promise<boolean>
    + delete(): Promise<boolean>
    + toggleAvailability(): Promise<void>
    + incrementViewCount(): Promise<void>
    + getOwner(): Promise<User>
    + getTags(): Promise<Tag[]>
    + addTags(tagIds): Promise<void>
    + getRequests(): Promise<Request[]>
    + static search(keyword): Promise<Listing[]>
    + static filterByCategory(category): Promise<Listing[]>
    + static findNearby(lat, lng, radius): Promise<Listing[]>
}
```

#### Request
```javascript
class Request {
    // Properties
    + requestId: number
    + listingId: number
    + requesterId: number
    + status: string  // 'pending', 'accepted', 'declined', 'completed', 'cancelled'
    + message: string
    + requestedDuration: string
    + swapOfferDescription: string
    + requestedDate: Date
    + respondedDate: Date
    + completedDate: Date
    + ownerNotes: string
    
    // Relationships
    - listing: Listing
    - requester: User
    
    // Methods
    + static findById(requestId): Promise<Request>
    + static findByRequester(userId): Promise<Request[]>
    + static findByListing(listingId): Promise<Request[]>
    + static create(requestData): Promise<Request>
    + accept(): Promise<boolean>
    + decline(): Promise<boolean>
    + cancel(): Promise<boolean>
    + markComplete(): Promise<boolean>
    + getListing(): Promise<Listing>
    + getRequester(): Promise<User>
    + getOwner(): Promise<User>
}
```

#### Tag
```javascript
class Tag {
    // Properties
    + tagId: number
    + tagName: string
    + usageCount: number
    
    // Methods
    + static findById(tagId): Promise<Tag>
    + static findByName(name): Promise<Tag>
    + static findAll(): Promise<Tag[]>
    + static create(tagName): Promise<Tag>
    + static findOrCreate(tagName): Promise<Tag>
    + incrementUsage(): Promise<void>
    + getListings(): Promise<Listing[]>
}
```

#### Rating (Sprint 4)
```javascript
class Rating {
    // Properties
    + ratingId: number
    + requestId: number
    + raterId: number
    + ratedId: number
    + score: number  // 1-5
    + comment: string
    + ratingType: string
    + createdAt: Date
    
    // Methods
    + static findById(ratingId): Promise<Rating>
    + static findByUser(userId): Promise<Rating[]>
    + static create(ratingData): Promise<Rating>
    + static calculateAverage(userId): Promise<number>
}
```

#### Message (Sprint 4)
```javascript
class Message {
    // Properties
    + messageId: number
    + senderId: number
    + receiverId: number
    + requestId: number
    + listingId: number
    + content: string
    + isRead: boolean
    + sentAt: Date
    
    // Methods
    + static findById(messageId): Promise<Message>
    + static findConversation(user1, user2): Promise<Message[]>
    + static findUnread(userId): Promise<Message[]>
    + static create(messageData): Promise<Message>
    + markAsRead(): Promise<void>
}
```

---

### MIDDLEWARE CLASSES

#### AuthMiddleware
```javascript
class AuthMiddleware {
    // Methods
    + static isAuthenticated(req, res, next): void
    + static isOwner(req, res, next): void
    + static checkVerification(req, res, next): void
}
```

#### ValidationMiddleware
```javascript
class ValidationMiddleware {
    // Methods
    + static validateRegistration(req, res, next): void
    + static validateListing(req, res, next): void
    + static validateRequest(req, res, next): void
    + static validateRating(req, res, next): void
    + static sanitizeInput(req, res, next): void
}
```

#### UploadMiddleware
```javascript
class UploadMiddleware {
    // Properties
    - multer: Multer
    - allowedTypes: string[]
    - maxSize: number
    
    // Methods
    + static uploadPhotos(req, res, next): void
    + static uploadProfilePic(req, res, next): void
    + static validateFileType(file): boolean
    + static validateFileSize(file): boolean
}
```

---

### SERVICE CLASSES

#### NotificationService
```javascript
class NotificationService {
    // Methods
    + static createNotification(userId, type, message): Promise<void>
    + static sendEmail(to, subject, body): Promise<void>
    + static getUnreadCount(userId): Promise<number>
}
```

#### PointsService (Sprint 4)
```javascript
class PointsService {
    // Methods
    + static awardPoints(userId, amount, reason): Promise<void>
    + static deductPoints(userId, amount, reason): Promise<void>
    + static getPointsHistory(userId): Promise<Object[]>
}
```

#### GeocodingService (Sprint 4)
```javascript
class GeocodingService {
    // Properties
    - apiKey: string
    
    // Methods
    + static geocodeAddress(address): Promise<{lat, lng}>
    + static calculateDistance(lat1, lng1, lat2, lng2): number
}
```

---

## CLASS RELATIONSHIPS (UML Notation)

```
┌─────────────────────┐
│   AuthController    │
└──────────┬──────────┘
           │
           │ uses
           ▼
┌─────────────────────┐          ┌─────────────────────┐
│      User Model     │◄─────────┤  UserController     │
└──────────┬──────────┘   uses   └─────────────────────┘
           │
           │ has many
           ▼
┌─────────────────────┐          ┌─────────────────────┐
│   Listing Model     │◄─────────┤ ListingController   │
└──────────┬──────────┘   uses   └─────────────────────┘
           │
           │ has many
           ▼
┌─────────────────────┐          ┌─────────────────────┐
│   Request Model     │◄─────────┤ RequestController   │
└──────────┬──────────┘   uses   └──────────┬──────────┘
           │                                 │
           │ has many                        │ uses
           ▼                                 ▼
┌─────────────────────┐          ┌─────────────────────┐
│   Rating Model      │◄─────────┤  RatingController   │
│    (Sprint 4)       │   uses   │    (Sprint 4)       │
└─────────────────────┘          └─────────────────────┘


┌─────────────────────┐
│   Listing Model     │
└──────────┬──────────┘
           │
           │ many-to-many
           ▼
┌─────────────────────┐
│     Tag Model       │
└─────────────────────┘
```

### Relationships:
- **Controller → Model**: Uses (dependency)
- **User → Listing**: One-to-Many (composition)
- **Listing → Request**: One-to-Many (composition)
- **Request → Rating**: One-to-Many (composition)
- **Listing ↔ Tag**: Many-to-Many (association)

---

## FILE STRUCTURE

```
/controllers
  ├── authController.js
  ├── userController.js
  ├── listingController.js
  ├── requestController.js
  ├── ratingController.js    // Sprint 4
  └── messageController.js   // Sprint 4

/models
  ├── User.js
  ├── Listing.js
  ├── Request.js
  ├── Tag.js
  ├── Rating.js              // Sprint 4
  └── Message.js             // Sprint 4

/middleware
  ├── auth.js
  ├── validation.js
  ├── upload.js
  └── errorHandler.js

/services
  ├── notificationService.js
  ├── pointsService.js       // Sprint 4
  └── geocodingService.js    // Sprint 4

/routes
  ├── index.js               // Main router
  ├── auth.js
  ├── users.js
  ├── listings.js
  ├── requests.js
  ├── ratings.js             // Sprint 4
  └── messages.js            // Sprint 4

/views
  ├── layout.pug
  ├── index.pug
  ├── auth/
  ├── users/
  ├── listings/
  └── dashboard/

/config
  ├── database.js
  └── app.js

app.js                       // Main Express app
server.js                    // Server startup
```

---

This MVC class structure provides clean separation of concerns for your platform!
