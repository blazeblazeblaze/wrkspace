import React from 'react'
import PropTypes from 'prop-types'

const TodoItem = class extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      title: props.todo.title || ''
    }
    this.onTitleChange = this.onTitleChange.bind(this);
    // this.handleBlur = this.handleBlur.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  onTitleChange(event) {
    this.setState({ title: event.target.value })
  }

  // handleBlur = e => {
  //   console.log('HANDLING BLUR...')
  //   const { todo, onTitleSave } = this.props;
  //   onTitleSave({
  //     id: todo.id,
  //     title: e.target.value
  //   })
  // }

  handleSubmit = e => {
    const text = e.target.value.trim()
    const { todo, onTitleSave } = this.props;

    if (e.which === 13) {
      onTitleSave(
        todo.id,
        e.target.value
      )
    }
  }

  render() {
    const { todo, onDelete, onComplete } = this.props;

    return (
      <label className="custom-control custom-checkbox">
        <input
          type="checkbox"
          className="custom-control-input"
          onChange={() => onComplete(todo.id, todo.completed_at) }
          checked={!!todo.completed_at} />

        <span className="custom-control-label">
          <div className="row gutters-xs">
            <div className="col">
              <input
                type="text"
                className="form-control form-control-sm"
                placeholder="Task title"
                onChange={this.onTitleChange}
                value={this.state.title}
                disabled={!!todo.completed_at}
                onKeyDown={this.handleSubmit}
              />
            </div>
            <span className="col-auto">
              <a href="#" className="icon" onClick={(e) => {e.preventDefault(); onDelete(todo.id) }}>
                <i className="far fa-trash-alt"></i>
              </a>
            </span>
          </div>
        </span>
      </label>
    )
  }
};

TodoItem.propTypes = {
  onComplete: PropTypes.func.isRequired,
  onDelete: PropTypes.func.isRequired,
  onTitleSave: PropTypes.func.isRequired,
  todo: PropTypes.object.isRequired
};

export default TodoItem;
