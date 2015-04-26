# Vendor
React  = require 'react'
Reflux = require 'reflux'

# Stores
DonationCategoryStore = require 'stores/donation_category'

# Bootstrap
Row = require 'react-bootstrap/lib/Row'
Col = require 'react-bootstrap/lib/Col'

# Components
DonationCategory = require './dashboard/donation_category'

module.exports = React.createClass
  displayName: 'Dashboard'

  mixins: [ Reflux.connect DonationCategoryStore, 'category_title' ]

  render: ->
    <Row>
      <Col md=6>
        <div className='card'>
          <h3>Welcome!</h3>
          <p>This is Better World Wallet!</p>
        </div>
      </Col>
      <Col md=6>
        <DonationCategory
          title = { @state.category_title }
        />
      </Col>
    </Row>