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
    res.send("Salam alaikum, brother!");
});

// ex 2; new route /roehampton
app.get("/roehampton", function(req, res) {
    console.log(req.url);

    let path = req.url;
    res.send(path.substring(0, 3));
    // res.send("hello roehampton");
});


// Dynamic route /user/:id
app.get("/user/:id", function(req, res) {
    // : means this part of the URL is dynamic, it is a placeholder
    // params stores all dynamic parts of the URL {id: '42'}
    let id = req.params.id;
    res.send(`User ID is ${id}`);
});

// mulitple dynamic parameters
app.get("/student/:name/:id", function(req, res) {
    // capture both name and id, store them, output on the website
    let name = req.params.name;
    let id = req.params.id;

    let html = `
        <h1>The table</h2>
        <table border="1">
            <tr>
                <th>Name</th>
                <th>ID</th>
            </tr>

            <tr>
                <td>${name}</td>
                <td>${id}</td>
            </tr>
        </table>
    
    `;
    res.send(html);
    // res.send(`Student ${name} has ID ${id}`);1
})

// ex 5; database route
// app.get("/db_test/:id", function(req, res){
//     let id = req.params.id;
//     sql = "SELECT name FROM test_table WHERE id = ?";
//     db.query(sql, [id], function(err, results) {
//         if (err) {
//             console.log("start here!!!");
//             console.error(err);
//             res.send("Database errorrrr!");
//             return;
//         }

//         if (results.length === 0) {
//             res.send("<h2>No user found</h2>");
//             return;
//         }

//         let name = results[0].name;

//         let html = `
//             <h1>User information</h1>
//             <p><strong>Name:</strong> ${name}</p>
//         `;
//         res.send(html);

//     });

// });
// ex 5; database route


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