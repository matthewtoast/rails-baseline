import {get} from '../utils/XHR';

export const updateLocation = (location, history) => ({
  type: 'updateLocation',
  location,
  history,
});

export const reloadCurrentUser = () => {
  return (dispatch) => {
    dispatch(requestCurrentUser());
    return get('/account', (error, body) => {
      if (error) {
        dispatch(receiveError(error));
        dispatch(receiveCurrentUser(null));
        return;
      }
      dispatch(receiveCurrentUser(body.user));
    });
  };
};

export const requestCurrentUser = () => ({type: 'requestCurrentUser'});

export const receiveCurrentUser = (user) => ({type: 'receiveCurrentUser', user});

export const receiveError = (error) => ({type: 'receiveError', error});
