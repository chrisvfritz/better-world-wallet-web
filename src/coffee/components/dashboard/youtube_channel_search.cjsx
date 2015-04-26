# Vendor
React   = require 'react'
_       = require 'lodash'
Request = require 'superagent'

# Bootstrap
Input = require 'react-bootstrap/lib/Input'

# Components
Results = require './youtube_channel_search/results'

module.exports = React.createClass
  displayName: 'YoutubeChannelSearch'

  getInitialState: ->
    channels: []
    query: ''

  componentWillMount: ->
    @delayed_search = _.debounce (event) =>
      if @state.query.length > 0
        Request
          .get [
              'https://www.googleapis.com/youtube/v3/search?part=snippet'
              'type=channel'
              "q=#{@state.query}"
              'maxResults=10'
              'key=AIzaSyCWDqRvEAUpz6UeO0BNY9aQQEniv89qXR4'
            ].join '&'
          .end (error, response) =>
            @setState
              channels: response.body.items.map (item) ->
                id:          item.id.channelId
                title:       item.snippet.title
                description: item.snippet.description
                thumbnail:   "#{item.snippet.thumbnails.default.url}?size=30"
      else
        @setState
          channels: []
    , 300

  handle_change: (event) ->
    @setState
      query: event.target.value
    event.persist()
    @delayed_search event

  render: ->
    <div id='channel_search'>
      <h2>Search Channels</h2>
      <Input
        onChange  = { @handle_change }
        type      = 'text'
      />
      <Results channels={ @state.channels }/>
    </div>