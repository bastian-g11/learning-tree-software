import { Resolver } from 'types';
import { UserTypeResolvers } from '@graphql/server/userType/resolvers';

const GlobalResolvers: Resolver[] = [UserTypeResolvers];

export { GlobalResolvers };
