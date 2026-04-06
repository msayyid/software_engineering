const db = require("./../services/db");
// const { Student } = require("./student");

class Module {
    code;
    name;
    students = [];

    constructor(code) {
        this.code = code;
    }

    // Load module name from database
    async getModuleName() {

        // Only fetch if name is not already loaded
        if (typeof this.name !== "string") {

            // Query module by its code
            const sql = `select * from modules where code = ?`;

            // Execute query using this module's code
            const results = await db.query(sql, [this.code]);

            // Store module name in the object
            this.name = results[0].name;
        }
    }


    // Load all students (and their programmes) for this module
    async getModuleStudents() {

        // Only fetch if students are not already loaded
        if (this.students.length === 0) {

            // Query students and their programmes linked to this module
            const sql = `
                select p.name as programme_name,
                    s.name as student_name
                from programme_modules pm
                join modules m on m.code = pm.module
                join programmes p on p.id = pm.programme
                join student_programme sp on sp.programme = pm.programme
                join students s on s.id = sp.id
                where m.code = ?
            `;

            // Execute query using module code
            const results = await db.query(sql, [this.code]);

            // Convert each row into a simple object {student, programme}
            for (let row of results) {

                this.students.push({
                    student: row.student_name,
                    programme: row.programme_name
                });
            }

            // Debug: check loaded students
            console.log(this.students);
        }
    }


}

module.exports = {
    Module
}