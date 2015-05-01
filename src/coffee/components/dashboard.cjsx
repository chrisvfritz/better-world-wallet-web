# Vendor
React  = require 'react'
Reflux = require 'reflux'

# Stores
DonationCategoryStore = require 'stores/donation_category'

# Actions
DonationCategoryActions = require 'actions/donation_category'

# Bootstrap
Row       = require 'react-bootstrap/lib/Row'
Col       = require 'react-bootstrap/lib/Col'
Button    = require 'react-bootstrap/lib/Button'
Glyphicon = require 'react-bootstrap/lib/Glyphicon'

# Components
DonationCategory = require './dashboard/donation_category'

module.exports = React.createClass
  displayName: 'Dashboard'

  mixins: [ Reflux.connect DonationCategoryStore, 'categories' ]

  render: ->
    <Row>
      <Col md=6>
        <div className='card'>
          <h3>Welcome!</h3>
          <p>This is Better World Wallet!</p>
        </div>
      </Col>
      <Col md=6>
        <div className='card'>
          <div id='total_donations'>
            <h2>Total Donations: ${ @state.categories.map( (d) -> parseInt d.donation ).reduce (a,b) -> a + b }</h2>
            <Button
              onClick = { DonationCategoryActions.create }
              bsSize  = 'medium'
              bsStyle = 'primary'
            >
              <Glyphicon glyph='plus'/>
            </Button>
          </div>
        </div>
        {
          for category in @state.categories
            <DonationCategory
              key = { category.id }
              {... category }
            />
        }
      </Col>
    </Row>