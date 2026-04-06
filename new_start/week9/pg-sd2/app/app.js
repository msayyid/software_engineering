process.on('uncaughtException', (err) => {
    console.error("UNCAUGHT EXCEPTION:", err);
});

process.on('unhandledRejection', (err) => {
    console.error("UNHANDLED PROMISE:", err);
});


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

// enable post usage
app.use(express.urlencoded({ extended: true}));

// get the student model
const { Student } = require( "./models/student");

// get the programme model (access to the class)
const { Programme } = require( "./models/programme");

// get the module model (access to the class)
const { Module } = require( "./models/module");

const { User } = require("./models/user");

// set the sessions
const session = require("express-session");
app.use(session({
    secret: "secretkeysdfjsflyoifasd",
    resave: false,
    saveUninitialized: true,
    cookie: { secure: false}
}));


// Create a route for root - /
app.get("/", function(req, res) {
    console.log(req.session);
    if(req.session.uId) {
        res.send(`Welcome back, ${req.session.uId}!`);
    } else {
        res.send("Please login to view this page!");
    }
    res.send();

});
// app.get("/", function(req, res) {
//     let test_data = ["one", "two", "three", "four"];
//     // send the array through the template as a variable called data
//     res.render("index", 
//         {"title":"My index page", "heading":"MY HEADING", "data":test_data});

// });

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
// app.get("/single-student/:id", async function(req, res) {

//     // Extract student id from URL parameter
//     let stId = req.params.id;

//     // Create a Student object using the id
//     let student = new Student(stId);

//     // Load student data from database
//     await student.getStudentDetails();        // load name
//     await student.getStudentProgramme();   // load programme
//     await student.getStudentModules();     // load modules

//     // load all programmes for programme selection and alteration
//     const resultProgs = await Programme.getAllProgrammes();


//     // Debug: check loaded student object
//     console.log("student object created:");
//     console.log(student);

//     // Render the view and pass student object to Pug
//     console.log("about to render");
//     res.render("student", {
//         student: student,
//         programmes:resultProgs
//     });
//     console.log("after render");

//     // Debug: check modules list
//     console.log(student.modules);
// });

app.get("/single-student/:id", async function(req, res) {
    try {
        let stId = req.params.id;

        let student = new Student(stId);
        console.log("before getStudentDetails");
        await student.getStudentDetails();
        console.log("before getStudentProgramme");
        await student.getStudentProgramme();
        console.log("before getStudentModules");
        await student.getStudentModules();

        console.log("before getAllProgrammes");
        const resultProgs = await Programme.getAllProgrammes();

        console.log("student object created:");
        console.log(student);

        console.log("before render");
        console.log(JSON.stringify(student, null, 2));
        // res.render("student", {
        //     student: student,
        //     programmes: resultProgs
        // });
        res.render("student", {
            student: {
                id: student.id,
                name: student.name,
                note: student.note,
                programme: student.programme
                    ? {
                        id: student.programme.id,
                        name: student.programme.name
                    }
                    : null,
                modules: student.modules.map(m => ({
                    code: m.code,
                    name: m.name
                }))
            },
            programmes: resultProgs.map(p => ({
                id: p.id,
                name: p.name
            }))
        });

        console.log("after render");

    } catch (err) {
        console.error("ERROR:", err);
        res.status(500).send("Something broke");
    }
    });

// POST route to recieve new data for a students' programme
app.post("/allocate-programme", async function(req, res) {
    // console.log("I am now in /allocate-programme page");

    let student = new Student(req.body.id);
    try {
        await student.updateStudentProgramme(req.body.programme);
        // .then(result => {
        res.redirect("/single-student/" + req.body.id);
        // });
    } catch(err) {
        console.error("Error while adding programme", err.message);
        res.status(500).send("Something went wrong");
    }
    console.log(req.body);

    // res.send("form submitted");

});

// POST for /add-note route
app.post("/add-note", async function(req, res) {
    let student = new Student(req.body.id);
    try {
        await student.addStudentNote(req.body.note);
        // .then(result => {
            // res.send("form submitted");
        res.redirect("/single-student/" + req.body.id);
        // });
        // console.log("I am console logging the notes itself");
        console.log(req.body);
    } catch (err) {
        console.error("Error while adding note", err.message);
        res.status(500).send("Something went wrong");
    }
    // res.send("form submitted");
});

// Register route 
app.get("/register", function(req, res) {
    res.render("register");
});

// /set-password route
app.post("/set-password", async function(req, res) {
    let user = new User(req.body.email);
    try {
        let uId = await user.getIdFromEmail();
        console.log("uId:", uId);
        if (uId) {
            // if a valid, existing user is found, set the password and redirect
            // to the users single-student page
            await user.setUserPassword(req.body.password);
            console.log(req.session ? req.session.id : "no session");
            // res.send("password set successfully");
            res.redirect("/single-student/" + uId);
        } else {
            // if no existing user is found, add a new one
            let newId = await user.addUser(req.body.password);
            console.log("newId:", newId);
            res.send("new user created");
            // res.send("perhaps a page where a new user sets a programme would be good here");
        }
    } catch(err) {
        console.error("Error while adding password", err.message);
        res.status(500).send("Something went wrong in set-password route")
    }
});

// Login
app.get("/login", function(req, res) {
    res.render("login");
});

// authenticate route
app.post("/authenticate", async function(req, res) {
    let user = new User(req.body.email);
    try {
        let uId = await user.getIdFromEmail();
        if (uId) {
            let match = await user.authenticate(req.body.password);
            if (match) {
                // set the session for this user
                req.session.uId = uId;
                req.session.loggedIn = true;
                console.log(req.session);
                res.redirect("/single-student/" + uId);
            } else {
                // TODO improve the user journey here
                res.send("Invalid password");
            }
        } else {
            res.send("Invalid email");
        }
    } catch (err) {
        console.err("Error while matching the passowrds", err.message);
    }

});

// Logout
app.get("/logout", function(req, res) {
    req.session.destroy();
    res.redirect("/login");
});


// welcome page for a user
app.get("/welcome", async function (req, res) {
    if (req.session.loggedIn) {
        // return res.send("Please login first");
        const uId = req.session.uId;
        const user = await User.getUserDetails(uId);
        res.render("welcome-page", {
            user:user
        });

    } else {
        // user not logged in
        res.redirect("/login");
    }

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