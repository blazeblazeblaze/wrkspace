import React from 'react'
import PropTypes from 'prop-types'

import SidebarHeader from './SidebarHeader'
import SidebarContent from './SidebarContent'
import TodoList from '../containers/TodoList'

const Sidebar = ({isVisible, onSidebarToggle}) => {
  return (
    <div className={`sidebar ${isVisible === true ? 'visible' : ''}`}>
      <div className="sidebar-container card col-md-3">
        <SidebarHeader
          title="Tasks"
          onClose={onSidebarToggle} />
        <SidebarContent>
          <TodoList />
        </SidebarContent>
      </div>
    </div>
  )
}

Sidebar.propTypes = {
  onSidebarToggle: PropTypes.func.isRequired,
  isVisible: PropTypes.bool
};

Sidebar.defaultProps = {
  isVisible: false
};

export default Sidebar;
