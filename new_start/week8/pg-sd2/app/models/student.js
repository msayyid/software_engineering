// get the functions in the db.js file to use

const db = require("./../services/db");
const { Programme } = require("./programme");
const { Module } = require("./module");

class Student {
    // id
    id;
    name;
    programme;
    modules = []; // modules

    // constructor
    constructor(id) {
        this.id = id;
    }

    // Load student's name from database
    async getStudentName() {

        // Debug: confirm method is called
        console.log("getStudentName called");

        // Only fetch if name is not already loaded
        if (typeof this.name !== "string") {

            // Query student by id
            let sql = `select * from students where id = ?`;

            // Execute query with this student's id
            const results = await db.query(sql, [this.id]);

            // Store name in the object
            this.name = results[0].name;
        }
    }


    // Load student's programme (id + name)
    async getStudentProgramme() {

        // Only fetch if programme is not already loaded
        if (!this.programme) {

            // Query to get programme linked to this student
            const sql = `
                select s.name as student,
                    ps.name as programme,
                    ps.id as code
                from students s
                join student_programme sp on sp.id = s.id
                join programmes ps on ps.id = sp.programme
                where s.id = ?
            `;

            // Execute query
            const result = await db.query(sql, [this.id]);

            // Extract programme data
            const name = result[0].programme;
            const pCode = result[0].code;

            // Create Programme object and assign values
            const programme = new Programme(pCode);
            programme.name = name;

            // Attach programme to student
            this.programme = programme;
        }
    }


    // Load all modules for the student's programme
    async getStudentModules() {

        // Only fetch if modules are not already loaded
        if (this.modules.length === 0) {

            // Query modules linked to the programme
            const modSql = `
                select * from programme_modules pm
                join modules m on m.code = pm.module
                where programme = ?
            `;

            // Execute query using programme id
            const result = await db.query(modSql, [this.programme.id]);

            // Convert each DB row into a Module object
            for (let row of result) {

                const module = new Module(row.code); // create module
                module.name = row.name;              // assign name

                // Add module to student's modules list
                this.modules.push(module);
            }
        }
    }

}

// makes the class available to the project
module.exports = {
    Student
}