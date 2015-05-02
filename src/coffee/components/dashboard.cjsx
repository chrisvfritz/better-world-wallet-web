# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'

# Models
DonationCategoryModel = require 'models/donation_category'

# Bootstrap
Row       = require 'react-bootstrap/lib/Row'
Col       = require 'react-bootstrap/lib/Col'
Button    = require 'react-bootstrap/lib/Button'
Glyphicon = require 'react-bootstrap/lib/Glyphicon'

# Components
DonationCategory = require './dashboard/donation_category'

module.exports = React.createClass
  displayName: 'Dashboard'

  mixins: [ BackboneMixin ]

  add_new_category: ->
    @getCollection().add new DonationCategoryModel()

  donation_total: ->
    @props.collection.models
      .map (collection) ->
        parseFloat(collection.attributes.donation || 0)
      .reduce (a,b) -> a + b
      .toFixed 2

  render: ->
    window.arst = @getCollection()
    <Row>
      <Col md=6>
        <div className='card'>
          <div id='total_donations'>
            <h2>
              Total Donations: ${ @donation_total() }
            </h2>
            <Button
              onClick = { @add_new_category }
              bsSize  = 'medium'
              bsStyle = 'primary'
            >
              <Glyphicon glyph='plus'/>
            </Button>
          </div>
        </div>
        {
          @props.collection.models.map (category) ->
            <DonationCategory
              key   = { category.cid }
              model = { category     }
            />
        }
      </Col>
      <Col md=6>
        <div className='card'>
          <h3>Welcome!</h3>
          <p>This is Better World Wallet!</p>
        </div>
      </Col>
    </Row>