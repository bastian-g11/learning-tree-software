import { Resolver } from 'types';
import { UserTypeResolvers } from '@graphql/server/userType/resolvers';
import { UserResolvers } from '@graphql/server/user/resolvers';
import { LikeResolvers } from '@graphql/server/like/resolvers';
import { PositionResolvers } from '@graphql/server/position/resolvers';
import { CourseStateResolvers } from '@graphql/server/courseState/resolvers';
import { NoteResolvers } from '@graphql/server/note/resolvers';
import { CommentResolvers } from '@graphql/server/comment/resolvers';
import { TrainingResolvers } from '@graphql/server/training/resolvers';
import { CourseResolvers } from '@graphql/server/course/resolvers';

const GlobalResolvers: Resolver[] = [
  UserTypeResolvers,
  UserResolvers,
  LikeResolvers,
  PositionResolvers,
  CourseStateResolvers,
  NoteResolvers,
  CommentResolvers,
  TrainingResolvers,
  CourseResolvers,
];

export { GlobalResolvers };
