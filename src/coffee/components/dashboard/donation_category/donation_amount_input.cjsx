# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'

# Bootstrap
Input = require 'react-bootstrap/lib/Input'

module.exports = React.createClass
  displayName: 'DonationAmountInput'

  mixins: [ BackboneMixin ]

  handle_change: (event) ->
    value = event.target.value
    unless value and isNaN(value) or parseInt(value) < 0 or !/^[\d,]*\.?\d{0,2}$/.test(value)
      @getModel().set
        donation: value

  render: ->
    donation = @getModel().get('donation')
    donation = '' if donation == 0

    <span className='form-inline'>
      <Input
        onChange    = { @handle_change }
        value       = { donation       }
        addonBefore = '$'
        bsSize      = 'medium'
        type        = 'text'
        placeholder = '0'
      />
    </span>