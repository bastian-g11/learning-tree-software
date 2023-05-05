import { DocumentNode } from 'graphql';
import { gql } from 'apollo-server-micro';
import { UserTypeTypes } from '@graphql/server/userType/types';

const CommonTypes = gql`
  scalar Date
`;

const GlobalTypes: DocumentNode[] = [CommonTypes, UserTypeTypes];

export { GlobalTypes };
