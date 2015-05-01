# Vendor
React      = require 'react'
Reflux     = require 'reflux'
_          = require 'lodash'
Accounting = require 'accounting'

# Components
RemoveDonateeButton = require './donatee/remove_donatee_button'
PercentageInput     = require './donatee/percentage_input'

module.exports = React.createClass
  displayName: 'Donatee'

  propTypes:
    id:      React.PropTypes.string.isRequired
    title:   React.PropTypes.string.isRequired
    percent: React.PropTypes.string

  remove_donatee: ->
    @props.remove_callback @props.id

  update_percent: (percent) ->
    @props.percent_callback @props.id, percent

  componentDidMount: ->
    @highlight()

  render: ->
    <tr>
      <td width='100%'>
        <a href="https://www.youtube.com/channel/#{ @props.id }" target='_blank'>
          { @props.title }
        </a>
      </td>
      <td>
        <PercentageInput
          donatee_id      = { @props.id                  }
          default_percent = { @visible_default_percent() }
          percent         = { @props.percent             }
          max             = { @max()                     }
          update_callback = { @update_percent            }
        />
      </td>
      <td>
        { Accounting.formatMoney @money() }
      </td>
      <td>
        <RemoveDonateeButton
          donatee_id      = { @props.id       }
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
    100 - (@defined_percent_sum() - @props.percent)

  percent_to_use_for_money: ->
   if @props.percent then @props.percent / 100 else @real_default_percent()

  visible_default_percent: ->
    Math.floor( @real_default_percent() * 100 )

  real_default_percent: ->
    (1 - @defined_percent_sum() / 100) / (@props.donatees.length - @defined_percents().length)

  defined_percent_sum: ->
    if @defined_percents().length > 0 then @defined_percents().reduce((a,b) -> a + b) else 0

  defined_percents: ->
    _.compact @props.donatees.map( (d) -> parseInt(d.percent) )