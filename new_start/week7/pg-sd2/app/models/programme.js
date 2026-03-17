const db = require("./../services/db");
const {Module } = require("./module");

class Programme {
    id;
    name;
    modules = [];

    constructor(id) {
        this.id = id;
    }

    // Load programme name from database
    async getProgrammeName() {

        // Only fetch if name is not already loaded
        if (typeof this.name !== "string") {

            // Query programme by id
            const sql = `select * from programmes where id = ?`;

            // Execute query using this programme's id
            const results = await db.query(sql, [this.id]);

            // Store programme name in the object
            this.name = results[0].name;
        }
    }


    // Load all modules that belong to this programme
    async getProgrammeModules() {

        // Only fetch if modules are not already loaded
        if (this.modules.length === 0) {

            // Query modules linked to this programme
            const sql = `
                select m.code, m.name
                from programme_modules pm
                join modules m on pm.module = m.code
                where pm.programme = ?
            `;

            // Execute query using programme id
            const results = await db.query(sql, [this.id]);

            // Convert each row into a Module object
            for (let row of results) {

                const module = new Module(row.code); // create module
                module.name = row.name;              // assign module name

                // Add module to programme's module list
                this.modules.push(module);
            }

            // Debug: check loaded modules
            console.log(this.modules);
        }
    }
}

module.exports = {
    Programme
}
