import { DocumentNode } from 'graphql';
import { gql } from 'apollo-server-micro';
import { UserTypeTypes } from '@graphql/server/userType/types';
import { UserTypes } from '@graphql/server/user/types';
import { LikeTypes } from '@graphql/server/like/types';
import { PositionTypes } from '@graphql/server/position/types';
import { CourseStateTypes } from '@graphql/server/courseState/types';
import { NoteTypes } from '@graphql/server/note/types';
import { CommentTypes } from '@graphql/server/comment/types';
import { TrainingTypes } from '@graphql/server/training/types';
import { CourseTypes } from '@graphql/server/course/types';

const CommonTypes = gql`
  scalar Date
`;

const GlobalTypes: DocumentNode[] = [
  CommonTypes,
  UserTypeTypes,
  UserTypes,
  LikeTypes,
  PositionTypes,
  CourseStateTypes,
  NoteTypes,
  CommentTypes,
  TrainingTypes,
  CourseTypes,
];

export { GlobalTypes };
