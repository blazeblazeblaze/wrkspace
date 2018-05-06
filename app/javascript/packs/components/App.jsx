import React from 'react'
import ReactDOM from 'react-dom'
import Sidebar from './Sidebar'


const App = class extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      showSidebar: false
    };

    this.handleToggleSidebar = this.handleToggleSidebar.bind(this);
  }

  handleToggleSidebar() {
    this.setState((prevState, props) => {
      return {
        showSidebar: !prevState.showSidebar
      }
    })
  }

  render() {
    const { showSidebar } = this.state;

    return (
      <div>
        <button
          className='btn btn-sm btn-outline-primary'
          onClick={this.handleToggleSidebar}>
          Tasks
        </button>
        {showSidebar &&
          <Sidebar onClose={this.handleToggleSidebar} isVisible={showSidebar} />}
      </div>
    );
  }
}

export default App;
