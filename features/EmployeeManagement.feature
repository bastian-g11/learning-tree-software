Feature: Employee Management
As an administrator or employee
I want to manage employees and their training courses
So that I can keep track of their progress and skills

Scenario: Add new employee
Given I am logged in as an administrator
When I add a new employee with name "John Smith", identification "123456", position "Developer" and email "john.smith@example.com"
Then the employee "John Smith" should be added successfully

Scenario: Add training plan to employee
Given I am logged in as an administrator
And an employee "John Smith" exists
When I add a training plan named "Web Development" with description "Learn web development" and courses "HTML, CSS, JavaScript"
And I assign the plan "Web Development" to the employee "John Smith"
Then the training plan "Web Development" should be assigned to the employee "John Smith" successfully

Scenario: Register completed course
Given I am logged in as an employee
And I have a training plan assigned
When I register a completed course named "HTML"
Then the course "HTML" should be marked as completed successfully

Scenario: View monthly top employees
Given I am logged in as an administrator
When I view the monthly top employees
Then I should see a report with the top employees who completed the most courses

Scenario: Login to system
Given I am on the login page
When I enter my email "john.smith@example.com" and password "password123"
And I click on the login button
Then I should be logged in successfully
