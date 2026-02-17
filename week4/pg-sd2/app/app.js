// Import express.js
const express = require("express");

// Create express app
var app = express();

// Add static files location
app.use(express.static("static"));

// Get the functions in the db.js file to use
const db = require('./services/db');

// pug templating engine
app.set('view engine', 'pug');
app.set('views', './app/views');

// Create a route for root - /

app.get("/", function(req, res) {
    // set up an rray of data
    let test_data = ['one', 'two', 'three', 'four'];
    // send the array through to the template as a variable called data
    res.render("index", {'title': 'My index page', 'heading':'My heading', 'data':test_data});
});

// this is pug template test
// app.get("/", function(req, res){
//     res.render("index", {"title": "My index page", "heading":"My heading", "paragraph": "this is a new paragraph"});
// });
// app.get("/", function(req, res) {
//     res.send("Hello world!3412");
// });

// ex 1, send json 
app.get("/all-students", function(req, res) {
    const sql = "select * from students";
    db.query(sql).then(results => {
        console.log(results);
        res.json(results);
    });


});

// ex 2
// app.get("/all-students-formatted", function(req, res) {
//     const sql = "select * from students";
//     let output = "<table border='1'>";
//     db.query(sql).then(results => {
//         for (let row of results) {
//             output += "<tr>"
//             output += "<td>" + row.id + "</td>";
//             output += "<td>" + "<a href='/single-student/" + row.id + "'>" + row.name + "</a></td>";
//             output += "</tr>"
//             console.log(row);
//         }
//         output += "</table>"
//         res.send(output);
//     });
//     // res.send("i worked don't worry");
// });

// refactored all-students-formatted
app.get("/all-students-formatted", function(req, res) {
    let sql = "select * from students";
    db.query(sql).then(results => {
        res.render('all-students', {data: results});
    });
});

// this is from week 2
// app.get("/single-student/:id", function(req, res) {
//     let stId = req.params.id;
//     console.log(stId);

//     res.send(stId);
// });

app.get("/single-student/:id", function(req, res) {
    let stId = req.params.id;
    const sql = "select * from students where id = ?";

    db.query(sql, [stId]).then(results => {
        if (results.length > 0) {
            res.render("single-student", {student: results[0] });
        }
        else {
            res.send("student not found!!!!!");
        }
    })
    console.log(stId);

    // res.send(stId);
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