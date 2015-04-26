# Vendor
React = require 'react'

# Bootstrap
Table = require 'react-bootstrap/lib/Table'

# Components
Channel = require './results/channel'

module.exports = React.createClass
  displayName: 'Results'

  render: ->
    <Table hover='true'>
      <tbody>
        {
          for channel in @props.channels
            <Channel
              key = { channel.id }
              {... channel }
            />
        }
      </tbody>
    </Table>