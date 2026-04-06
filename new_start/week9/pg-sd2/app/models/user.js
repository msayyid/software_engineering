// get the functions in the db.js file to use
const db = require("../services/db");
const bcrypt = require("bcrypt");

class User{
    id;
    email;

    constructor(email) {
        this.email = email;
    }

    // get an existing user id from an email address, or return false
    async getIdFromEmail() {
        const sql = "select id from users where users.email = ?";
        const result = await db.query(sql, [this.email]);

        console.log("getidfromemail result: ", result);
        // TODO lots of error checks in here
        if (result.length > 0) {
            this.id = result[0].id;
            return this.id;
        } else {
            return false;
        }
    }

    // add a password to an existing user
    async setUserPassword(password) {
        const pw = await bcrypt.hash(password, 10);
        const sql = "update users set password = ? where users.id = ?";
        await db.query(sql, [pw, this.id]);
        return true; 
    }

    // add a new record to the users table
    async addUser(password) {
        const pw = await bcrypt.hash(password, 10);
        const sql = "insert into users (email, password) values (?, ?)";
        const result = await db.query(sql, [this.email, pw]);

        console.log("addUser result:", result);
        console.log(result.insertId);
        this.id = result.insertId;
        return this.id;
    }

    async authenticate(submitted) {
        // get the stored, hashed password for the user
        const sql = "select password from users where id = ?";
        const result = await db.query(sql, [this.id]);
        const match = await bcrypt.compare(submitted, result[0].password);
        if (match == true) {
            return true;
        } else {
            return false;
        }
    }


}


module.exports = { User };