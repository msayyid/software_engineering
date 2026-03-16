// get the functions in the db.js file to use

const db = require("./../services/db");

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

    async getStudentName() {
        console.log("getstudentname method is actually getting called");
        // if name is not loaded yet, load it
        if (typeof this.name !== "string") {
            let sql = `select * from students where id = ?`;
            const results = await db.query(sql, [this.id]);
            this.name = results[0].name;
        }

    }

    async getStudentProgramme() {
        if (typeof this.programme !== "string") {
            const sql = ``;
        }

    }

    async getStudentModules()  {

    }

}

// makes the class available to the project
module.exports = {
    Student
}