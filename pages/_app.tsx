import { AppProps } from 'next/app';
import Head from 'next/head';
import useApolloClient from 'hooks/useApolloClient';
import { ApolloProvider } from '@apollo/client';
import { SessionProvider } from 'next-auth/react';
import 'styles/globals.css';

const MyApp = ({
  Component,
  pageProps: { session, ...pageProps },
}: AppProps) => {
  const { client } = useApolloClient();
  return (
    <>
      <Head>
        <title>Page Name</title>
        <meta name='description' content='content' />
        <link rel='icon' href='/favicon.ico' />
      </Head>
      <SessionProvider session={session}>
        <ApolloProvider client={client}>
          <Component {...pageProps} />
        </ApolloProvider>
      </SessionProvider>
    </>
  );
};

export default MyApp;
