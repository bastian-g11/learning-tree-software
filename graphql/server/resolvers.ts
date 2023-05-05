import { Resolver } from 'types';
import { UserTypeResolvers } from '@graphql/server/userType/resolvers';
import { UserResolvers } from '@graphql/server/user/resolvers';
import { LikeResolvers } from '@graphql/server/like/resolvers';

const GlobalResolvers: Resolver[] = [
  UserTypeResolvers,
  UserResolvers,
  LikeResolvers,
];

export { GlobalResolvers };
