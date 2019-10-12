import * as React from 'react';
import {BrowserRouter as Router, Switch, Route} from 'react-router-dom';
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
