# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'
Accounting    = require 'accounting'
_compact      = require 'lodash/array/compact'

# Components
RemoveDonateeButton = require './donatee/remove_donatee_button'
PercentageInput     = require './donatee/percentage_input'

module.exports = React.createClass
  displayName: 'Donatee'

  mixins: [ BackboneMixin ]

  componentDidMount: ->
    @highlight()

  render: ->
    <tr>
      <td width='100%'>
        <a href="https://www.youtube.com/channel/#{ @getModel().get 'id' }" target='_blank'>
          { @getModel().get 'title' }
        </a>
      </td>
      <td>
        <PercentageInput
          default_percent = { @visible_default_percent() }
          max             = { @max()                     }
        />
      </td>
      <td>
        { Accounting.formatMoney @money() }
      </td>
      <td>
        <RemoveDonateeButton
          remove_callback = { @remove_donatee }
        />
      </td>
    </tr>

  highlight: ->
    node = React.findDOMNode(@)
    setTimeout ->
      node.classList.add 'just_added'
      setTimeout ->
        node.classList.remove 'just_added'
      , 2000
    , 1

  money: ->
    @props.donation * @percent_to_use_for_money()

  max: ->
    100 - (@defined_percent_sum() - @props.model.attributes.percent)

  percent_to_use_for_money: ->
    if @props.model.attributes.percent then @props.model.attributes.percent / 100 else @real_default_percent()

  visible_default_percent: ->
    Math.floor( @real_default_percent() * 1000 ) / 10

  real_default_percent: ->
    percent = (1 - @defined_percent_sum() / 100) / (@getCollection().models.length - @defined_percents().length)
    # http://stackoverflow.com/questions/1458633/how-to-deal-with-floating-point-number-precision-in-javascript#answer-3644302
    parseFloat percent.toPrecision(12)

  defined_percent_sum: ->
    if @defined_percents().length > 0 then @defined_percents().reduce((a,b) -> a + b) else 0

  defined_percents: ->
    _compact @getCollection().models.map( (d) -> parseInt(d.attributes.percent) )