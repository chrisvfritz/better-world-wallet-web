# Vendor
React  = require 'react'
Reflux = require 'reflux'
_      = require 'lodash'

# Actions
DonationCategoryActions = require 'actions/donation_category'

module.exports = React.createClass
  displayName: 'Channel'

  propTypes:
    channel_props:  React.PropTypes.object.isRequired
    click_callback: React.PropTypes.func.isRequired
    donatees:       React.PropTypes.arrayOf(React.PropTypes.object).isRequired
    category_id:    React.PropTypes.number.isRequired

  handle_click: ->
    new_donatees = @props.donatees
    new_donatees.push @props.channel_props
    DonationCategoryActions.update
      id: @props.category_id
      donatees: new_donatees
    @props.click_callback()

  prevent_propagation: (event) ->
    if event.stopPropagation
      event.stopPropagation()
    else if window.event
      window.event.cancelBubble = true

  render: ->
    classes = _.compact([
      'added' if @props.channel_props.id in @props.donatees.map (donatee) -> donatee.id
    ]).join ' '

    <tr
      onClick   = { @handle_click }
      className = { classes       }
    >
      <td width=30>
        <img
          src = { @props.channel_props.thumbnail }
          alt = 'Thumbnail'
        />
      </td>
      <td>
        <a
          onClick = { @prevent_propagation }
          href    = "https://www.youtube.com/channel/#{ @props.channel_props.id }"
          target  = '_blank'
        >
          { @props.channel_props.title }
        </a>
      </td>
      <td>
        {
          if @props.channel_props.description.length > 60
            @props.channel_props.description[0..60] + '...'
          else
            @props.channel_props.description
        }
      </td>
    </tr>