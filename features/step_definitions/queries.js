const GET_USER_BY_EMAIL = `query GetUserByEmail($email: String) {
  getUserByEmail(email: $email) {
    id
    course_states {
      is_completed
      course {
        name
      }
    }
    roles {
      name
    }
  }
}`;

const GET_TRAINING_BY_NAME = `query GetTrainingByName($name: String) {
  getTrainingByName(name: $name) {
    id
    users {
      document
      name
      email
    }
    comments {
      id
      text
      user {
        email
      }
    }
  }
}`;

const GET_TRAINING_BY_ID = `query GetTraining($getTrainingId: String) {
  getTraining(id: $getTrainingId) {
    users {
      document
    }
  }
}`;

const GET_POSITION_BY_NAME = `query GetPositionByName($name: String) {
  getPositionByName(name: $name) {
    id
  }
}`;

const GET_USER_BY_DOCUMENT = `query GetUserByDocument($document: String) {
  getUserByDocument(document: $document) {
    id
    name
  }
}`;

const GET_COURSE = `query GetCourse($getCourseId: String) {
  getCourse(id: $getCourseId) {
    id
    name
    trainings {
      id
      name
    }
  }
}`;

const GET_COURSE_BY_NAME = `query GetCourseByName($name: String) {
  getCourseByName(name: $name) {
    id
    name
    trainings {
      id
      name
    }
    notes {
      text
      user {
        email
      }
    }
  }
}`;

const GET_ROLES = `query GetRoles {
  getRoles {
    id
    name
  }
}`;

module.exports = {
  GET_POSITION_BY_NAME,
  GET_USER_BY_EMAIL,
  GET_TRAINING_BY_NAME,
  GET_TRAINING_BY_ID,
  GET_USER_BY_DOCUMENT,
  GET_COURSE,
  GET_COURSE_BY_NAME,
  GET_ROLES,
};
