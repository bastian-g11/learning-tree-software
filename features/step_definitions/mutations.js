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

const CREATE_COURSE_STATE = `mutation Mutation($data: CourseStateCreateInput) {
  createCourseState(data: $data) {
    id
    is_completed
    course {
      name
    }
  }
}`;

const CREATE_COMMENT = `mutation Mutation($data: CommentCreateInput) {
  createComment(data: $data) {
    id
    text
  }
}`;

const CREATE_NOTE = `mutation CreateNote($data: NoteCreateInput) {
  createNote(data: $data) {
    id
    text
  }
}`;

module.exports = {
  CREATE_USER,
  CREATE_TRAINING,
  CREATE_COURSE,
  ADD_TRAINING_TO_USER,
  CREATE_COURSE_STATE,
  CREATE_COMMENT,
  CREATE_NOTE,
};
