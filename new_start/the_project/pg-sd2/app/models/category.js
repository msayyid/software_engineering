const db = require("./../services/db");

class Category {
    // attributes
    category_id;
    category_name;
    description;
    icon;
    listing_count;

    // constructor

    constructor(category_id) {
        this.category_id = category_id;
    }

    static async getAllCategories() {
        const sql = `select * from categories`;
        const result = await db.query(sql);
        return result;
    }

    async getCategory() {
        const sql = `select * from categories
                            where category_id = ?`;

        let result = await db.query(sql, [tihs.category_id]);
        if (!result[0]) {
            throw new Error("No category found");
        }
        Object.assign(this, result[0]);
    }
}

module.exports = { Category }