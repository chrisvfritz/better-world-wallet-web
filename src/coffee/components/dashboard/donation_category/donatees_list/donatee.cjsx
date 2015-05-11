# -------
# IMPORTS
# -------

# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'
Radium        = require 'radium'
Accounting    = require 'accounting'

# Components
RemoveDonateeButton = require './donatee/remove_donatee_button'
PercentageInput     = require './donatee/percentage_input'

# ---------
# COMPONENT
# ---------

module.exports = React.createClass Radium.wrap
  displayName: 'Donatee'

  mixins: [ BackboneMixin ]

  # ---------
  # LIFECYCLE
  # ---------

  getInitialState: ->
    was_just_added: false

  componentDidMount: ->
    @highlight()

  # ------
  # RENDER
  # ------

  render: ->
    <tr style={[ styles.row.base, @state.was_just_added and styles.row.active ]}>
      <td style={ styles.cell }>
        <a href="https://www.youtube.com/channel/#{ @getModel().get 'id' }" target='_blank'>
          { @getModel().get 'title' }
        </a>
      </td>
      <td style={ styles.cell }>
        <PercentageInput default_percent={ @formatted_default_percent() }/>
      </td>
      <td style={ styles.cell }>
        { @formatted_donation() }
      </td>
      <td style={ styles.cell }>
        <RemoveDonateeButton remove_callback={ @remove_donatee }/>
      </td>
    </tr>

  # -------
  # HELPERS
  # -------

  highlight: ->
    setTimeout =>
      @setState
        was_just_added: true
      setTimeout =>
        @setState
          was_just_added: false
      , 2000
    , 1

  formatted_default_percent: ->
    Math.floor( @getModel().default_percent() * 1000 ) / 10

  formatted_donation: ->
    Accounting.formatMoney( @props.donation * @getModel().decimal_percent() )

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
    verticalAlign: 'middle'
    width: '100%'
