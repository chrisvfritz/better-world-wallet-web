# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'

module.exports = React.createClass
  displayName: 'RemoveDonateeButton'

  mixins: [ BackboneMixin ]

  handle_click: ->
    @getCollection().get(@getModel().cid).destroy()

  render: ->
    <button
      onClick   = { @handle_click }
      className = 'btn btn-xs btn-danger'
    >
      x
    </button>