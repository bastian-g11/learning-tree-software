import prisma from '@config/prisma';
import { Resolver } from 'types';

const LikeResolvers: Resolver = {
  Like: {
    user: async (parent, args) => {
      const user = await prisma.user.findUnique({
        where: {
          id: parent.user_id,
        },
      });
      return user;
    },

    note: async (parent, args) => {
      const note = await prisma.note.findUnique({
        where: {
          id: parent.note_id,
        },
      });
      return note;
    },
  },
  Query: {
    getLike: async (parent, args) => {
      const like = await prisma.like.findUnique({
        where: {
          id: args.id,
        },
      });
      return like;
    },
    getLikes: async (parent, args) => {
      const likes = await prisma.like.findMany();
      return likes;
    },
  },
  Mutation: {
    createLike: async (parent, args) => {
      const newLike = await prisma.like.create({
        data: {
          ...args.data,
        },
      });
      return newLike;
    },
    deleteLike: async (parent, args) => {
      const deletedLike = await prisma.like.delete({
        where: {
          id: args.id,
        },
      });
      return deletedLike;
    },
  },
};
export { LikeResolvers };
