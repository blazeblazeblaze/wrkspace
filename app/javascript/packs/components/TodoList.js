import React from 'react'
import TodoItem from './TodoItem'
import TaskApi from '../libs/TaskApi'

const TodoList = class extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      items: [],
      isLoading: true
    };

    this.TaskApi = new TaskApi();
    this.handleAddNew = this.handleAddNew.bind(this);
    this.handleToggleComplete = this.handleToggleComplete.bind(this);
    this.handleChange = this.handleChange.bind(this);
    this.handleTitleChange = this.handleTitleChange.bind(this);
    this.handleDelete = this.handleDelete.bind(this);
  }

  componentDidMount() {
    this.handleFetchAll();
  }

  createItem(newItem) {
    this.setState((prevState, props) => {
      return {
        items: [...prevState.items, newItem],
        isLoading: false
      }
    })
  }

  deleteItem(removedItem) {
    this.setState((prevState, props) => {
      return {
        items: prevState.items.filter(item => item.id !== removedItem.id),
        isLoading: false
      }
    })
  }

  updateItem(updatedItem) {
    this.setState((prevState, props) => {
      return {
        items: prevState.items.map((item) => { return item.id !== updatedItem.id ? item : updatedItem }),
        isLoading: false
      }
    })
  }

  setItems(items) {
    this.setState((prevState, props) => {
      return {
        items: items,
        isLoading: false
      }
    })
  }

  handleFetchAll() {
    this.setState({...this.state, isLoading: true });

    this.TaskApi.fetchItems().then((data) => {this.setItems(data)}); //.catch(error => item);
  }

  handleAddNew(e) {
    e.preventDefault();

    this.setState({...this.state, isLoading: true });

    this.TaskApi.createItem().then((data) => {this.createItem(data)}); //.catch(error => item);
  }

  handleToggleComplete(itemToUpdate) {
    this.setState({...this.state, isLoading: true });

    this.TaskApi.updateItem({
      ...itemToUpdate,
      completed_at: itemToUpdate.completed_at ? null : new Date()
    }).then((data) => {this.updateItem(data)}); //.catch(error => item);
  }

  handleDelete(itemToDelete) {
    this.setState({...this.state, isLoading: true });

    this.TaskApi.deleteItem(
      itemToDelete
    ).then((data) => {this.deleteItem(data)}); //.catch(error => item);
  }

  handleChange(itemToSave) {
    this.setState({...this.state, isLoading: true });

    this.TaskApi.updateItem({
      ...itemToSave,
      title: itemToSave.title
    }).then((data) => {this.updateItem(data)}); //.catch(error => item);
  }

  handleTitleChange(itemId, value) {
    let newItems = this.state.items.map((item) => {
      if (item.id === itemId) {
        return {...item,
          title: value
        };
      }

      return item;
    });

    this.setState({...this.state, items: newItems});
  }

  render() {
    const { items, isLoading } = this.state;

    return (
      <div className={`dimmer ${isLoading ? "active" : ""}`}>
        <div className="loader"></div>
        <div className="dimmer-content">
          <div className="selectgroup selectgroup-pills">
            <label className="selectgroup-item">
              <a
                href="#"
                className="btn btn-pill btn-secondary"
                onClick={this.handleAddNew}>
                New task
              </a>
            </label>
          </div>
          <div className="custom-controls-stacked">
            {items.map((todo) => {
              return(
                <TodoItem
                  key={todo.id}
                  todo={todo}
                  onTitleSave={this.handleChange}
                  onTitleChange={this.handleTitleChange}
                  onComplete={this.handleToggleComplete}
                  onDelete={this.handleDelete}
                />
              );
            })}
          </div>
        </div>
      </div>
    )
  }
}

export default TodoList;
