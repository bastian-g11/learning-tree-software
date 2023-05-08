import { gql } from 'apollo-server-micro';

const UserTypes = gql`
  type User {
    id: ID
    email: String
    image: String
    emailVerified: Date
    name: String
    phone: String
    address: String
    photo_link: String
    position: Position
    course_states: [CourseState]
    notes: [Note]
    comments: [Comment]
    likes: [Like]
    trainings: [Training]
  }

  input UserCreateInput {
    name: String
    email: String
    image: String
    emailVerified: Date
    phone: String
    address: String
    photo_link: String
    position_id: String
    role_id: String
  }

  input UserUpdateInput {
    name: String
    email: String
    image: String
    emailVerified: Date
    phone: String
    address: String
    photo_link: String
    position_id: String
    role_id: String
  }

  type Query {
    getUser(id: String): User
    getUsers: [User]
  }
  type Mutation {
    createUser(data: UserCreateInput): User
    updateUser(id: String, data: UserUpdateInput): User
    deleteUser(id: String): User
    addTrainingsToUser(id: String, trainings_ids: [String]): User
    removeTrainingsFromUser(id: String, trainings_ids: [String]): User
  }
`;

export { UserTypes };
