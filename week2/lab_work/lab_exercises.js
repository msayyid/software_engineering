// Exercise Conditionals in Javascript

// Write javascript code for the following. First use if, else if, else. 
// Then rewrite using a switch. (Set up a single variable for the student year, 
// and change its value to test the code - we will make this more complicated later)

// A student can be in year 1, 2, or 3. Write your code such that 
// if the student year is 1, the output is ‘You are in year 1’, 
// if 2, you are in year 2 and so on.
let student_year = 3;

if (student_year === 1) {
    console.log(`You are in year ${student_year}`);
}
else if(student_year === 2) {
    console.log(`You are in year ${student_year}`);
}
else if(student_year === 3) {
    console.log(`You are in year ${student_year}`);
}

// Exercise For loop Write a for loop that outputs numbers 1 to 20.

// for (let i = 0; i < 20; i++) {
//     console.log(i+1);
// }

// Exercise While loop Output numbers 1 to 20, this time using a while loop
let i = 0;
output = "";
while (i < 20){
    output += `${i+1} `;
    i++;
}
console.log(output);