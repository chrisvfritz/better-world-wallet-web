# Vendor
React = require 'react'

# Bootstrap
Table = require 'react-bootstrap/lib/Table'

# Components
Channel = require './youtube_channel_search_results/channel'

module.exports = React.createClass
  displayName: 'YoutubeChannelSearchResults'

  propTypes:
    channels:              React.PropTypes.arrayOf(React.PropTypes.object).isRequired
    clear_search_callback: React.PropTypes.func.isRequired
    donatees:              React.PropTypes.arrayOf(React.PropTypes.object).isRequired
    category_id:           React.PropTypes.number.isRequired

  render: ->
    <div className='search_results_container'>
      <Table hover=true className='youtube_channel_search_results'>
        <tbody>
          {
            for channel in @props.channels
              <Channel
                key            = { channel.id                   }
                donatees       = { @props.donatees              }
                click_callback = { @props.clear_search_callback }
                channel_props  = { channel                      }
                category_id    = { @props.category_id           }
              />
          }
        </tbody>
      </Table>
    </div>