Feature: Employee Management
As an administrator or employee
I want to manage employees and their training courses
So that I can keep track of their progress and skills

# Scenario: Add new employee
# Given An user logged in with the email "admin@test.com" in with the role "ADMIN"
# When he adds a new employee with name "John Smith", identification "123456", position "DEVELOPER" and email "user@test.com"
# Then the employee "John Smith" with the document "123456" should be added successfully

# Scenario: Add training plan to employee
# Given An user logged in with the email "admin@test.com" in with the role "ADMIN"
# And an employee "John Smith" with the document "123456" exists
# When he adds a training plan named "Web Development" with description "Learn web development" and courses "HTML", "CSS", "JavaScript"
# And he assigns the plan "Web Development" to the employee with the document "123456"
# Then the training plan "Web Development" should be assigned to the employee with the document "123456" successfully

Scenario: Register completed course
Given  An user logged in with the email "user@test.com" in with the role "USER"
And he has the training plan "Web Development" assigned
When he registers a completed course named "HTML"
Then the course "HTML" should be marked as completed successfully