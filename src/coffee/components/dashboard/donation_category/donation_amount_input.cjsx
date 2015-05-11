# -------
# IMPORTS
# -------

# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'

# Components
InputWithValidations = require 'components/shared/input_with_validations'

# ---------
# COMPONENT
# ---------

module.exports = React.createClass
  displayName: 'DonationAmountInput'

  mixins: [ BackboneMixin ]

  # -------
  # ACTIONS
  # -------

  success_callback: (value) ->
    @getModel().set
      donation: value

  # ------
  # RENDER
  # ------

  render: ->
    donation = @getModel().get 'donation'
    donation = '' if donation == 0

    <InputWithValidations
      errors      = { @validation_errors }
      callback    = { @success_callback  }
      value       = { donation           }
      standalone  = true
      addonBefore = '$'
      bsSize      = 'medium'
      type        = 'text'
      placeholder = '0'
    />

  # -------
  # HELPERS
  # -------

  validation_errors: (value) ->
    if value
      if isNaN value
        return "That's not a valid, positive number."
      if value < 0
        return "Donation must be larger than 0."
      unless /^[\d,]*\.?\d{0,2}$/.test value
        return "That's not a proper format for US Dollars."
    false