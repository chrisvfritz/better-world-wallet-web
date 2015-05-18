# -------
# IMPORTS
# -------

# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'
Radium        = require 'radium'

# Models
DonateeModel = require 'models/Donatee'

# ---------
# COMPONENT
# ---------

module.exports = React.createClass Radium.wrap
  displayName: 'Channel'

  mixins: [ BackboneMixin ]

  # ----------
  # VALIDATION
  # ----------

  propTypes:
    donateeIds:    React.PropTypes.arrayOf(React.PropTypes.string).isRequired
    channelProps:  React.PropTypes.object.isRequired
    clickCallback: React.PropTypes.func.isRequired
    loader:        React.PropTypes.string

  # ---------
  # LIFECYCLE
  # ---------

  getDefaultProps: ->
    loader: 'assets/images/loading.gif'

  getInitialState: ->
    imageIsLoaded: false

  componentDidMount: ->
    thumbnail = new Image()
    thumbnail.onload = =>
      @setState
        imageIsLoaded: true
    thumbnail.src = @props.channelProps.thumbnail

  # -------
  # ACTIONS
  # -------

  handleClick: ->
    unless @isAlreadyAdded()
      @getModel().get('donatees').add new DonateeModel(@props.channelProps)
      @props.clickCallback()

  # -------
  # HELPERS
  # -------

  preventPropagation: (event) ->
    if event.stopPropagation
      event.stopPropagation()
    else if window.event
      window.event.cancelBubble = true

  isAlreadyAdded: ->
    @props.channelProps.id in @props.donateeIds

  # ------
  # RENDER
  # ------

  render: ->
    <tr
      onClick = { @handleClick }
      style   = {[ styles.row.base, @isAlreadyAdded() and styles.row.added ]}
    >
      <td width=30>
        <img
          style  = { styles.thumbnail.base }
          src    = { if @state.imageIsLoaded then @props.channelProps.thumbnail else @props.loader }
          alt    = 'Thumbnail'
        />
      </td>
      <td>
        <a
          onClick = { @preventPropagation }
          href    = "https://www.youtube.com/channel/#{ @props.channelProps.id }"
          target  = '_blank'
        >
          { @props.channelProps.title }
        </a>
      </td>
      <td>
        {
          if @props.channelProps.description.length > 60
            @props.channelProps.description[0..60] + '...'
          else
            @props.channelProps.description
        }
      </td>
    </tr>

# ------
# STYLES
# ------

styles =

  row:

    base:
      cursor: 'pointer'
      minHeight: 47

    added:
      cursor: 'default'
      background: '#DDFFE4'
      opacity: 0.4

  thumbnail:

    base:
      width: 30