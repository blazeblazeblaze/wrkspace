import React from 'react'
import { connect } from 'react-redux'
import { toggleSidebar } from '../actions'

const mapDispatchToProps = (dispatch) => ({
  onSidebarToggle: () => {
    dispatch(toggleSidebar())
  }
})

const SidebarToggle = ({onSidebarToggle}) => {
  return (
    <button
      className='btn btn-sm btn-outline-primary'
      onClick={onSidebarToggle}>
      Tasks
    </button>
  )
}

export default connect(
  null,
  mapDispatchToProps
)(SidebarToggle)
