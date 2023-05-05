import prisma from '@config/prisma';
import { Resolver } from 'types';

const PositionResolvers: Resolver = {
  Position: {
    users: async (parent, args) => {
      const users = await prisma.user.findMany({
        where: {
          position_id: {
            equals: parent.id,
          },
        },
      });
      return users;
    },
  },
  Query: {
    getPosition: async (parent, args) => {
      const position = await prisma.position.findUnique({
        where: {
          id: args.id,
        },
      });
      return position;
    },
    getPositions: async () => {
      const positions = await prisma.position.findMany();
      return positions;
    },
  },
  Mutation: {
    createPosition: async (parent, args) => {
      const newPosition = await prisma.position.create({
        data: {
          ...args.data,
        },
      });
      return newPosition;
    },
    updatePosition: async (parent, args) => {
      const updatedPosition = await prisma.position.update({
        where: {
          id: args.id,
        },
        data: {
          ...args.data,
        },
      });
      return updatedPosition;
    },
    deletePosition: async (parent, args) => {
      const deletedPosition = await prisma.position.delete({
        where: {
          id: args.id,
        },
      });

      return deletedPosition;
    },
  },
};

export { PositionResolvers };
