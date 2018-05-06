import React from 'react'
import PropTypes from 'prop-types'

const SidebarHeader = ({title, onClose}) => {
  return(
    <div className="card-header">
      <h3 className="card-title">{title}</h3>
      <div className="card-options">
        <a href="#" onClick={onClose} className="card-options-remove">
          <i className="far fa-times-circle"></i>
        </a>
      </div>
    </div>
  )
}

SidebarHeader.propTypes = {
  onClose: PropTypes.func.isRequired,
  title: PropTypes.string
};

export default SidebarHeader;
