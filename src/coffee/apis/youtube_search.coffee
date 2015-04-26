Request = require 'superagent'

class YoutubeSearch

  constructor: ->
    @api_key = 'AIzaSyCWDqRvEAUpz6UeO0BNY9aQQEniv89qXR4'

  channels: (options, callback) ->
    Request
      .get "https://www.googleapis.com/youtube/v3/search?#{@params 'channel', options}"
      .end (error, response) ->
        callback(response.body)

  params: (type, options) ->
    params =
      part:       'snippet'
      key:        @api_key
      type:       type
      q:          options.query || ''
      maxResults: options.max   || 10
    Object.keys(params).map( (key) -> key + '=' + params[key] ).join('&')

module.exports = new YoutubeSearch()