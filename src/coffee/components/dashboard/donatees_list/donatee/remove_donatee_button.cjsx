# Vendor
React = require 'react'

# Actions
DonateeActions = require 'actions/donatee'

module.exports = React.createClass
  displayName: 'RemoveDonateeButton'

  handle_click: ->
    DonateeActions.destroy @props.donatee_id

  render: ->
    <button
      onClick   = { @handle_click }
      className = 'btn btn-xs btn-danger'
    >
      x
    </button>