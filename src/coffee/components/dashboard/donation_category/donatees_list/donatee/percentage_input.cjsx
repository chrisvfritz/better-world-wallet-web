# Vendor
React  = require 'react'
Reflux = require 'reflux'

# Bootstrap
Input = require 'react-bootstrap/lib/Input'

# Components
RemoveDonateeButton = require './remove_donatee_button'

module.exports = React.createClass
  displayName: 'PercentageInput'

  propTypes:
    percent: React.PropTypes.string

  getDefaultProps: ->
    percent: ''

  handle_change: (event) ->
    value = event.target.value
    unless value > @props.max
      @props.update_callback value

  render: ->
    <Input
      onChange    = { @handle_change         }
      value       = { @props.percent         }
      placeholder = { @props.default_percent }
      addonAfter  = '%'
      className   = 'donation_perentage'
      bsSize      = 'small'
      type        = 'text'
    />