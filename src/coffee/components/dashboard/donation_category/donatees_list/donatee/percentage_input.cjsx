# -------
# IMPORTS
# -------

# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'
Radium        = require 'radium'

# Bootstrap
Input = require 'react-bootstrap/lib/Input'

# Components
RemoveDonateeButton = require './remove_donatee_button'

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

  handle_change: (event) ->
    value = event.target.value
    unless value > @props.max or not /^\d{0,3}$/.test(value)
      @getModel().set
        percent: value

  # ------
  # RENDER
  # ------

  render: ->
    <Input
      onChange    = { @handle_change         }
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

# ------
# STYLES
# ------

styles =

  input:
    width: 45