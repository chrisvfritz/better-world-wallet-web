# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'

# Bootstrap
Table = require 'react-bootstrap/lib/Table'

# Components
Channel = require './youtube_channel_search_results/channel'

module.exports = React.createClass
  displayName: 'YoutubeChannelSearchResults'

  mixins: [ BackboneMixin ]

  render: ->
    <div className='search_results_container'>
      <Table hover=true className='youtube_channel_search_results'>
        <tbody>
          {
            for channel in @props.channels
              <Channel
                key            = { channel.id                   }
                donatees       = { @props.collection.moedels    }
                click_callback = { @props.clear_search_callback }
                channel_props  = { channel                      }
              />
          }
        </tbody>
      </Table>
    </div>