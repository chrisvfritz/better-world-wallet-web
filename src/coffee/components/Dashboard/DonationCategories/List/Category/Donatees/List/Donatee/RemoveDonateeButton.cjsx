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

  handleClick: ->
    @getCollection().remove @getModel()

  # ------
  # RENDER
  # ------

  render: ->
    <button
      onClick   = { @handleClick }
      className = 'btn btn-xs btn-danger'
    >
      x
    </button>