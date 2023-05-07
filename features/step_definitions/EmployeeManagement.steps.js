const { Given, When, Then } = require('cucumber');

// Scenario: Add new employee
  Given('I am logged in as an administrator', function () {
    // Code to log in as an administrator
  });
  
  When('I add a new employee with name {string}, identification {string}, position {string} and email {string}', function (name, id, position, email) {
    // Code to add a new employee with the given details
  });
  
  Then('the employee {string} should be added successfully', function (name) {
    // Code to verify that the employee was added successfully
  });
  

// Scenario: Add training plan to employee
  Given('I am logged in as an administrator', function () {
    // Code to log in as an administrator
  });
  
  Given('an employee {string} exists', function (name) {
    // Code to check if the employee exists
  });
  
  When('I add a training plan named {string} with description {string} and courses {string}', function (name, description, courses) {
    // Code to add a new training plan with the given details
  });
  
  When('I assign the plan {string} to the employee {string}', function (planName, employeeName) {
    // Code to assign the training plan to the employee
  });
  
  Then('the training plan {string} should be assigned to the employee {string} successfully', function (planName, employeeName) {
    // Code to verify that the training plan was assigned successfully
  });
  

// Scenario: Register completed course
  Given('I am logged in as an employee', function () {
    // Code to log in as an employee
  });
  
  Given('I have a training plan assigned', function () {
    // Code to check if a training plan is assigned to the employee
  });
  
  When('I register a completed course named {string}', function (courseName) {
    // Code to register the completed course
  });
  
  Then('the course {string} should be marked as completed successfully', function (courseName) {
    // Code to verify that the course was marked as completed successfully
  });
  

// Scenario: View monthly top employees
  Given('I am logged in as an administrator', function () {
    // Code to log in as an administrator
  });
  
  When('I view the monthly top employees', function () {
    // Code to generate the report of monthly top employees
  });
  
  Then('I should see a report with the top employees who completed the most courses', function () {
    // Code to verify that the report shows the top employees who completed the most courses
  });
  
  
// Scenario: Login to system
  Given('I am on the login page', function () {
    // Code to navigate to the login page
  });
  
  When('I enter my email {string} and password {string}', function (email, password) {
    // Code to enter the email and password
  });
  
  When('I click on the login button', function () {
    // Code to click on the login button
  });
  
  Then('I should be logged in successfully', function () {
    // Code to verify that the user is logged in successfully
  });
