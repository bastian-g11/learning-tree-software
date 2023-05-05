import { PrismaAdapter } from '@next-auth/prisma-adapter';
import prisma from '@config/prisma';
import NextAuth, { NextAuthOptions } from 'next-auth';
import Auth0Provider from 'next-auth/providers/auth0';
import { NextApiRequest, NextApiResponse } from 'next';

const options: NextAuthOptions = {
  adapter: PrismaAdapter(prisma),
  providers: [
    Auth0Provider({
      clientId: process.env.AUTH0_CLIENT_ID ?? '',
      clientSecret: process.env.AUTH0_CLIENT_SECRET ?? '',
      issuer: process.env.AUTH0_ISSUER,
    }),
  ],
};

export default function auth(req: NextApiRequest, res: NextApiResponse) {
  return NextAuth(req, res, options);
}
