import { combineReducers } from 'redux'
import { todos, getInProgress } from './todos'
import { sidebar } from './sidebar'

export default combineReducers({
  sidebar,
  todos
})

export const getTodosInProgress = (state) => {
  return getInProgress(state.todos)
}
