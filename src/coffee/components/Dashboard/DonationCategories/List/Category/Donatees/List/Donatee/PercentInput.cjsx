# -------
# IMPORTS
# -------

# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'
Radium        = require 'radium'

# Components
InputWithValidations = require 'components/shared/InputWithValidations'

# ---------
# COMPONENT
# ---------

module.exports = React.createClass Radium.wrap
  displayName: 'PercentageInput'

  mixins: [ BackboneMixin ]

  # ----------
  # VALIDATION
  # ----------

  propTypes:
    defaultPercent: React.PropTypes.number.isRequired

  validationErrors: (value) ->
    valueInt = parseInt value
    donatee = @getModel()
    if donatee.maxPercent() is 0
      return "This is the last empty percentage, so you actually can't enter anything here. Otherwise, you could end up donating less than 100% of the amount you want to."
    if valueInt > donatee.maxPercent()
      return "Uh oh. That would exceed 100%!"
    if valueInt is 0 or not /^\d{0,3}$/.test(value)
      return "That's not a valid character in a positive integer."
    false

  # -------
  # ACTIONS
  # -------

  successCallback: (value) ->
    @getModel().set
      percent: value

  # -------
  # HELPERS
  # -------

  formattedPercent: ->
    @getModel().get('percent') || ''

  # ------
  # RENDER
  # ------

  render: ->
    <InputWithValidations
      errors      = { @validationErrors     }
      success     = { @successCallback      }
      value       = { @formattedPercent()   }
      placeholder = { @props.defaultPercent }
      style       = { styles.input.base     }
      type        = 'text'
      addonAfter  = '%'
      bsSize      = 'small'
      standalone  = true
    />

# ------
# STYLES
# ------

styles =

  input:

    base:
      width: 46