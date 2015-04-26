# Vendor
React      = require 'react'
Reflux     = require 'reflux'
_          = require 'lodash'
Accounting = require 'accounting'

# Stores
DonateeStore  = require 'stores/donatee'
DonationStore = require 'stores/donation'

# Components
RemoveDonateeButton = require './donatee/remove_donatee_button'
PercentageInput     = require './donatee/percentage_input'

module.exports = React.createClass
  displayName: 'Donatee'

  mixins: [
    Reflux.connect DonationStore, 'donation_amount'
    Reflux.connect DonateeStore,  'donatees'
  ]

  propTypes:
    id: React.PropTypes.string
    title: React.PropTypes.string
    percent: React.PropTypes.string

  componentDidMount: ->
    @highlight()

  render: ->
    <tr>
      <td width='100%'>
        { @props.title }
      </td>
      <td>
        <PercentageInput
          donatee_id      = { @props.id                  }
          default_percent = { @visible_default_percent() }
          percent         = { @props.percent             }
          max             = { @max()                     }
        />
      </td>
      <td>
        { Accounting.formatMoney @money() }
      </td>
      <td>
        <RemoveDonateeButton donatee_id={ @props.id }/>
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
    @state.donation_amount * @percent_to_use_for_money()

  max: ->
    100 - (@defined_percent_sum() - @props.percent)

  percent_to_use_for_money: ->
   if @props.percent then @props.percent / 100 else @real_default_percent()

  visible_default_percent: ->
    Math.floor( @real_default_percent() * 100 )

  real_default_percent: ->
    (1 - @defined_percent_sum() / 100) / (@state.donatees.length - @defined_percents().length)

  defined_percent_sum: ->
    if @defined_percents().length > 0 then @defined_percents().reduce((a,b) -> a + b) else 0

  defined_percents: ->
    _.compact @state.donatees.map( (d) -> parseInt(d.percent) )