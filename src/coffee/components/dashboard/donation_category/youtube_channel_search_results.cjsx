# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'
_compact      = require 'lodash/array/compact'
_flatten      = require 'lodash/array/flatten'

# Bootstrap
Table = require 'react-bootstrap/lib/Table'

# Components
Channel = require './youtube_channel_search_results/channel'

module.exports = React.createClass
  displayName: 'YoutubeChannelSearchResults'

  mixins: [ BackboneMixin ]

  all_donatee_ids: ->
    _compact _flatten @getCollection().map (c) -> c.get('donatees').map (d) -> d.id

  render: ->
    <div className='search_results_container'>
      <Table hover=true className='youtube_channel_search_results'>
        <tbody>
          {
            for channel in @props.channels
              <Channel
                key            = { channel.id                   }
                donatee_ids    = { @all_donatee_ids()           }
                click_callback = { @props.clear_search_callback }
                channel_props  = { channel                      }
              />
          }
        </tbody>
      </Table>
    </div>