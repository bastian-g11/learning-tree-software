import { gql } from 'apollo-server-micro';

const RoleTypes = gql`
  type Role {
    id: ID
    name: String
  }

  input RoleCreateInput {
    name: String!
  }

  input RoleUpdateInput {
    name: String!
  }

  type Query {
    getRole(id: String): Role
    getRoles: [Role]
  }
  type Mutation {
    createRole(data: RoleCreateInput): Role
    updateRole(id: String, data: RoleUpdateInput): Role
    deleteRole(id: String): Role
  }
`;

export { RoleTypes };
