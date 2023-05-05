import { CommentTypes } from '@graphql/server/comment/types';
import { CourseStateTypes } from '@graphql/server/courseState/types';
import { CourseTypes } from '@graphql/server/course/types';
import { DocumentNode } from 'graphql';
import { gql } from 'apollo-server-micro';
import { LikeTypes } from '@graphql/server/like/types';
import { NoteTypes } from '@graphql/server/note/types';
import { PositionTypes } from '@graphql/server/position/types';
import { TrainingTypes } from '@graphql/server/training/types';
import { UserTypes } from '@graphql/server/user/types';
import { UserTypeTypes } from '@graphql/server/userType/types';

const CommonTypes = gql`
  scalar Date
`;

const GlobalTypes: DocumentNode[] = [
  CommentTypes,
  CommonTypes,
  CourseStateTypes,
  CourseTypes,
  LikeTypes,
  NoteTypes,
  PositionTypes,
  TrainingTypes,
  UserTypes,
  UserTypeTypes,
];

export { GlobalTypes };
