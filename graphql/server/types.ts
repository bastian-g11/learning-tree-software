import { DocumentNode } from 'graphql';
import { gql } from 'apollo-server-micro';

const CommonTypes = gql`
  scalar Date
`;

const GlobalTypes: DocumentNode[] = [CommonTypes];

export { GlobalTypes };
