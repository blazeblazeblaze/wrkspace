import React from 'react'
import TodoItem from './TodoItem'

const TodoList = (props) => {
  const {
    items,
    isSyncing,
    onAddNewClick,
    onCompleteClick,
    onDeleteClick,
    onTitleSave
  } = props

  return (
    <div className={`dimmer ${isSyncing ? "active" : ""}`}>
      <div className="loader"></div>
      <div className="dimmer-content">
        <div className="selectgroup selectgroup-pills">
          <label className="selectgroup-item">
            <a
              href="#"
              className="btn btn-pill btn-secondary"
              onClick={(e) => {e.preventDefault(); onAddNewClick()}}>
              New task
            </a>
          </label>
        </div>
        <div className="custom-controls-stacked">
          {items.map((todo) =>
            <TodoItem
              key={todo.id}
              todo={todo}
              onTitleSave={onTitleSave}
              onDelete={onDeleteClick}
              onComplete={onCompleteClick}
            />
          )}
        </div>
      </div>
    </div>
  )
}

export default TodoList;
