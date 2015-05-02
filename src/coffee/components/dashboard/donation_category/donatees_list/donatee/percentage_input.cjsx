# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'

# Bootstrap
Input = require 'react-bootstrap/lib/Input'

# Components
RemoveDonateeButton = require './remove_donatee_button'

module.exports = React.createClass
  displayName: 'PercentageInput'

  mixins: [ BackboneMixin ]

  handle_change: (event) ->
    value = event.target.value
    unless value > @props.max or !/^\d{0,3}$/.test(value)
      @getModel().set
        percent: value

  render: ->
    <Input
      onChange    = { @handle_change         }
      value       = { @props.percent         }
      placeholder = { @props.default_percent }
      className   = 'donation_perentage'
      type        = 'text'
      addonAfter  = '%'
      bsSize      = 'small'
    />