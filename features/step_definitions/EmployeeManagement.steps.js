const assert = require('assert');
const { Given, When, Then } = require('cucumber');
const { request } = require('graphql-request');

const endpoint = 'http://localhost:3000/api/graphql';

// Scenario: Add new employee
// Given(
// 'I am logged with the email {string} in as an administrator with the role {string}',
// async (email, role) => {
//   const query = `query GetUserByEmail($email: String) {
//     getUserByEmail(email: $email) {
//       roles {
//         name
//       }
//     }
//   }`;

//   const variables = {
//     email,
//   };

//   response = await request(endpoint, query, variables);

//   const { getUserByEmail } = response;
//   assert.ok(getUserByEmail.roles.some(item => item.name === role));
//   assert.ok(!getUserByEmail.roles.some(item => item.name !== role));
// }
// );

// When(
//   'I add a new employee with name {string}, identification {string}, position {string} and email {string}',
//   async (name, document, position, email) => {
//     const positionQuery = `query GetPositionByName($name: String) {
//       getPositionByName(name: $name) {
//         id
//       }
//     }`;

//     const positionVariables = {
//       position,
//     };

//     const {
//       getPositionByName: { id: positionId },
//     } = await request(endpoint, positionQuery, positionVariables);

// const userMutation = `mutation CreateUser($data: UserCreateInput, $roleId: String) {
//   createUser(data: $data, role_id: $roleId) {
//     email
//     name
//     position {
//       name
//     }
//     document
//   }
// }`;

// const variables = {
//   data: {
//     name,
//     document,
//     position_id: positionId,
//     email,
//   },
// };

// const { createUser } = await request(endpoint, userMutation, variables);

//     const {
//       email: userEmail,
//       name: userName,
//       position: { name: positionName },
//       document: userDocument,
//     } = createUser;

//     assert.equal(userEmail, email);
//     assert.equal(userName, name);
//     assert.equal(positionName, position);
//     assert.equal(userDocument, document);
//   }
// );

// Then(
//   'the employee {string} with the document {string} should be added successfully',
//   async (name, document) => {
//   const query = `query GetUserByDocument($document: String) {
//   getUserByDocument(document: $document) {
//     name
//   }
// }`;

//   const variables = {
//     document,
//   };
//   const { getUserByDocument } = await request(endpoint, query, variables);

//   assert.equal(getUserByDocument.name, name);
// }
// );

// Scenario: Add training plan to employee
Given(
  'I am logged with the email {string} in as an administrator with the role {string}',
  async (email, role) => {
    const query = `query GetUserByEmail($email: String) {
    getUserByEmail(email: $email) {
      roles {
        name
      }
    }
  }`;

    const variables = {
      email,
    };

    const response = await request(endpoint, query, variables);

    const { getUserByEmail } = response;
    assert.ok(getUserByEmail.roles.some(item => item.name === role));
    assert.ok(!getUserByEmail.roles.some(item => item.name !== role));
  }
);

Given(
  'an employee {string} with the document {string} exists',
  async (name, document) => {
    const query = `query GetUserByDocument($document: String) {
    getUserByDocument(document: $document) {
      name
    }
  }`;

    const variables = {
      document,
    };
    const { getUserByDocument } = await request(endpoint, query, variables);

    assert.equal(getUserByDocument.name, name);
  }
);

When(
  'I add a training plan named {string} with description {string} and courses {string}, {string}, {string}',
  async (name, description, course1, course2, course3) => {
    // const trainingMutation = `mutation CreateTraining($data: TrainingCreateInput) {
    //   createTraining(data: $data) {
    //     id
    //   }
    // }`;

    // const variables = {
    //   data: {
    //     name,
    //     description,
    //   },
    // };

    // const { createTraining } = await request(
    //   endpoint,
    //   trainingMutation,
    //   variables
    // );

    const courseMutation = `mutation CreateCourse($data: CourseCreateInput) {
      createCourse(data: $data) {
        name
      }
    }`;

    const course1Variables = {
      data: {
        name: course1,
        link: 'testlink.com',
        duration: 4,
      },
    };

    const course2Variables = {
      data: {
        name: course2,
        link: 'testlink.com',
        duration: 4,
      },
    };

    const course3Variables = {
      data: {
        name: course3,
        link: 'testlink.com',
        duration: 4,
      },
    };

    const { createCourse: createCourse1 } = await request(
      endpoint,
      courseMutation,
      course1Variables
    );

    const { createCourse: createCourse2 } = await request(
      endpoint,
      courseMutation,
      course2Variables
    );

    const { createCourse: createCourse3 } = await request(
      endpoint,
      courseMutation,
      course3Variables
    );
    assert.equal(createCourse1.name, course1);
    assert.equal(createCourse2.name, course2);
    assert.equal(createCourse3.name, course3);
  }
);

When('I assign the plan {string} to the employee {string}', function(
  planName,
  employeeName
) {
  // Code to assign the training plan to the employee
});

Then(
  'the training plan {string} should be assigned to the employee {string} successfully',
  function(planName, employeeName) {
    // Code to verify that the training plan was assigned successfully
  }
);

// // Scenario: Register completed course
// Given('I am logged in as an employee', function() {
//   // Code to log in as an employee
// });

// Given('I have a training plan assigned', function() {
//   // Code to check if a training plan is assigned to the employee
// });

// When('I register a completed course named {string}', function(courseName) {
//   // Code to register the completed course
// });

// Then('the course {string} should be marked as completed successfully', function(
//   courseName
// ) {
//   // Code to verify that the course was marked as completed successfully
// });

// // Scenario: View monthly top employees
// Given('I am logged in as an administrator', function() {
//   // Code to log in as an administrator
// });

// When('I view the monthly top employees', function() {
//   // Code to generate the report of monthly top employees
// });

// Then(
//   'I should see a report with the top employees who completed the most courses',
//   function() {
//     // Code to verify that the report shows the top employees who completed the most courses
//   }
// );

// // Scenario: Login to system
// Given('I am on the login page', function() {
//   // Code to navigate to the login page
// });

// When('I enter my email {string} and password {string}', function(
//   email,
//   password
// ) {
//   // Code to enter the email and password
// });

// When('I click on the login button', function() {
//   // Code to click on the login button
// });

// Then('I should be logged in successfully', function() {
//   // Code to verify that the user is logged in successfully
// });
