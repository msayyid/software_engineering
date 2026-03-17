// Import express.js
const express = require("express");

// Create express app
var app = express();

// Add static files location
app.use(express.static("static"));

// Get the functions in the db.js file to use
const db = require('./services/db');

// pug template engine
app.set("view engine", "pug");
app.set("views", "./app/views");

// load user class (model)
const { User } = require("./models/user");

// Create a route for root - /
app.get("/", function(req, res) {
    res.send("Hello world!");
});

app.get("/all-users-formatted", async function(req, res) {
    const sql = `select * from users`;
    const results = await db.query(sql);
    res.render("all-users-formatted", {
        results: results
    });
    console.log("i can see all the users that will be formatted in here");
    console.log(results);

})

app.get("/single-user/:id", async function(req, res) {
    const uId = req.params.id;
    let user = new User(uId);
    await user.getUser();
    res.render("user", {
        user:user
    });
    console.log("now i need to be seeing a user with a givn id");
    console.log(user);
});

app.get("/project_db_test", async function (req, res) {
    const sql = `select user_id, first_name, last_name, email, location, bio
                 from users`;
    const results = await db.query(sql);
    res.send(results);
    console.log("we ve got the results from our poject_db database");
    console.log(results)
})

// Create a route for testing the db
app.get("/db_test", function(req, res) {
    // Assumes a table called test_table exists in your database
    sql = 'select * from test_table';
    db.query(sql).then(results => {
        console.log(results);
        res.send(results)
    });
});

// Create a route for /goodbye
// Responds to a 'GET' request
app.get("/goodbye", function(req, res) {
    res.send("Goodbye world!");
});

// Create a dynamic route for /hello/<name>, where name is any value provided by user
// At the end of the URL
// Responds to a 'GET' request
app.get("/hello/:name", function(req, res) {
    // req.params contains any parameters in the request
    // We can examine it in the console for debugging purposes
    console.log(req.params);
    //  Retrieve the 'name' parameter and use it in a dynamically generated page
    res.send("Hello " + req.params.name);
});

// Start server on port 3000
app.listen(3000,function(){
    console.log(`Server running at http://127.0.0.1:3000/`);
});