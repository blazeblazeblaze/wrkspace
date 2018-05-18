import { createStore, applyMiddleware } from 'redux'
import thunk from 'redux-thunk'
import { createLogger } from 'redux-logger'

import rootReducer from './reducers'

const configureStore = () => {
  // const middlewares = [createLogger(), thunk];

  return createStore(
    rootReducer,
    applyMiddleware(thunk, createLogger())
  );
};

export default configureStore;
