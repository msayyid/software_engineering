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
        if (!this.programme) {
            const sql = `select s.name as student,
                         ps.name as programme, ps.id as code
                         from students s
                         join student_programme sp on sp.id = s.id
                         join programmes ps on ps.id = sp.programme
                         where s.id = ?`;
            console.log("i am running");
            const result1 = await db.query(sql, [this.id]);
            const name = result1[0].programme;
            const pCode = result1[0].code;
            const programme = new Programme(pCode);
            programme.name = name;
            this.programme = programme;
            // const pCode = result1[0].code;
            // const result2 = await db.query(modSql, [pCode]);
            // this.programme.push(result2[0]);
            // this.programme = new Programme(pCode);
        }

    }

    async getStudentModules()  {
        if (this.modules.length === 0) {
            const modSql = `
                            select * from programme_modules pm
                                     join modules m on m.code = pm.module
                                     where programme = ?`;
            const result = await db.query(modSql, [this.programme.id]);
            const pCode = this.programme.id;
            // let mod = new Module(this.programme.id);
            for (let row of result) {
                const module = new Module(row.code);
                module.name = row.name;
                this.modules.push(row);
                // this.modules.push()
            }
        }

    }

}

// makes the class available to the project
module.exports = {
    Student
}