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

// Create a route for root - /
app.get("/", function(req, res) {
    
    // res.render("index",
    //     {"title":"my index page", "heading": "my heading", "text": "this is just the text from redner function breo"}
    // );

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

app.get("/single-student/:id", function(req, res) {
    // Get the student id from the URL parameter
    const stId = req.params.id;

    // First SQL query:
    // - get the student's name
    // - get the programme name
    // - get the programme id/code
    // for the student whose id matches stId
    let stSql = `
        SELECT s.name AS student,
            ps.name AS programme,
            ps.id AS pcode
        FROM students s
        JOIN student_programme sp ON sp.id = s.id
        JOIN programmes ps ON ps.id = sp.programme
        WHERE s.id = ?
        `;

        // Second SQL query:
        // - get all modules for a given programme
        // - join programme_modules with modules
        // - match module code from modules table with module field in programme_modules
        let modSql = `
            SELECT * FROM programme_modules pm
            JOIN modules m on m.code = pm.module
            WHERE programme = ?    
        `;

    // Run the first query using the student id
    db.query(stSql, [stId]).then(results1 => {
        let pCode = results1[0].pcode;
        db.query(modSql, [pCode]).then(results2 => {
            res.render("single-student", {
                data1:results1,
                data2:results2
            });
            
        });
    });
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
app.get("/single-programme/:id", function(req, res) {
    const id = req.params.id;

    const sql = `
            -- Get all modules that belong to a specific programme
            select m.code, m.name
            from programme_modules pm   -- linking table between programmes and modules
            join modules m on pm.module = m.code   -- connect module code to module details
            where pm.programme = ?      -- filter modules for the selected programme
    `;

    const programSql = `
            -- Get programme information (id and name)
            select p.id, p.name
            from programmes p
            where p.id = ?              -- select the requested programme
    `;
    db.query(programSql, [id]).then(results1 => {
        db.query(sql, [id]).then(results2 => {
            res.render("single-programme", {
                data1:results1,
                data2:results2
            });
        });
    });
    
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
app.get("/single-module/:code", function(req, res) {
    const code = req.params.code;
    // to get programme name i need to connect modules.code with programme_modules.module
    // and get based on programme_modules.programme get programmes.name
    const sql = `
                select m.name as module_title, m.code as module_code, p.name as programme_name, s.name as student_name
                from modules m
                join programme_modules pm on m.code = pm.module
                join programmes p on p.id = pm.programme
                join student_programme sp on sp.programme = pm.programme
                join students s on s.id = sp.id
                where m.code = ?
    `;
    db.query(sql, [code]).then(results => {
        res.render("single-module", {
            data:results
        });
        // let html = `<h1>Module Code: ${results[0].module_code}<br>Module Title: ${results[0].module_title}</h1>
        //             <table border = 1>
        //                 <tr>
        //                     <th>Student Name</th>
        //                     <th>Programme Name</th>
        //                 </tr>
        // `;
        // for (let row of results) {
        //     html += `<tr>
        //                 <td>${row.student_name}</td>
        //                 <td>${row.programme_name}</td>
        //              </tr>`;
        // }
        // html += `</table>`;
        // res.send(html);
        // console.log("bro i am working");
        // console.log(html);
    });
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