# Vendor
React  = require 'react'
Reflux = require 'reflux'
_      = require 'lodash'

# Stores
DonateeStore = require 'stores/donatee'

# Actions
DonateeActions = require 'actions/donatee'

module.exports = React.createClass
  displayName: 'Channel'

  # Binds changes in the DonateeStore to @state.donatees
  mixins: [ Reflux.connect DonateeStore, 'donatees' ]

  propTypes:
    id:          React.PropTypes.string.isRequired
    title:       React.PropTypes.string.isRequired
    description: React.PropTypes.string.isRequired
    thumbnail:   React.PropTypes.string.isRequired

  handle_click: ->
    DonateeActions.create @props

  prevent_propagation: (event) ->
    if event.stopPropagation
      event.stopPropagation()
    else if window.event
      window.event.cancelBubble = true

  render: ->
    classes = _.compact([
      'added' if @props.id in @state.donatees.map (donatee) -> donatee.id
    ]).join ' '

    <tr
      onClick   = { @handle_click }
      className = { classes       }
    >
      <td>
        <img
          src = { @props.thumbnail }
          alt = 'Thumbnail'
        />
      </td>
      <td>
        <a
          onClick = { @prevent_propagation }
          href    = "https://www.youtube.com/channel/#{ @props.id }"
          target  = '_blank'
        >
          { @props.title }
        </a>
      </td>
      <td>
        { @props.description }
      </td>
    </tr>