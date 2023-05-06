import { matchRoles } from '@utils/matchRoles';
import { GetServerSidePropsContext, NextPage } from 'next/types';

export async function getServerSideProps(context: GetServerSidePropsContext) {
  const { roleCheck, isPublic, name } = await matchRoles({ context });

  if (isPublic) {
    return {
      props: {
        name,
      },
    };
  }

  if (!roleCheck) {
    return {
      redirect: {
        destination: '/unauthorized',
        permanent: false,
      },
    };
  }

  return {
    props: {
      name,
    },
  };
}

const Admin: NextPage = () => (
  <div className='text-indigo-500'>
    This a Admin only page. You can only see this if you are logged in and have
    the role of Admin.
  </div>
);

export default Admin;
