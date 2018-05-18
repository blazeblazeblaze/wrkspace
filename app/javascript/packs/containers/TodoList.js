import React from 'react'
import { connect } from 'react-redux'

import {
  createTodo,
  completeTodo,
  deleteTodo,
  renameTodo,
  getTodos,
} from '../actions'

import { getTodosInProgress } from '../reducers'
import TodoList from '../components/TodoList'

const mapStateToProps = (state) => ({
  items: getTodosInProgress(state),
  isSyncing: state.sidebar.isSyncing
})

const TodoWrapper = class extends React.Component {
  componentDidMount() {
    this.props.getTodos()
  }

  render() {
    const { ...rest } = this.props

    return(
      <TodoList {...rest} />
    );
  }
}

export default connect(
  mapStateToProps, {
    onAddNewClick: createTodo,
    onCompleteClick: completeTodo,
    onDeleteClick: deleteTodo,
    onTitleSave: renameTodo,
    getTodos: getTodos
  }
)(TodoWrapper)
