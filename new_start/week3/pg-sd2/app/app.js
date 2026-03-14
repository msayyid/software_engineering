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
    res.send("Hello Msayyid");
    // console.log("hello people i m haereere!!!!!");
    console.log(req.url);
});

// ex 2: create a new route with path /roehampton which should send the text hello roehampton
// to the user when they request the url 3000/roehampton

// app.get("/roehampton", function (req, res) {
//     res.send("Hello. Roehampton.");
//     // console.log("this is also a test but in other page");
// });

// ex 4: createa a var and capture the request path
// and send only the first 3 letters out to the browser
app.get("/exercise4", function(req, res) {
    console.log(req.url);
    let path = req.url;
    res.send(path.substring(5));
});

// additional tasks use the roehampton route, capture the request and remove / and reverse
app.get("/roehampton", function(req, res) {
    const word = req.url;
    let array = [];
    for (let c of word) {
        array.push(c);
    }
    // res.send(array);
    // remove the leading /
    array.shift();

    // reverse the elements
    array.reverse();

    console.log(array);
    // res.send(array);

    // join them back to a word
    const reversed = array.join("");
    res.send(`
        ${array} - removed <br>${reversed} - reversed
        `);
    console.log(reversed);
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

// ex 5 (Dynamic routing)
app.get("/db_test/:id", function(req, res) {
    const id = req.params.id;
    sql = "select * from test_table where id = ?";
    db.query(sql, [id]).then(results => {
        console.log(results);
        res.send(`
            <h1> Student</h1>
            <p>ID: ${results[0].id}</p>
            <p>Name: ${results[0].name}</p>
            
        `);
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

// ex 2 (Dynamic routing) Create a dynamic route which where a user 
// may request /user/:id where the ID can be any ID number. 
// Output the input ID to the browser.
app.get("/user/:id", function(req, res) {
    console.log(`here's the id on the console mate ${req.params.id}`);
    res.send("THIS IS YOUR ID " + req.params.id);
});

// ex 3 (Dynamic Routing) Create a dynamic route which where a user may 
// request /student/:name/:id where the ID can be any ID number, 
// and the name can be any name. Output the name and ID to the browser
app.get("/student/:name/:id", function(req, res) {
    const name = req.params.name;
    const id = req.params.id;
    console.log(`your name: ${name}\nyour id: ${id}`);
    res.send(`your name: ${name}<br>your id: ${id}`)
});

// ex 4 take ex3 and display in an html table
app.get("/student/table/:name/:id", function(req, res) {
    const name = req.params.name;
    const id = req.params.id;
    console.log(`your name: ${name}\nyour id: ${id}`);
    
    res.send(`
        <html>
        <body>
            <table border = "1">
                <tr>
                    <th>Name</th>
                    <th>ID</th>
                </tr>
                <tr>
                    <td>${name}</td>
                    <td>${id}</td>
                </tr>
            </table>
        </body>
        </html>    
    `);

});

// additional task 2
// Create a dynamic route where the user may request /number/:n 
// where n is any number. Output all the numbers from 0 to the number 
// entered, formatted in an HTML table
app.get("/number/:n", function(req, res) {
    const num = Number(req.params.n);
    let html = "<table border = 1>";

    for (let i = 0; i <= num; i++) {
        html += "<tr>" +
                    "<td>" + i + "</td>" +
                "</tr>";
    }
    html += "</table>";
    console.log(html);
    res.send(html);

});


// Start server on port 3000
app.listen(3000,function(){
    console.log(`Server running at http://127.0.0.1:3000/`);
});