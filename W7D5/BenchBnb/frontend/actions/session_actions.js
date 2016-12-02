import * as Util from '../util/session_api_util';

export const RECEIVE_CURRENT_USER = "RECEIVE_CURRENT_USER";
export const RECEIVE_ERRORS = "RECEIVE_ERRORS";

export const receiveCurrentUser = (session) => ({
  type: RECEIVE_CURRENT_USER,
  session: session
});

export const receiveErrors = (errors) => ({
  type: RECEIVE_ERRORS,
  errors: errors
});

export function login(user) {
  return dispatch => {
    return Util.login(user).then(
      curUser => dispatch(receiveCurrentUser(user)),
      errors => dispatch(receiveErrors())
    );
  };
}

export function logout() {
  return dispatch => {
    return Util.logout().then(
      () => dispatch(receiveCurrentUser(null)),
      errors => dispatch(receiveErrors())
    );
  };
}


export function signup(user) {
  return dispatch => {
    return Util.signup(user).then(
      curUser => dispatch(receiveCurrentUser(user)),
      errors => dispatch(receiveErrors())
    );
  };
}
