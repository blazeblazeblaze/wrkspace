import React from 'react'

const SidebarContent = ({children}) => {
  return (
    <div className="card-body cd-panel__content tasks-wrapper">
      <div className="row">
        <div className='col-lg-12'>
          {children}
        </div>
      </div>
    </div>
  )
}

export default SidebarContent;
