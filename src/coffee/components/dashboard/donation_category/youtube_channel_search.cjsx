# ---------
# IMPORTS
# ---------

# Vendor
React      = require 'react'
_debounce  = require 'lodash/function/debounce'

# APIs
YoutubeSearch = require 'apis/youtube_search'

# Bootstrap
Input = require 'react-bootstrap/lib/Input'

# Components
ClearSearchButton = require './youtube_channel_search/clear_search_button'

# ---------
# COMPONENT
# ---------

module.exports = React.createClass
  displayName: 'YoutubeChannelSearch'

  # ----------
  # VALIDATION
  # ----------

  propTypes:
    query: React.PropTypes.string.isRequired
    search_callback: React.PropTypes.func.isRequired
    clear_search_callback: React.PropTypes.func.isRequired

  # ---------
  # LIFECYCLE
  # ---------

  componentWillReceiveProps: (next_props) ->
    @should_focus = @props.query.length > 0 and next_props.query.length == 0

  componentWillMount: ->
    @delayed_search = _debounce (query) =>
      if query.length > 0
        YoutubeSearch.channels
          query: query
          max: 5
        , (results) =>
          channels = results.items.map (item) ->
            id:          item.id.channelId
            title:       item.snippet.title
            description: item.snippet.description
            thumbnail:   "#{item.snippet.thumbnails.default.url}?size=30"
          @props.search_callback null, channels
      else
        @props.search_callback null, []
    , 300

  componentDidUpdate: ->
    @refs.input.refs.input.getDOMNode().focus() if @should_focus

  # -------
  # ACTIONS
  # -------

  handle_change: (event) ->
    query = event.target.value
    @props.search_callback query
    @delayed_search        query

  # ------
  # RENDER
  # ------

  render: ->
    <Input
      onChange    = { @handle_change }
      value       = { @props.query   }
      buttonAfter = {
                      <ClearSearchButton
                        click_callback = { @props.clear_search_callback }
                      />
                    }
      ref         = { 'input' }
      standalone  = true
      placeholder = 'Add a new channel...'
      type        = 'text'
    />