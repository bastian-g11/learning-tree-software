Feature: Employee Management
As an administrator or employee
I want to manage employees and their training courses
So that I can keep track of their progress and skills


Scenario: Add training plan to employee
Given I am logged with the email "admin@test.com" in as an administrator with the role "ADMIN"
And an employee "John Smith" with the document "123456" exists
When I add a training plan named "Web Development" with description "Learn web development" and courses "HTML", "CSS", "JavaScript"
And I assign the plan "Web Development" to the employee "John Smith"
Then the training plan "Web Development" should be assigned to the employee "John Smith" successfully