import { gql } from 'apollo-server-micro';

const UserTypes = gql`
  type User {
    id: ID
    email: String
    image: String
    emailVerified: Date
    name: String
    document: String
    phone: String
    address: String
    photo_link: String
    position: Position
    roles: [Role]
    course_states: [CourseState]
    notes: [Note]
    comments: [Comment]
    likes: [Like]
    trainings: [Training]
  }

  input UserCreateInput {
    name: String
    document: String
    email: String
    image: String
    emailVerified: Date
    phone: String
    address: String
    photo_link: String
    position_id: String
  }

  input UserUpdateInput {
    name: String
    document: String
    email: String
    image: String
    emailVerified: Date
    phone: String
    address: String
    photo_link: String
    position_id: String
  }

  type Query {
    getUser(id: String): User
    getUserByEmail(email: String): User
    getUserByDocument(document: String): User
    getUsers: [User]
  }
  type Mutation {
    createUser(data: UserCreateInput, role_id: String): User
    updateUser(id: String, data: UserUpdateInput): User
    deleteUser(id: String): User
    addTrainingsToUser(id: String, trainings_ids: [String]): User
    removeTrainingsFromUser(id: String, trainings_ids: [String]): User
  }
`;

export { UserTypes };
