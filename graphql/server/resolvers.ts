import { CommentResolvers } from '@graphql/server/comment/resolvers';
import { CourseResolvers } from '@graphql/server/course/resolvers';
import { CourseStateResolvers } from '@graphql/server/courseState/resolvers';
import { LikeResolvers } from '@graphql/server/like/resolvers';
import { NoteResolvers } from '@graphql/server/note/resolvers';
import { PositionResolvers } from '@graphql/server/position/resolvers';
import { Resolver } from 'types';
import { TrainingResolvers } from '@graphql/server/training/resolvers';
import { UserResolvers } from '@graphql/server/user/resolvers';
import { UserTypeResolvers } from '@graphql/server/userType/resolvers';

const GlobalResolvers: Resolver[] = [
  CommentResolvers,
  CourseResolvers,
  CourseStateResolvers,
  LikeResolvers,
  NoteResolvers,
  PositionResolvers,
  TrainingResolvers,
  UserResolvers,
  UserTypeResolvers,
];

export { GlobalResolvers };
