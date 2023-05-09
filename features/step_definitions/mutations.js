const CREATE_USER = `mutation CreateUser($data: UserCreateInput, $roleId: String) {
  createUser(data: $data, role_id: $roleId) {
    email
    name
    position {
      name
    }
    document
  }
}`;

const CREATE_TRAINING = `mutation CreateTraining($data: TrainingCreateInput) {
  createTraining(data: $data) {
    id
  }
}`;

const CREATE_COURSE = `mutation CreateCourse($data: CourseCreateInput) {
  createCourse(data: $data) {
    name
  }
}`;

const ADD_TRAINING_TO_USER = `mutation AddTrainingsToUser($addTrainingsToUserId: String, $trainingsIds: [String]) {
  addTrainingsToUser(id: $addTrainingsToUserId, trainings_ids: $trainingsIds) {
    id
  }
}`;

module.exports = {
  CREATE_USER,
  CREATE_TRAINING,
  CREATE_COURSE,
  ADD_TRAINING_TO_USER,
};
