import { Resolver } from 'types';
import { UserTypeResolvers } from '@graphql/server/userType/resolvers';
import { UserResolvers } from '@graphql/server/user/resolvers';

const GlobalResolvers: Resolver[] = [
  UserTypeResolvers,
  UserResolvers
];

export { GlobalResolvers };
