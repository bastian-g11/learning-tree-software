import { gql } from 'apollo-server-micro';

const TrainingTypes = gql`
  type Training {
    id: ID
    name: String
    description: String
    courses: [Course]
    users: [User]
    comments: [Comment]
  }

  input TrainingCreateInput {
    name: String!
    description: String!
  }

  input TrainingUpdateInput {
    name: String
    description: String
  }

  type Query {
    getTraining(id: String): Training
    getTrainings: [Training]
  }

  type Mutation {
    createTraining(data: TrainingCreateInput, courses_ids: [String]): Training
    updateTraining(id: String, data: TrainingUpdateInput): Training
    deleteTraining(id: String): Training
    addCoursesToTraining(id: String, courses_ids: [String]): Training
    removeCoursesFromTraining(id: String, courses_ids: [String]): Training
  }
`;

export { TrainingTypes };
