import * as React from 'react';
import {BrowserRouter as Router, Switch, Route, withRouter} from 'react-router-dom';
import {Provider} from 'react-redux';
import {connect} from './redux';
import {updateLocation} from './redux/creators';
import {store} from './redux/store';
import {HomePage} from './pages/HomePage';

export interface IInnerProps {
  location: any;
  history: any;
}

class Inner extends React.Component<IInnerProps, {}> {
  updateLocation = () => {
    const {location, history} = this.props;
    store.dispatch(updateLocation(location, history));
  }

  componentDidMount () {
    this.updateLocation();
  }

  componentDidUpdate () {
    this.updateLocation();
  }

  render () {
    return (
      <Switch>
        <Route exact path='/' component={HomePage} />
      </Switch>
    );
  }
}

const InnerWithRouterConnected = withRouter(connect(
  Inner,
));

const App = (props) => (
  <Router>
    <InnerWithRouterConnected {...props} />
  </Router>
);

export const Main = (props) => (
  <Provider store={store}>
    <App {...props} />
  </Provider>
);
