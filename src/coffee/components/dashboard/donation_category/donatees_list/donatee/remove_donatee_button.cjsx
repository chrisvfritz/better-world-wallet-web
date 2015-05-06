# -------
# IMPORTS
# -------

# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'

# ---------
# COMPONENT
# ---------

module.exports = React.createClass
  displayName: 'RemoveDonateeButton'

  mixins: [ BackboneMixin ]

  # -------
  # ACTIONS
  # -------

  handle_click: ->
    @getModel().destroy()

  # ------
  # RENDER
  # ------

  render: ->
    <button
      onClick   = { @handle_click }
      className = 'btn btn-xs btn-danger'
    >
      x
    </button>