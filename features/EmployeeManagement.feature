Feature: Employee Management
As an administrator or employee
I want to manage employees and their training courses
So that I can keep track of their progress and skills

# Scenario: Add new employee
# Given an user logged in with the email "admin@test.com" with the role "ADMIN"
# When he adds a new employee with name "John Smith", identification "123456", position "DEVELOPER" and email "user@test.com"
# Then the employee "John Smith" with the document "123456" should be added successfully

# Scenario: Add training plan to employee
# Given an user logged in with the email "admin@test.com" with the role "ADMIN"
# And an employee "John Smith" with the document "123456" exists
# When he adds a training plan named "Web Development" with description "Learn web development" and courses "HTML", "CSS", "JavaScript"
# And he assigns the plan "Web Development" to the employee with the document "123456"
# Then the training plan "Web Development" should be assigned to the employee with the document "123456" successfully

# Scenario: Register completed course
# Given an user logged in with the email "user@test.com" with the role "USER"
# And the user with the email "user@test.com" has the training plan "Web Development" assigned
# When the user with the email "user@test.com" registers a completed course named "HTML"
# Then the course "HTML" assigned to the user with the email "user@test.com" should be marked as completed successfully

Scenario: Add a comment to a training plan
Given an user logged in with the email "user@test.com" with the role "USER"
When the user with the email "user@test.com" adds the comment "What a great training" to the training plan "Web Development"
Then the comment "What a great training" added by the user with the email "user@test.com" to the training plan "Web Development" should be added successfully
