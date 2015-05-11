# -------
# IMPORTS
# -------

# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'
StyleSheet    = require 'react-style'

# Bootstrap
Input = require 'react-bootstrap/lib/Input'

# Components
RemoveDonateeButton = require './remove_donatee_button'

# ---------
# COMPONENT
# ---------

module.exports = React.createClass
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
      styles      = { styles.input           }
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

styles = StyleSheet.create

  input:
    width: 45