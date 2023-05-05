import prisma from '@config/prisma';
import { Resolver } from 'types';

const CommentResolvers: Resolver = {
  Comment: {
    user: async (parent, args) => {
      const user = await prisma.user.findUnique({
        where: {
          id: parent.user_id,
        },
      });
      return user;
    },

    training: async (parent, args) => {
      const training = await prisma.training.findUnique({
        where: {
          id: parent.training_id,
        },
      });
      return training;
    },
  },
  Query: {
    getComment: async (parent, args) => {
      const comment = await prisma.comment.findUnique({
        where: {
          id: args.id,
        },
      });
      return comment;
    },
    getComments: async (parent, args) => {
      const comments = await prisma.comment.findMany();
      return comments;
    },
  },
  Mutation: {
    createComment: async (parent, args) => {
      const newComment = await prisma.comment.create({
        data: {
          ...args.data,
        },
      });
      return newComment;
    },
    updateComment: async (parent, args) => {
      const updatedComment = await prisma.comment.update({
        where: {
          id: args.id,
        },
        data: {
          ...args.data,
        },
      });
      return updatedComment;
    },
    deleteComment: async (parent, args) => {
      const deletedComment = await prisma.comment.delete({
        where: {
          id: args.id,
        },
      });
      return deletedComment;
    },
  },
};
export { CommentResolvers };
