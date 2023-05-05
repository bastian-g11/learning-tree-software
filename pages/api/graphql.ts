import { ApolloServer } from 'apollo-server-micro';
import NextCors from 'nextjs-cors';
import { NextApiRequest, NextApiResponse } from 'next';
import { GlobalTypes } from '@graphql/server/types';
import { GlobalResolvers } from '@graphql/server/resolvers';
import micro_cors from 'micro-cors';

const cors = micro_cors({
  origin: 'https://studio.apollographql.com',
  allowMethods: ['GET', 'POST'],
  allowHeaders: [
    'Access-Control-Allow-Credentials',
    'true',
    'Content-Type',
    'Access-Control-Allow-Origin',
    'Access-Control-Allow-Headers',
  ],
});

export const config = {
  api: {
    bodyParser: false,
  },
};

const Server = async (req: NextApiRequest, res: NextApiResponse) => {
  const apolloServer = new ApolloServer({
    cache: 'bounded',
    context: () => {},
    typeDefs: [...GlobalTypes],
    resolvers: [...GlobalResolvers],
    introspection: true,
  });

  await apolloServer.start();

  return apolloServer.createHandler({
    path: '/api/graphql',
  })(req, res);
};

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {
  await NextCors(req, res, {
    // Options
    methods: ['POST', 'OPTIONS', 'GET', 'HEAD'],
    origin: '*',
    optionsSuccessStatus: 204,
  });

  await Server(req, res);
}
