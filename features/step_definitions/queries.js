const GET_USER_BY_EMAIL = `query GetUserByEmail($email: String) {
  getUserByEmail(email: $email) {
    roles {
      name
    }
  }
}`;

const GET_TRAINING_BY_NAME = `query GetTrainingByName($name: String) {
  getTrainingByName(name: $name) {
    id
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

module.exports = {
  GET_POSITION_BY_NAME,
  GET_USER_BY_EMAIL,
  GET_TRAINING_BY_NAME,
  GET_TRAINING_BY_ID,
  GET_USER_BY_DOCUMENT,
};
