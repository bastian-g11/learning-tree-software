const assert = require('assert');
const { Given, When, Then } = require('cucumber');
const { request } = require('graphql-request');
const {
  GET_USER_BY_EMAIL,
  GET_TRAINING_BY_NAME,
  GET_TRAINING_BY_ID,
  GET_POSITION_BY_NAME,
  GET_USER_BY_DOCUMENT,
  GET_COURSE,
  GET_COURSE_BY_NAME,
} = require('./queries');
const {
  CREATE_USER,
  CREATE_TRAINING,
  CREATE_COURSE,
  ADD_TRAINING_TO_USER,
  CREATE_COURSE_STATE,
  CREATE_COMMENT,
} = require('./mutations');

const endpoint = 'http://localhost:3000/api/graphql';

// Scenario: Add a comment to a training plan
Given(
  'an user logged in with the email {string} with the role {string}',
  async (employeeEmail, role) => {
    const variables = {
      email: employeeEmail,
    };

    const { getUserByEmail } = await request(
      endpoint,
      GET_USER_BY_EMAIL,
      variables
    );

    assert.ok(getUserByEmail.roles.some(item => item.name === role));
    assert.ok(!getUserByEmail.roles.some(item => item.name !== role));
  }
);

// When(
//   'he adds a new employee with name {string}, identification {string}, position {string} and email {string}',
//   async (name, document, position, email) => {
//     const positionVariables = {
//       position,
//     };

//     const {
//       getPositionByName: { id: positionId },
//     } = await request(endpoint, GET_POSITION_BY_NAME, positionVariables);

//     const variables = {
//       data: {
//         name,
//         document,
//         position_id: positionId,
//         email,
//       },
//     };

//     const { createUser } = await request(endpoint, CREATE_USER, variables);

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
//     const variables = {
//       document,
//     };
//     const { getUserByDocument } = await request(
//       endpoint,
//       GET_USER_BY_DOCUMENT,
//       variables
//     );

//     assert.equal(getUserByDocument.name, name);
//   }
// );

// Scenario: Add training plan to employee
// Given(
//   'an employee {string} with the document {string} exists',
//   async (name, document) => {
//     const variables = {
//       document,
//     };
//     const { getUserByDocument } = await request(
//       endpoint,
//       GET_USER_BY_DOCUMENT,
//       variables
//     );

//     assert.equal(getUserByDocument.name, name);
//   }
// );

// When(
//   'he adds a training plan named {string} with description {string} and courses {string}, {string}, {string}',
//   async (name, description, course1, course2, course3) => {
//     const variables = {
//       data: {
//         name,
//         description,
//       },
//     };
//     await request(endpoint, CREATE_TRAINING, variables);

//     const course1Variables = {
//       data: {
//         name: course1,
//         link: 'testlink.com',
//         duration: 4,
//       },
//     };
//     const course2Variables = {
//       data: {
//         name: course2,
//         link: 'testlink.com',
//         duration: 4,
//       },
//     };
//     const course3Variables = {
//       data: {
//         name: course3,
//         link: 'testlink.com',
//         duration: 4,
//       },
//     };
//     const { createCourse: createCourse1 } = await request(
//       endpoint,
//       CREATE_COURSE,
//       course1Variables
//     );
//     const { createCourse: createCourse2 } = await request(
//       endpoint,
//       CREATE_COURSE,
//       course2Variables
//     );
//     const { createCourse: createCourse3 } = await request(
//       endpoint,
//       CREATE_COURSE,
//       course3Variables
//     );
//     assert.equal(createCourse1.name, course1);
//     assert.equal(createCourse2.name, course2);
//     assert.equal(createCourse3.name, course3);
//   }
// );

// When(
//   'he assigns the plan {string} to the employee with the document {string}',
//   async (planName, employeeDocument) => {
// const variables = {
//   document: employeeDocument,
// };

// const { getUserByDocument } = await request(
//   endpoint,
//   GET_USER_BY_DOCUMENT,
//   variables
// );

// const variablesTraining = {
//   name: planName,
// };

// const { getTrainingByName } = await request(
//   endpoint,
//   GET_TRAINING_BY_NAME,
//   variablesTraining
// );

// const mutationVariables = {
//   addTrainingsToUserId: getUserByDocument.id,
//   trainingsIds: [getTrainingByName.id],
// };

