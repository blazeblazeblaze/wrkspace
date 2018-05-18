import TaskApi from '../libs/TaskApi'

import { normalize } from 'normalizr';
import * as schema from './schema';

export const TOGGLE_SIDEBAR = 'TOGGLE_SIDEBAR'

export const TODO_REQUESTED = 'TODO_REQUESTED'
export const FETCH_TODOS_SUCCESS = 'FETCH_TODOS_SUCCESS'
export const ADD_TODO_SUCCESS = 'ADD_TODO_SUCCESS'
export const UPDATE_TODO_SUCCESS = 'UPDATE_TODO_SUCCESS'
export const DELETE_TODO_SUCCESS = 'DELETE_TODO_SUCCESS'

export const getTodos = () => (dispatch) => {
  dispatch({
    type: TODO_REQUESTED
  })

  const api = new TaskApi();
  return api.fetchItems().then(response =>
    dispatch({
      type: FETCH_TODOS_SUCCESS,
      response: normalize(response, schema.arrayOfTodos)
    })
  );
}

export const createTodo = () => (dispatch) => {
  const api = new TaskApi();
  return api.createItem().then(response =>
    dispatch({
      type: ADD_TODO_SUCCESS,
      response: normalize(response, schema.todo)
    })
  );
}

export const completeTodo = (id, completed_at) => (dispatch) => {
  const api = new TaskApi();
  return api.updateItem({
    id,
    completed_at: (completed_at ? null : new Date())
  }).then(response =>
    dispatch({
      type: UPDATE_TODO_SUCCESS,
      response: normalize(response, schema.todo)
    })
  );
}

export const renameTodo = (id, title) => (dispatch) => {
  const api = new TaskApi();
  return api.updateItem({
    id,
    title
  }).then(response => {
    return dispatch({
      type: UPDATE_TODO_SUCCESS,
      response: normalize(response, schema.todo)
    })
  });
}

export const deleteTodo = (id) => (dispatch) => {
  const api = new TaskApi();
  return api.deleteItem(id).then(response =>
    dispatch({
      type: DELETE_TODO_SUCCESS,
      response: normalize(response, schema.todo)
    })
  );
}
