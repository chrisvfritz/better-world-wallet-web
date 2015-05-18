# -------
# IMPORTS
# -------

# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'
Radium        = require 'radium'
_compact      = require 'lodash/array/compact'
_flatten      = require 'lodash/array/flatten'

# Bootstrap
Table = require 'react-bootstrap/lib/Table'

# Components
Channel = require './Results/Channel'

# ---------
# COMPONENT
# ---------

module.exports = React.createClass Radium.wrap
  displayName: 'YoutubeChannelSearchResults'

  mixins: [ BackboneMixin ]

  # ----------
  # VALIDATION
  # ----------

  propTypes:
    channels:            React.PropTypes.arrayOf(React.PropTypes.object).isRequired
    clearSearchCallback: React.PropTypes.func.isRequired

  # ------
  # RENDER
  # ------

  render: ->
    <div style={ styles.container.base }>
      <Table hover=true style={[ styles.table.base, @props.channels.length and styles.table.populated ]}>
        <tbody>
          {
            @props.channels.map (channel) =>
              <Channel
                key           = { channel.id                 }
                donateeIds    = { @allDonateeIds()           }
                clickCallback = { @props.clearSearchCallback }
                channelProps  = { channel                    }
              />
          }
        </tbody>
      </Table>
    </div>

  # -------
  # HELPERS
  # -------

  allDonateeIds: ->
    _compact _flatten @getCollection().map (c) -> c.get('donatees').map (d) -> d.id

# ------
# STYLES
# ------

styles =

  container:

    base:
      position: 'relative'

  table:

    base:
      position: 'absolute'
      background: '#FCFFFA'
      borderBottomLeftRadius: 3
      borderBottomRightRadius: 3
      boxShadow: '0 2px 3px rgba(0,0,0,0.2)'
      opacity: 0
      transition: 'opacity 0.5s'
      zIndex: 3

    populated:
      opacity: 1