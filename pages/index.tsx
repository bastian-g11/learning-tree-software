import MyComponent from '@components/MyComponent';
import { NextPage } from 'next/types';

const Home: NextPage = () => (
  <>
    <div className='text-indigo-500'>
      NextJS Boilerplate with Tailwind and GraphQL
    </div>
    <MyComponent />
  </>
);

export default Home;
