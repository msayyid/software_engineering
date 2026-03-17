const db = require("./../services/db");

class User {
    // attributes
    user_id;
    email;
    password_hash;
    first_name;
    last_name;
    bio = null;
    location;
    latitude;
    longitude;
    profile_pic;
    points;
    average_rating;
    total_ratings;
    items_lent;
    items_borrowed;
    items_given;
    is_active;
    created_at;
    updated_at;

    constructor(user_id) {
        this.user_id = user_id;

    }

    async getUser() {
        const sql = `select * from users
                            where user_id = ?`;
        // Execute the query safely using parameter binding (prevents SQL injection)
        const result = await db.query(sql, [this.user_id]);

        // result is an array of rows → we take the first row (since user_id is unique)
        // result[0] contains all columns from the users table
        const row = result[0];

        if (!row) {
            throw new Error("User not found");
        }

        // Copy all properties from the DB row into this object
        // e.g. row.email → this.email, row.first_name → this.first_name, etc.
        Object.assign(this, row);


    }
}

module.exports = { User }