# -------
# IMPORTS
# -------

# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'
StyleSheet    = require 'react-style'
_compact      = require 'lodash/array/compact'
_flatten      = require 'lodash/array/flatten'

# Bootstrap
Table = require 'react-bootstrap/lib/Table'

# Components
Channel = require './youtube_channel_search_results/channel'

# ---------
# COMPONENT
# ---------

module.exports = React.createClass
  displayName: 'YoutubeChannelSearchResults'

  mixins: [ BackboneMixin ]

  # ------
  # RENDER
  # ------

  render: ->
    <div styles={ styles.container }>
      <Table hover=true styles={ styles.table }>
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

  # -------
  # HELPERS
  # -------

  all_donatee_ids: ->
    _compact _flatten @getCollection().map (c) -> c.get('donatees').map (d) -> d.id

# ------
# STYLES
# ------

styles = StyleSheet.create

  container:
    position: 'relative'

  table:
    position: 'absolute'
    background: '#FCFFFA'
    borderBottomLeftRadius: 3
    borderBottomRightRadius: 3
    boxShadow: '0 2px 3px rgba(0,0,0,0.2)'
    zIndex: 3;