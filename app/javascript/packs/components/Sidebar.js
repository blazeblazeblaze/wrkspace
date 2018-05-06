import React from 'react'
import PropTypes from 'prop-types'

import SidebarHeader from './SidebarHeader'
import SidebarContent from './SidebarContent'
import TodoList from './TodoList'

const Sidebar = ({ onClose, isVisible }) => {
  return (
    <div className={`sidebar ${isVisible === true ? 'visible' : ''}`}>
      <div className="sidebar-container card col-md-3">
        <SidebarHeader title="Tasks" onClose={(e) => {e.preventDefault; onClose()} } />
        <SidebarContent>
          <TodoList />
        </SidebarContent>
      </div>
    </div>
  )
}

Sidebar.propTypes = {
  onClose: PropTypes.func.isRequired,
  isVisible: PropTypes.bool
};

Sidebar.defaultProps = {
  isVisible: false
};

export default Sidebar;
