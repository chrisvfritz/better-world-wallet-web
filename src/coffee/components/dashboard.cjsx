# -------
# IMPORTS
# -------

# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'

# Bootstrap
Row = require 'react-bootstrap/lib/Row'
Col = require 'react-bootstrap/lib/Col'

# Components
Card                    = require 'components/shared/Card'
DonationCategories      = require './Dashboard/DonationCategories'
DonationCategoriesChart = require './Dashboard/DonationCategories/Chart'
Instructions            = require './Dashboard/Instructions'

# ---------
# COMPONENT
# ---------

module.exports = React.createClass
  displayName: 'Dashboard'

  mixins: [ BackboneMixin ]

  # ------
  # RENDER
  # ------

  render: ->
    <Row>
      <Col md=6>
        <DonationCategories/>
      </Col>
      <Col md=6>
        <Card>
          <Instructions/>
          <DonationCategoriesChart/>
        </Card>
      </Col>
    </Row>