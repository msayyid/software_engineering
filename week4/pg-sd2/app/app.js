// Import express.js
const express = require("express");

// Create express app
var app = express();

// Add static files location
app.use(express.static("static"));

// Get the functions in the db.js file to use
const db = require('./services/db');

// Create a route for root - /
app.get("/", function(req, res) {
    res.send("Hello world!3412");
});

// ex 1, send json 
app.get("/all-students", function(req, res) {
    const sql = "select * from students";
    db.query(sql).then(results => {
        console.log(results);
        res.json(results);
    });


});

// ex 2
app.get("/all-students-formatted", function(req, res) {
    const sql = "select * from students";
    let output = "<table border='1'>";
    db.query(sql).then(results => {
        for (let row of results) {
            output += "<tr>"
            output += "<td>" + row.id + "</td>";
            output += "<td>" + "<a href='/single-student/" + row.id + "'>" + row.name + "</a></td>";
            output += "</tr>"
            console.log(row);
        }
        output += "</table>"
        res.send(output);
    });
    // res.send("i worked don't worry");
});

app.get("/single-student/:id", function(req, res) {
    let stId = req.params.id;
    console.log(stId);

    res.send(stId);
});

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