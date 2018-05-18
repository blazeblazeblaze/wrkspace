import {
  TOGGLE_SIDEBAR,
  FETCH_TODOS_SUCCESS,
  UPDATE_TODO_SUCCESS,
  DELETE_TODO_SUCCESS,
  TODO_REQUESTED
} from '../actions'

const initSidebarState = {
  isVisible: true,
  isSyncing: false
};

export const sidebar = (state = initSidebarState, action) => {
  switch (action.type) {

    case TODO_REQUESTED:
      return {...state, isSyncing: true}
    case FETCH_TODOS_SUCCESS:
    case UPDATE_TODO_SUCCESS:
    case DELETE_TODO_SUCCESS:
      return {...state, isSyncing: false}
    case TOGGLE_SIDEBAR:
      return {...state, isVisible: !state.isVisible}
    default:
      return state
  }
}
