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

_manuallyTriggeringEvents = false

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

  componentDidUpdate: (prevProps, prevState) ->
    if @state.warn and not prevState.warn
      node = @refs.input.refs.input.getDOMNode()
      _manuallyTriggeringEvents = true
      node.blur()
      node.focus()
      _manuallyTriggeringEvents = false

  # -------
  # ACTIONS
  # -------

  handleChange: (event) ->
    value = event.target.value
    if @props.errors(value)
      @setState
        warn: true
        lastBadValue: value
    else
      @setState
        warn: false
      @props.success value

  handle_blur: (event) ->
    unless _manuallyTriggeringEvents
      @setState
        warn: false

  # -------
  # HELPERS
  # -------

  inputStyle: ->
    'warning' if @state.warn

  # ------
  # RENDER
  # ------

  render: ->
    <OverlayTrigger
      onBlur  = { @handle_blur }
      overlay = {
        if @state.warn
          <Popover title={ "You tried to enter: #{@state.lastBadValue}" }>
            { @props.errors @state.lastBadValue }
          </Popover>
        else
          <span></span>
      }
      trigger   = 'focus'
      placement = 'top'
    >
      <Input
        onChange = { @handleChange }
        bsStyle  = { @inputStyle() }
        ref      = 'input'
        {... @props }
      />
    </OverlayTrigger>