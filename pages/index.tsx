import MyComponent from '@components/MyComponent';
import { getSession, useSession } from 'next-auth/react';
import { GetServerSidePropsContext, NextPage } from 'next/types';

export async function getServerSideProps(context: GetServerSidePropsContext) {
  // if (!session?.user['http://your-namespace/roles'].includes('admin')) {
  //   return { props: { error: 'Forbidden' } }
  // }
}

const Home: NextPage = () => {
  return (
    <>
      <div className='text-indigo-500'>
        NextJS Boilerplate with Tailwind and GraphQL
      </div>
      <MyComponent />
    </>
  );
};

export default Home;
