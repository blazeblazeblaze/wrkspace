import { connect } from 'react-redux'
import { toggleSidebar } from '../actions'
import Sidebar from '../components/Sidebar'


const mapDispatchToProps = (dispatch) => ({
  onSidebarToggle: () => {
    dispatch(toggleSidebar())
  }
})

const mapStateToProps = (state) => ({
  isVisible: state.sidebar.isVisible
})

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Sidebar)
