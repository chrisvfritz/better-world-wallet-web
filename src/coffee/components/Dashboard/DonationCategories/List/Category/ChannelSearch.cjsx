# ---------
# IMPORTS
# ---------

# Vendor
React      = require 'react'
_debounce  = require 'lodash/function/debounce'

# APIs
YoutubeSearch = require 'apis/YoutubeSearch'

# Bootstrap
Input = require 'react-bootstrap/lib/Input'

# Components
ClearSearchButton = require './ChannelSearch/ClearSearchButton'

# ---------
# COMPONENT
# ---------

module.exports = React.createClass
  displayName: 'YoutubeChannelSearch'

  # ----------
  # VALIDATION
  # ----------

  propTypes:
    query:               React.PropTypes.string.isRequired
    searchCallback:      React.PropTypes.func.isRequired
    clearSearchCallback: React.PropTypes.func.isRequired

  # ---------
  # LIFECYCLE
  # ---------

  componentWillReceiveProps: (nextProps) ->
    @shouldFocus = @props.query.length > 0 and nextProps.query.length is 0

  componentWillMount: ->
    @delayedSearch = _debounce (query) =>
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
          @props.searchCallback null, channels
      else
        @props.searchCallback null, []
    , 300

  componentDidUpdate: ->
    @refs.input.refs.input.getDOMNode().focus() if @shouldFocus

  # -------
  # ACTIONS
  # -------

  handleChange: (event) ->
    query = event.target.value
    @props.searchCallback query
    @delayedSearch        query

  # ------
  # RENDER
  # ------

  render: ->
    <Input
      onChange    = { @handleChange }
      value       = { @props.query  }
      buttonAfter = {
                      <ClearSearchButton
                        clickCallback = { @props.clearSearchCallback }
                      />
                    }
      ref         = 'input'
      standalone  = true
      placeholder = 'Add a new channel...'
      type        = 'text'
    />