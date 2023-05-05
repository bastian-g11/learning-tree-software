import { Resolver } from 'types';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

const CourseResolvers: Resolver = {
  Course: {
    notes: async (parent, args) => {
      const notes = await prisma.note.findMany({
        where: {
          course_id: {
            equals: parent.id,
          },
        },
      });
      return notes;
    },
    trainings: async (parent, args) => {
      const trainings = await prisma.training.findMany({
        where: {
          courses: {
            some: {
              id: parent.id,
            },
          },
        },
      });
      return trainings;
    },
    course_states: async (parent, args) => {
      const courseStates = await prisma.courseState.findMany({
        where: {
          course_id: {
            equals: parent.id,
          },
        },
      });
      return courseStates;
    },
  },
  Query: {
    getCourse: async (parent, args) => {
      const course = await prisma.course.findUnique({
        where: {
          id: args.id,
        },
      });
      return course;
    },
    getCourses: async (parent, args) => {
      const courses = await prisma.course.findMany();
      return courses;
    },
  },
  Mutation: {
    createCourse: async (parent, args) => {
      const newCourse = await prisma.course.create({
        data: {
          ...args.data,
          trainings: {
            connect: args.trainings_ids.map((id: String) => ({ id })),
          },
        },
      });
      return newCourse;
    },
    updateCourse: async (parent, args) => {
      const updatedCourse = await prisma.course.update({
        where: { id: args.id },
        data: { ...args.data },
      });
      return updatedCourse;
    },
    deleteCourse: async (parent, args) => {
      const deletedCourse = await prisma.course.delete({
        where: {
          id: args.id,
        },
      });
      return deletedCourse;
    },
    addTrainingsToCourse: async (parent, args) => {
      const updatedCourse = await prisma.course.update({
        where: { id: args.id },
        data: {
          trainings: {
            connect: args.trainings_ids.map((id: String) => ({ id })),
          },
        },
      });
      return updatedCourse;
    },
    removeTrainingsFromCourse: async (parent, args) => {
      const updatedCourse = await prisma.course.update({
        where: { id: args.id },
        data: {
          trainings: {
            disconnect: args.trainings_ids.map((id: String) => ({ id })),
          },
        },
      });
      return updatedCourse;
    },
  },
};

export { CourseResolvers };
