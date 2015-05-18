# -------
# IMPORTS
# -------

# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'
Radium        = require 'radium'
Accounting    = require 'accounting'
TweenState    = require 'react-tween-state'

# Components
RemoveDonateeButton = require './Donatee/RemoveDonateeButton'
PercentageInput     = require './Donatee/PercentInput'

# ---------
# COMPONENT
# ---------

module.exports = React.createClass Radium.wrap
  displayName: 'Donatee'

  mixins: [ BackboneMixin, TweenState.Mixin ]

  # ---------
  # LIFECYCLE
  # ---------

  getInitialState: ->
    wasJustAdded: false
    donation: @props.donation * @getModel().decimalPercent()

  componentDidMount: ->
    @highlight()

  componentWillReceiveProps: (nextProps) ->
    @tweenState 'donation',
      duration: 200
      endValue: nextProps.donation * @getModel().decimalPercent()

  # -------
  # HELPERS
  # -------

  highlight: ->
    setTimeout =>
      @setState
        wasJustAdded: true
      setTimeout =>
        @setState
          wasJustAdded: false
      , 2000
    , 1

  formattedDefaultPercent: ->
    Math.floor( @getModel().defaultPercent() * 1000 ) / 10

  # ------
  # RENDER
  # ------

  render: ->
    <tr style={[ styles.row.base, @state.wasJustAdded and styles.row.active ]}>
      <td style={ styles.cell.base }>
        <a href="https://www.youtube.com/channel/#{ @getModel().get 'id' }" target='_blank'>
          { @getModel().get 'title' }
        </a>
      </td>
      <td style={ styles.cell.base }>
        <PercentageInput defaultPercent={ @formattedDefaultPercent() }/>
      </td>
      <td style={ styles.cell.base }>
        { Accounting.formatMoney @getTweeningValue('donation') }
      </td>
      <td style={ styles.cell.base }>
        <RemoveDonateeButton/>
      </td>
    </tr>

# ------
# STYLES
# ------

styles =

  row:

    base:
      borderLeft: '3px solid white'
      transition: 'border-left 2s'

    active:
      borderLeft: '3px solid #ADEAC7'
      transition: 'border-left 1s'

  cell:

    base:
      verticalAlign: 'middle'
      width: '100%'