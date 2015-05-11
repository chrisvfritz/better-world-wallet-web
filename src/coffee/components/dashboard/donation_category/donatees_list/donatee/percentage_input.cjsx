# -------
# IMPORTS
# -------

# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'
Radium        = require 'radium'

# Components
InputWithValidations = require 'components/shared/input_with_validations'
RemoveDonateeButton  = require './remove_donatee_button'

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
    default_percent: React.PropTypes.number.isRequired

  # -------
  # ACTIONS
  # -------

  success_callback: (value) ->
    @getModel().set
      percent: value

  # ------
  # RENDER
  # ------

  render: ->

    <InputWithValidations
      errors      = { @validation_errors     }
      callback    = { @success_callback      }
      value       = { @formatted_percent()   }
      placeholder = { @props.default_percent }
      style       = { styles.input           }
      type        = 'text'
      addonAfter  = '%'
      bsSize      = 'small'
      standalone  = true
    />

  # -------
  # HELPERS
  # -------

  formatted_percent: ->
    @getModel().get('percent') || ''

  validation_errors: (value) ->
    value_int = parseInt value
    donatee = @getModel()
    if donatee.max_percent() is 0
      return "This is the last empty percentage, so you actually can't enter anything here. Otherwise, you could end up donating less than 100% of the amount you want to."
    if value_int > donatee.max_percent()
      return "Uh oh. That would exceed 100%!"
    if value_int is 0 or not /^\d{0,3}$/.test(value)
      return "That's not a valid character in a positive integer."
    false

# ------
# STYLES
# ------

styles =

  input:
    width: 46