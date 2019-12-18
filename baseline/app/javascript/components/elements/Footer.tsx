import * as React from 'react';

export const Footer = ({}) => (
  <React.Fragment>
    <p style={{textAlign: 'center'}}>
      Copyright &copy; {new Date().getFullYear()} {process.env.APPLICATION_TITLE}
    </p>
  </React.Fragment>
);
