# -------
# IMPORTS
# -------

# Vendor
React         = require 'react'

# Bootstrap
OverlayTrigger = require 'react-bootstrap/lib/OverlayTrigger'
Popover        = require 'react-bootstrap/lib/Popover'
Input          = require 'react-bootstrap/lib/Input'

# ---------
# COMPONENT
# ---------

_manually_triggering_events = false

module.exports = React.createClass #Radium.wrap
  displayName: 'InputWithValidations'

  # ----------
  # VALIDATION
  # ----------

  propTypes:
    errors:  React.PropTypes.func.isRequired
    success: React.PropTypes.func.isRequired

  # ---------
  # LIFECYCLE
  # ---------

  getInitialState: ->
    warn: false

  componentDidUpdate: (prev_props, prev_state) ->
    if @state.warn and not prev_state.warn
      node = @refs.input.refs.input.getDOMNode()
      _manually_triggering_events = true
      node.blur()
      node.focus()
      _manually_triggering_events = false

  # -------
  # ACTIONS
  # -------

  handle_change: (event) ->
    value = event.target.value
    if @props.errors(value)
      @setState
        warn: true
        last_bad_value: value
    else
      @setState
        warn: false
      @props.success value

  handle_blur: (event) ->
    unless _manually_triggering_events
      @setState
        warn: false

  # ------
  # RENDER
  # ------

  render: ->
    <OverlayTrigger
      onBlur  = { @handle_blur }
      overlay = {
        if @state.warn
          <Popover title={ "You tried to enter: #{@state.last_bad_value}" }>
            { @props.errors @state.last_bad_value }
          </Popover>
        else
          <span></span>
      }
      trigger   = 'focus'
      placement = 'top'
    >
      <Input
        onChange = { @handle_change }
        bsStyle  = { @input_style() }
        ref      = 'input'
        {... @props }
      />
    </OverlayTrigger>

  # -------
  # HELPERS
  # -------

  input_style: ->
    'warning' if @state.warn