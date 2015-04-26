# Vendor
React = require 'react'

# Components
Channel = require './results/channel'

# Bootstrap
Table = require 'react-bootstrap/lib/Table'

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