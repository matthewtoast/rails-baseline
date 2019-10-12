import * as React from 'react';
import {HomePage} from './pages/HomePage';

export class Main extends React.Component<{}, {}> {
  render () {
    return (
      <Router>
        <Switch>
          <Route exact path='/' render={() => <HomePage />} />
        </Switch>
      </Router>
    );
  }
}
