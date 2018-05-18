import { combineReducers } from 'redux';

import {
  ADD_TODO_SUCCESS,
  FETCH_TODOS_SUCCESS,
  UPDATE_TODO_SUCCESS,
  DELETE_TODO_SUCCESS
} from '../actions'

const byId = (state = {}, action) => {
  switch (action.type) {
    case FETCH_TODOS_SUCCESS:
    case UPDATE_TODO_SUCCESS:
    case ADD_TODO_SUCCESS:
      return {
        ...state,
        ...action.response.entities.todos
      }
    default:
      return state;
  }
};

const allIds = (state = [], action) => {
  switch (action.type) {
    case ADD_TODO_SUCCESS:
      return [...state, action.response.result];
    case DELETE_TODO_SUCCESS:
      return state.filter(id => id !== action.response.result)
    case FETCH_TODOS_SUCCESS:
      return action.response.result
    default:
      return state;
  }
};

export const todos = combineReducers({
  byId,
  allIds,
});

const getAllTodos = (state) =>
  state.allIds.map(id => state.byId[id]);

export const getInProgress = (state) => {
  const allTodos = getAllTodos(state);
  return allTodos; //.filter((todo) => !todo.completed_at )
}
