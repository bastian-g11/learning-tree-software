import prisma from '@config/prisma';
import { Resolver } from 'types';

const RoleResolvers: Resolver = {
  Query: {
    getRole: async (parent, args) => {
      const role = await prisma.role.findUnique({
        where: {
          id: args.id,
        },
      });
      return role;
    },
    getRoles: async (parent, args) => {
      const roles = await prisma.role.findMany();
      return roles;
    },
  },
  Mutation: {
    createRole: async (parent, args) => {
      const newRole = await prisma.role.create({
        data: {
          name: args.data.name,
        },
      });
      return newRole;
    },
    updateRole: async (parent, args) => {
      const updatedRole = await prisma.role.update({
        where: {
          id: args.id,
        },
        data: {
          ...args.data,
        },
      });
      return updatedRole;
    },
    deleteRole: async (parent, args) => {
      const deletedRole = await prisma.role.delete({
        where: {
          id: args.id,
        },
      });
      return deletedRole;
    },
  },
};

export { RoleResolvers };
