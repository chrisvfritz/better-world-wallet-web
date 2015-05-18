# -------
# IMPORTS
# -------

# Vendor
Request = require 'superagent'

# -------
# WRAPPER
# -------

class YoutubeSearch

  constructor: ->
    @api_key = 'AIzaSyCWDqRvEAUpz6UeO0BNY9aQQEniv89qXR4'

  channels: (options, callback) ->
    Request
      .get "https://www.googleapis.com/youtube/v3/search?#{@params 'channel', options}"
      .end (error, response) ->
        if error
          alert 'Having trouble reaching YouTube. Are you connected to the Internet?'
        else
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