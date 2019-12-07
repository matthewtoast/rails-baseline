import * as pm from 'path-match';
import {User} from '../models/User';
import {getParams} from '../utils/Route';

const matcher = pm()('/:resource?/:id?/:action?');

export const updateLocation = (state, {location, history}) => {
  const params = getParams(location);
  const {per, page} = params;
  return {
    ...state,
    location,
    history,
    params,
    per: Math.min(per || 25, 25) as number,
    page: page || 1 as number,
    route: matcher(location.pathname),
  };
};

export const reloadCurrentUser = (state) => state;

export const requestCurrentUser = (state) => ({
  ...state,
  isCurrentUserReloading: true,
});

export const receiveCurrentUser = (state, {user}) => ({
  ...state,
  user: user && User.hydrate(user),
  isCurrentUserReloading: false,
});

export const receiveError = (state, action) => ({
  ...state,
  errors: [action.error].concat(state.errors).slice(0, 5),
});
