import prisma from '@config/prisma';
import { Resolver } from 'types';

const UserResolvers: Resolver = {
  User: {
    position: async (parent, args) => {
      const position = await prisma.position.findUnique({
        where: {
          id: parent.position_id,
        },
      });
      return position;
    },
    roles: async (parent, args) => {
      const roles = await prisma.role.findMany({
        where: {
          users: {
            some: {
              id: parent.id,
            },
          },
        },
      });
      return roles;
    },
    course_states: async (parent, args) => {
      const courseStates = await prisma.courseState.findMany({
        where: {
          user_id: {
            equals: parent.id,
          },
        },
      });
      return courseStates;
    },
    notes: async (parent, args) => {
      const notes = await prisma.note.findMany({
        where: {
          user_id: {
            equals: parent.id,
          },
        },
      });
      return notes;
    },
    comments: async (parent, args) => {
      const comments = await prisma.comment.findMany({
        where: {
          user_id: {
            equals: parent.id,
          },
        },
      });
      return comments;
    },
    likes: async (parent, args) => {
      const likes = await prisma.like.findMany({
        where: {
          user_id: {
            equals: parent.id,
          },
        },
      });
      return likes;
    },
    trainings: async (parent, args) => {
      const trainings = await prisma.training.findMany({
        where: {
          users: {
            some: {
              id: parent.id,
            },
          },
        },
      });
      return trainings;
    },
  },
  Query: {
    getUser: async (parent, args) => {
      const user = await prisma.user.findUnique({
        where: {
          id: args.id,
        },
      });
      return user;
    },
    getUserByEmail: async (parent, args) => {
      const user = await prisma.user.findUnique({
        where: {
          email: args.email,
        },
      });
      return user;
    },
    getUserByDocument: async (parent, args) => {
      const user = await prisma.user.findUnique({
        where: {
          document: args.document,
        },
      });
      return user;
    },
    getUsers: async (parent, args) => {
      const users = await prisma.user.findMany();
      return users;
    },
  },
  Mutation: {
    createUser: async (parent, args) => {
      const data = {
        ...args.data,
      };
      if (args.role_id) {
        data.roles = {
          connect: [{ id: args.role_id }],
        };
      }
      const newUser = await prisma.user.create({
        data,
      });
      return newUser;
    },
    updateUser: async (parent, args) => {
      const updatedUser = await prisma.user.update({
        where: {
          id: args.id,
        },
        data: {
          ...args.data,
        },
      });
      return updatedUser;
    },
    deleteUser: async (parent, args) => {
      const deletedUser = await prisma.user.delete({
        where: {
          id: args.id,
        },
      });
      return deletedUser;
    },
    addTrainingsToUser: async (parent, args) => {
      const updatedUser = await prisma.user.update({
        where: {
          id: args.id,
        },
        data: {
          trainings: {
            connect: args.trainings_ids.map((id: string) => ({ id })),
          },
        },
      });
      return updatedUser;
    },
    removeTrainingsFromUser: async (parent, args) => {
      const updatedUser = await prisma.user.update({
        where: {
          id: args.id,
        },
        data: {
          trainings: {
            disconnect: args.trainings_ids.map((id: string) => ({ id })),
          },
        },
      });
      return updatedUser;
    },
  },
};

export { UserResolvers };
