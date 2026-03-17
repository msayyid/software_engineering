// Import express.js
const express = require("express");

// Create express app
var app = express();

// Add static files location
app.use(express.static("static"));

// use the PUG template engine
// Tell Express to use Pug as the template engine for rendering dynamic pages
app.set("view engine", "pug");

// Tell Express where the Pug template files are stored
app.set("views", "./app/views");

// Get the functions in the db.js file to use
const db = require('./services/db');

// get the student model
const { Student } = require( "./models/student");

// get the programme model (access to the class)
const { Programme } = require( "./models/programme");

// get the module model (access to the class)
const { Module } = require( "./models/module");

// Create a route for root - /
app.get("/", function(req, res) {
    let test_data = ["one", "two", "three", "four"];
    // send the array through the template as a variable called data
    res.render("index", 
        {"title":"My index page", "heading":"MY HEADING", "data":test_data});

});

// ex 1 Provide JSON output listing all students
app.get("/all-students", function(req, res) {
    sql = "select * from students";
    db.query(sql).then(results => {
        console.log(results);
        res.send(results);
    });
});


// ex 2 Provide an HTML formatted output listing all students 
// in a table where each student is linked to a single-student page
app.get("/all-students-formatted", function(req, res) {
    sql = "select * from students";
    // let output = "<table border = 1>";
    db.query(sql).then(results => {
        // so 
        res.render("all-students", {data:results});
    });
});

// for week 7, reconstruction with classes
// Route: /single-student/:id
// Handles request to view a single student's details
app.get("/single-student/:id", async function(req, res) {

    // Extract student id from URL parameter
    let stId = req.params.id;

    // Create a Student object using the id
    let student = new Student(stId);

    // Load student data from database
    await student.getStudentName();        // load name
    await student.getStudentProgramme();   // load programme
    await student.getStudentModules();     // load modules

    // Debug: check loaded student object
    console.log("student object created:");
    console.log(student);

    // Render the view and pass student object to Pug
    res.render("student", {
        student: student
    });

    // Debug: check modules list
    console.log(student.modules);
});


// independent tasks
// ex 1, provide a json output of all programs
app.get("/all-programmes", function(req, res) {
    sql = "select * from programmes";
    db.query(sql).then(results => {
        console.log(results);
        res.send(results);
    });
});

// ex 2, provide html formatted output of all programmes in a table
// where each program is linked to a single-programme page
app.get("/all-programmes-formatted", function(req, res) {
    let sql = "select * from programmes";
    db.query(sql).then(results => {
        res.render("all-programmes-formatted", {
            data:results
        });
    });
});

// now create a single programme page, showing programme title
// and all modules for the programme
app.get("/single-programme/:id", async function(req, res) {
    let id = req.params.id;
    let programme = new Programme(id);
    await programme.getProgrammeName();
    await programme.getProgrammeModules();
    console.log("programme object is created");
    res.render("programme", {
        programme:programme
    })
    
});

// ex 4 provide a json output of all modules
app.get("/all-modules", function(req, res) {
    const sql = `
                select * from modules`;
    db.query(sql).then(results => {
        res.send(results);
        // res.json(results);
        console.log("all modules, mate");
        console.log(results);
    });
});

// html formtted output of all modules in a table, where each module is linked to
// a single module page
app.get("/all-modules-formatted", function(req, res) {
    const sql = `select * from modules`;
    db.query(sql).then(results => {
        res.render("all-modules-formatted", {
            modules:results
        });
    });
});

// now create a single-module page showing a module title,
// its programme and all the students for that module
app.get("/single-module/:code", async function(req, res) {
    const code = req.params.code;
    let module = new Module(code);
    await module.getModuleName();
    await module.getModuleStudents();
    console.log("i think the module object is created");
    console.log(module);
    res.render("module", {
        module: module
    })
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