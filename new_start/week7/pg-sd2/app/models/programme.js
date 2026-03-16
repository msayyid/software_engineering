const db = require("./../services/db");

class Programme {
    id;
    name;

    constructor(id) {
        this.id = id;
    }

    async getProgrammeName() {
        if (typeof this.name !== "string") {
            const sql = `select * from programmes where id = ?`;
            const results = await db.query(sql, [this.id]);
            this.name = results[0].name;
        }
    }
}

module.exports = {
    Programme
}
