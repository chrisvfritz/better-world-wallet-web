# Vendor
React = require 'react'

# Bootstrap
Row = require 'react-bootstrap/lib/Row'
Col = require 'react-bootstrap/lib/Col'

# Components
Search       = require './dashboard/youtube_channel_search'
DonateesList = require './dashboard/donatees_list'

module.exports = React.createClass
  displayName: 'Dashboard'

  render: ->
    <Row>
      <Col md=6>
        <Search/>
      </Col>
      <Col md=6>
        <DonateesList/>
      </Col>
    </Row>