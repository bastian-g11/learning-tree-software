import { Resolver } from 'types';
import { UserTypeResolvers } from '@graphql/server/userType/resolvers';
import { UserResolvers } from '@graphql/server/user/resolvers';
import { LikeResolvers } from '@graphql/server/like/resolvers';
import { PositionResolvers } from '@graphql/server/position/resolvers';
import { CourseStateResolvers } from '@graphql/server/courseState/resolvers';

const GlobalResolvers: Resolver[] = [
  UserTypeResolvers,
  UserResolvers,
  LikeResolvers,
  PositionResolvers,
  CourseStateResolvers,
];

export { GlobalResolvers };
