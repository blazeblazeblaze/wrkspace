import React from 'react'
import PropTypes from 'prop-types'

const TodoItem = class extends React.Component {
  constructor(props) {
    super(props);

    this.onCompletedChange = this.onCompletedChange.bind(this);
    this.onTitleChange = this.onTitleChange.bind(this);
    this.onDelete = this.onDelete.bind(this);
    this.onTitleSave = this.onTitleSave.bind(this);
    this.handleEnterKeyPress = this.handleEnterKeyPress.bind(this);
  }

  handleEnterKeyPress(event) {
    if(event.which === 13){
      event.target.blur();
    }
  }

  onCompletedChange(event) {
    let { todo, onComplete } = this.props;
    onComplete(todo);
  }

  onTitleChange(event) {
    let { todo, onTitleChange } = this.props;
    onTitleChange(todo.id, event.target.value);
  }

  onDelete(event) {
    event.preventDefault();

    let { todo, onDelete } = this.props;
    onDelete(todo);
  }

  onTitleSave() {
    let { todo, onTitleSave } = this.props;
    onTitleSave(todo);
  }

  render() {
    const { isVisible, todo } = this.props;

    return (
      <label className="custom-control custom-checkbox">
        <input
          type="checkbox"
          className="custom-control-input"
          onChange={this.onCompletedChange}
          checked={!!todo.completed_at} />

        <span className="custom-control-label">
          <div className="row gutters-xs">
            <div className="col">
              <input
                type="text"
                className="form-control form-control-sm"
                placeholder="Task title"
                value={todo.title}
                disabled={!!todo.completed_at}
                onChange={this.onTitleChange}
                onBlur={this.onTitleSave}
                onKeyPress={this.handleEnterKeyPress}
              />
            </div>
            <span className="col-auto">
              <a href="#" className="icon" onClick={this.onDelete}>
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
  onTitleChange: PropTypes.func.isRequired,
  onDelete: PropTypes.func.isRequired,
  onTitleSave: PropTypes.func.isRequired,
  todo: PropTypes.object.isRequired
};

export default TodoItem;
