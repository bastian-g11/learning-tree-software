import prisma from '@config/prisma';
import { Resolver } from 'types';

const NoteResolvers: Resolver = {
  Note: {
    user: async (parent, args) => {
      const user = await prisma.user.findUnique({
        where: {
          id: parent.user_id,
        },
      });
      return user;
    },
    course: async (parent, args) => {
      const course = await prisma.course.findUnique({
        where: {
          id: parent.course_id,
        },
      });
      return course;
    },
    likes: async (parent, args) => {
      const likes = await prisma.like.findMany({
        where: {
          note_id: {
            equals: parent.id,
          },
        },
      });
      return likes;
    },
  },

  Query: {
    getNote: async (parent, args) => {
      const note = await prisma.note.findUnique({
        where: {
          id: args.id,
        },
      });
      return note;
    },
    getNotes: async (parent, args) => {
      const notes = await prisma.note.findMany();
      return notes;
    },
  },
  Mutation: {
    createNote: async (parent, args) => {
      const newNote = await prisma.note.create({
        data: {
          ...args.data,
        },
      });
      return newNote;
    },
    updateNote: async (parent, args) => {
      const updatedNote = await prisma.note.update({
        where: {
          id: args.id,
        },
        data: {
          ...args.data,
        },
      });
      return updatedNote;
    },
    deleteNote: async (parent, args) => {
      const deletedNote = await prisma.note.delete({
        where: {
          id: args.id,
        },
      });
      return deletedNote;
    },
  },
};
export { NoteResolvers };
