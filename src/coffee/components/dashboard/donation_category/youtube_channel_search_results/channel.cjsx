# -------
# IMPORTS
# -------

# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'
StyleSheet    = require 'react-style'
_compact      = require 'lodash/array/compact'

# Models
DonateeModel = require 'models/donatee'

# ---------
# COMPONENT
# ---------

module.exports = React.createClass
  displayName: 'Channel'

  mixins: [ BackboneMixin ]

  # ----------
  # VALIDATION
  # ----------

  propTypes:
    donatee_ids: React.PropTypes.arrayOf(React.PropTypes.string).isRequired
    channel_props: React.PropTypes.object.isRequired
    click_callback: React.PropTypes.func.isRequired
    loader: React.PropTypes.string

  # ---------
  # LIFECYCLE
  # ---------

  getDefaultProps: ->
    loader: '/assets/images/loading.gif'

  getInitialState: ->
    image_is_loaded: false

  componentDidMount: ->
    thumbnail = new Image()
    thumbnail.onload = =>
      @setState
        image_is_loaded: true
    thumbnail.src = @props.channel_props.thumbnail

  # -------
  # ACTIONS
  # -------

  handle_click: ->
    unless @is_already_added()
      @getModel().get('donatees').add new DonateeModel(@props.channel_props)
      @props.click_callback()

  # ------
  # RENDER
  # ------

  render: ->
    <tr
      onClick = { @handle_click }
      styles  = {[ styles.row.base, @is_already_added() && styles.row.added ]}
    >
      <td width=30>
        <img
          styles = { styles.thumbnail }
          src    = { if @state.image_is_loaded then @props.channel_props.thumbnail else @props.loader }
          alt    = 'Thumbnail'
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

  # -------
  # HELPERS
  # -------

  prevent_propagation: (event) ->
    if event.stopPropagation
      event.stopPropagation()
    else if window.event
      window.event.cancelBubble = true

  is_already_added: ->
    @props.channel_props.id in @props.donatee_ids

# ------
# STYLES
# ------

styles = StyleSheet.create

  row:

    base:
      cursor: 'pointer'
      minHeight: 47

    added:
      cursor: 'default'
      background: '#DDFFE4'
      opacity: 0.4

  thumbnail:
    width: 30