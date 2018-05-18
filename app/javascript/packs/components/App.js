import React from 'react'
import ReactDOM from 'react-dom'
import Sidebar from '../containers/Sidebar'
import SidebarToggle from '../containers/SidebarToggle'

const App = () => {
  return (
    <div>
      <SidebarToggle />
      <Sidebar />
    </div>
  )
}

export default App
