# -------
# IMPORTS
# -------

# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'
StyleSheet    = require 'react-style'
Accounting    = require 'accounting'
_compact      = require 'lodash/array/compact'

# Components
RemoveDonateeButton = require './donatee/remove_donatee_button'
PercentageInput     = require './donatee/percentage_input'

# ---------
# COMPONENT
# ---------

module.exports = React.createClass
  displayName: 'Donatee'

  mixins: [ BackboneMixin ]

  # ----------
  # VALIDATION
  # ----------

  propTypes:
    donation: React.PropTypes.number.isRequired

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
    <tr styles={[ styles.row.base, @state.was_just_added and styles.row.active ]}>
      <td styles={ styles.cell }>
        <a href="https://www.youtube.com/channel/#{ @getModel().get 'id' }" target='_blank'>
          { @getModel().get 'title' }
        </a>
      </td>
      <td styles={ styles.cell }>
        <PercentageInput
          default_percent = { @visible_default_percent() }
          max             = { @max()                     }
        />
      </td>
      <td styles={ styles.cell }>
        { Accounting.formatMoney @money() }
      </td>
      <td styles={ styles.cell }>
        <RemoveDonateeButton
          remove_callback = { @remove_donatee }
        />
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

  money: ->
    @props.donation * @percent_to_use_for_money()

  max: ->
    100 - (@defined_percent_sum() - @props.model.attributes.percent)

  percent_to_use_for_money: ->
    percent = @getModel().get('percent')
    if percent then percent / 100 else @real_default_percent()

  visible_default_percent: ->
    Math.floor( @real_default_percent() * 1000 ) / 10

  real_default_percent: ->
    percent = (1 - @defined_percent_sum() / 100) / (@getCollection().models.length - @defined_percents().length)
    # http://stackoverflow.com/questions/1458633/how-to-deal-with-floating-point-number-precision-in-javascript#answer-3644302
    parseFloat percent.toPrecision(12)

  defined_percent_sum: ->
    if @defined_percents().length > 0 then @defined_percents().reduce((a,b) -> a + b) else 0

  defined_percents: ->
    _compact @getCollection().map( (donatee) -> parseInt donatee.get('percent') )

# ------
# STYLES
# ------

styles = StyleSheet.create

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
