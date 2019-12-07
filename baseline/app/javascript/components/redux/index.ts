import {connect as componentConnector} from 'react-redux';
import * as creators from './creators';

export const connect = (
  Component: any, // TODO(matthew)
  mapStateToProps?: any, // TODO(matthew)
  mapDispatchToProps?: any, // TODO(matthew)
  mergeProps?: any, // TODO(matthew)
  options?: any, // TODO(matthew)
) => {
  return componentConnector(
    mapStateToProps,
    (dispatch) => {
      if (mapDispatchToProps) {
        return mapDispatchToProps(dispatch, creators);
      }
      return {};
    },
    mergeProps,
    options,
  )(Component);
};
