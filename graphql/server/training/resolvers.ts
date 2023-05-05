import prisma from '@config/prisma';
import { Resolver } from 'types';

const TrainingResolvers: Resolver = {
  Training: {
    courses: async (parent, args) => {
      const courses = await prisma.course.findMany({
        where: {
          trainings: {
            some: {
              id: parent.id,
            },
          },
        },
      });
      return courses;
    },
    users: async (parent, args) => {
      const users = await prisma.user.findMany({
        where: {
          trainings: {
            some: {
              id: parent.id,
            },
          },
        },
      });
      return users;
    },
    comments: async (parent, args) => {
      const comments = await prisma.comment.findMany({
        where: {
          training_id: {
            equals: parent.id,
          },
        },
      });
      return comments;
    },
  },
  Query: {
    getTraining: async (parent, args) => {
      const training = await prisma.training.findUnique({
        where: {
          id: args.id,
        },
      });
      return training;
    },
    getTrainings: async () => {
      const trainings = await prisma.training.findMany();
      return trainings;
    },
  },
  Mutation: {
    createTraining: async (parent, args) => {
      const newTraining = await prisma.training.create({
        data: {
          ...args.data,
          courses: {
            connect: args.courses_ids.map((id: string) => ({ id })),
          },
        },
      });
      return newTraining;
    },
    updateTraining: async (parent, args) => {
      const updatedTraining = await prisma.training.update({
        where: {
          id: args.id,
        },
        data: {
          ...args.data,
        },
      });
      return updatedTraining;
    },
    deleteTraining: async (parent, args) => {
      const deletedTraining = await prisma.training.delete({
        where: {
          id: args.id,
        },
      });

      return deletedTraining;
    },
    addCoursesToTraining: async (parent, args) => {
      const updatedTraining = await prisma.training.update({
        where: {
          id: args.id,
        },
        data: {
          courses: {
            connect: args.courses_ids.map((id: string) => ({ id })),
          },
        },
      });

      return updatedTraining;
    },
    removeCoursesFromTraining: async (parent, args) => {
      const updatedTraining = await prisma.training.update({
        where: {
          id: args.id,
        },
        data: {
          courses: {
            disconnect: args.courses_ids.map((id: string) => ({ id })),
          },
        },
      });

      return updatedTraining;
    },
  },
};

export { TrainingResolvers };
