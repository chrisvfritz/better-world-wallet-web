# -------
# IMPORTS
# -------

# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'

# Components
InputWithValidations = require 'components/shared/InputWithValidations'

# ---------
# COMPONENT
# ---------

module.exports = React.createClass
  displayName: 'DonationAmountInput'

  mixins: [ BackboneMixin ]

  # -----------
  # VALIDATIONS
  # -----------

  validationErrors: (value) ->
    if value
      if isNaN value
        return "That's not a valid, positive number."
      if value < 0
        return "Donation must be larger than 0."
      unless /^[\d,]*\.?\d{0,2}$/.test value
        return "That's not a proper format for US Dollars."
    false

  # -------
  # ACTIONS
  # -------

  successCallback: (value) ->
    @getModel().set
      donation: value

  # ------
  # RENDER
  # ------

  render: ->
    donation = @getModel().get 'donation'
    donation = '' if donation is 0

    <InputWithValidations
      errors      = { @validationErrors }
      success     = { @successCallback  }
      value       = { donation          }
      standalone  = true
      addonBefore = '$'
      bsSize      = 'medium'
      type        = 'text'
      placeholder = '0'
    />