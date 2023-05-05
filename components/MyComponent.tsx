import React from 'react';
import { signIn } from 'next-auth/react';
import { useQuery } from '@apollo/client';
import { GET_MOCK_MODEL } from '@graphql/client/queries/getMockModel';
import Loading from '@components/Loading';
import { MockModel } from 'types';

const MyComponent = () => {
  // const { data, loading } = useQuery(GET_MOCK_MODEL);

  // if (loading) return <Loading />;
  return (
    <div className='p-10'>
      <div>
        <button type='button' onClick={() => signIn('auth0')}>
          Iniciar sesion
        </button>
      </div>
      <h1>Data fetched with GraphQL</h1>
      {/* <div className='flex gap-3'>
        {data.mockModelGetter.map((el: MockModel) => (
          <div
            className='bg-gray-200 p-4 flex flex-col items-center rounded-lg shadow-lg'
            key={el.id}
          >
            <span>{el.id}</span>
            <span>{el.name}</span>
            <span>{el.description}</span>
          </div>
        ))}
      </div> */}
    </div>
  );
};

export default MyComponent;
