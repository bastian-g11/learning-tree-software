import MyComponent from '@components/MyComponent';
import { matchRoles } from '@utils/matchRoles';
import { getSession, useSession } from 'next-auth/react';
import { GetServerSidePropsContext, NextPage } from 'next/types';

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
