# Vendor
React = require 'react'

module.exports = React.createClass
  displayName: 'RemoveDonateeButton'

  render: ->
    <button
      onClick   = { @props.remove_callback }
      className = 'btn btn-xs btn-danger'
    >
      x
    </button>