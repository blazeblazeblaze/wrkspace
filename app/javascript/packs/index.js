import React from 'react'
import ReactDOM from 'react-dom'
import Root from './components/Root'

import configureStore from './configureStore';

const store = configureStore()

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Root store={store} />,
    document.getElementById('todolist')
  )
})
