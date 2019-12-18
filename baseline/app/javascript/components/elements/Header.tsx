import * as React from 'react';

export const Header = ({}) => (
  <React.Fragment>
    <h1 className='h1'>
      {process.env.APPLICATION_TITLE}
    </h1>
    <p className='tagline'>
      {process.env.APPLICATION_DESCRIPTION}
    </p>
  </React.Fragment>
);
