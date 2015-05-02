# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'
_compact      = require 'lodash/array/compact'

# Models
DonateeModel = require 'models/donatee'

module.exports = React.createClass
  displayName: 'Channel'

  mixins: [ BackboneMixin ]

  handle_click: ->
    @getCollection().add new DonateeModel(@props.channel_props)
    @props.click_callback()

  prevent_propagation: (event) ->
    if event.stopPropagation
      event.stopPropagation()
    else if window.event
      window.event.cancelBubble = true

  render: ->
    classes = _compact([
      'added' if @props.channel_props.id in @getCollection().models.map (donatee) -> donatee.id
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