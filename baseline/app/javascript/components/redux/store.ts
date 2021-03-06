import {createStore, combineReducers, applyMiddleware} from 'redux';
import thunkMiddleware from 'redux-thunk';
import * as reducers from './reducers';

export const store = createStore(
  combineReducers({
    main: (
      state = {
        user: null,
        isCurrentUserReloading: false,
        modal: null,
        location: null,
        history: null,
        params: {},
        per: 25,
        page: 1,
        route: null,
        errors: [],
      },
      action,
    ) => {
      return (reducers[action.type])
        ? reducers[action.type](state, action)
        : state;
    },
  }),
  applyMiddleware(
    thunkMiddleware,
  ),
);