// await request(endpoint, ADD_TRAINING_TO_USER, mutationVariables);
//   }
// );

// Then(
//   'the training plan {string} should be assigned to the employee with the document {string} successfully',
//   async (planName, employeeDocument) => {
//     // Code to verify that the training plan was assigned successfully
//     const variablesTraining = {
//       name: planName,
//     };

//     const { getTrainingByName } = await request(
//       endpoint,
//       GET_TRAINING_BY_NAME,
//       variablesTraining
//     );

//     const variablesTrainingById = {
//       getTrainingId: getTrainingByName.id,
//     };

//     const { getTraining } = await request(
//       endpoint,
//       GET_TRAINING_BY_ID,
//       variablesTrainingById
//     );

//     const usersAssignedToTraining = getTraining.users;

//     assert.ok(
//       usersAssignedToTraining.some(user => user.document === employeeDocument)
//     );
//     assert.ok(
//       !usersAssignedToTraining.some(user => user.document !== employeeDocument)
//     );
//   }
// );

// Scenario: Register completed course
// Given(
//   'the user with the email {string} has the training plan {string} assigned',
//   async (employeeEmail, planName) => {
//     const variables = {
//       email: employeeEmail,
//     };

//     const { getUserByEmail } = await request(
//       endpoint,
//       GET_USER_BY_EMAIL,
//       variables
//     );

//     const variablesTraining = {
//       name: planName,
//     };

//     const { getTrainingByName } = await request(
//       endpoint,
//       GET_TRAINING_BY_NAME,
//       variablesTraining
//     );

//     assert.ok(
//       getTrainingByName.users.some(user => user.email === employeeEmail)
//     );
//   }
// );

// When(
//   'the user with the email {string} registers a completed course named {string}',
//   async (employeeEmail, courseName) => {
//     const variables = {
//       email: employeeEmail,
//     };
//     const { getUserByEmail } = await request(
//       endpoint,
//       GET_USER_BY_EMAIL,
//       variables
//     );
//     const variablesTraining = {
//       name: courseName,
//     };
//     const { getCourseByName } = await request(
//       endpoint,
//       GET_COURSE_BY_NAME,
//       variablesTraining
//     );
//     const variablesCourseState = {
//       data: {
//         certificate_link: 'testlink.com',
//         certificated: true,
//         course_id: getCourseByName.id,
//         is_completed: true,
//         user_id: getUserByEmail.id,
//       },
//     };
//     const { createCourseState } = await request(
//       endpoint,
//       CREATE_COURSE_STATE,
//       variablesCourseState
//     );
//   }
// );

// Then(
//   'the course {string} assigned to the user with the email {string} should be marked as completed successfully',
//   async (courseName, employeeEmail) => {
// const variables = {
//   email: employeeEmail,
// };

// const { getUserByEmail } = await request(
//   endpoint,
//   GET_USER_BY_EMAIL,
//   variables
// );

//     assert.ok(
//       getUserByEmail.course_states.some(
//         courseState =>
//           courseState.course.name === courseName && courseState.is_completed
//       )
//     );
//   }
// );

// Scenario: Add a comment to a training plan
When(
  'the user with the email {string} adds the comment {string} to the training plan {string}',
  async (employeeEmail, comment, planName) => {
    const variablesUser = {
      email: employeeEmail,
    };

    const { getUserByEmail } = await request(
      endpoint,
      GET_USER_BY_EMAIL,
      variablesUser
    );

    const variablesTraining = {
      name: planName,
    };

    const { getTrainingByName } = await request(
      endpoint,
      GET_TRAINING_BY_NAME,
      variablesTraining
    );

    const variables = {
      data: {
        text: comment,
        training_id: getTrainingByName.id,
        user_id: getUserByEmail.id,
      },
    };

    await request(endpoint, CREATE_COMMENT, variables);
  }
);

Then(
  'the comment {string} added by the user with the email {string} to the training plan {string} should be added successfully',
  async (comment, employeeEmail, planName) => {
    const variablesTraining = {
      name: planName,
    };

    const { getTrainingByName } = await request(
      endpoint,
      GET_TRAINING_BY_NAME,
      variablesTraining
    );

    assert.ok(
      getTrainingByName.comments.some(
        commentInTraining =>
          commentInTraining.text === comment &&
          commentInTraining.user.email === employeeEmail
      )
    );
  }
);
