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
    unless @is_already_added()
      @getModel().get('donatees').add new DonateeModel(@props.channel_props)
      @props.click_callback()

  prevent_propagation: (event) ->
    if event.stopPropagation
      event.stopPropagation()
    else if window.event
      window.event.cancelBubble = true

  is_already_added: ->
    @props.channel_props.id in @props.donatee_ids

  render: ->
    classes = _compact([
      'added' if @is_already_added()
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