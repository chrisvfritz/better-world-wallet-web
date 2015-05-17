# -------
# IMPORTS
# -------

# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'
Radium        = require 'radium'
Accounting    = require 'accounting'

# Models
DonationCategoryModel = require 'models/donation_category'

# Bootstrap
Row       = require 'react-bootstrap/lib/Row'
Col       = require 'react-bootstrap/lib/Col'
Button    = require 'react-bootstrap/lib/Button'
Glyphicon = require 'react-bootstrap/lib/Glyphicon'

# Components
Card             = require 'components/shared/card'
DonationCategory = require './dashboard/donation_category'
DonationChart    = require './dashboard/donation_chart'

# ---------
# COMPONENT
# ---------

module.exports = React.createClass Radium.wrap
  displayName: 'Dashboard'

  mixins: [ BackboneMixin ]

  # -------
  # ACTIONS
  # -------

  add_new_category: ->
    @getCollection().add new DonationCategoryModel()

  # ------
  # RENDER
  # ------

  renderDonationTotal: ->
    <Card>
      <div style={ styles.total.container }>
        <h2 style={[ styles.total.text.base, styles.total.text.first]}>
          Total: {
            Accounting.formatMoney @getCollection().donation_total()
          }
        </h2>
        <Button
          onClick = { @add_new_category      }
          style   = { styles.total.text.base }
          bsSize  = 'medium'
          bsStyle = 'primary'
        >
          <Glyphicon glyph='plus'/>
        </Button>
      </div>
    </Card>

  renderDonationCategories: ->
    @getCollection().map (category) ->
      <DonationCategory
        key   = { category.cid }
        model = { category     }
      />

  renderWelcomeMessage: ->
    <div>
      <h3 style={ styles.welcome.heading }>
        Welcome!
      </h3>
      <p style={[ @getCollection().total_donatees() > 0 and styles.welcome.paragraph.last ]}>
        As you add donations and categories, a summary graph will appear below to visualize your values as reflected in how you vote with your money.
      </p>
      {
        if @getCollection().total_donatees() is 0
          <p style={ styles.welcome.paragraph.last }>
            Try adding your first channel now in the <code>Add a new channel...</code> input.
          </p>
      }
    </div>

  render: ->
    <Row>
      <Col md=6>
        { @renderDonationTotal() if @getCollection().donation_total() > 0 }
        { @renderDonationCategories() }
      </Col>
      <Col md=6>
        <Card>
          { @renderWelcomeMessage() }
          <DonationChart/>
        </Card>
      </Col>
    </Row>

# ------
# STYLES
# ------

styles =

  welcome:

    heading:
      marginTop: 0

    paragraph:

      last:
        marginBottom: 0

  total:

    container:
      display: 'table'

    text:

      base:
        display: 'table-cell'
        lineHeight: 1
        verticalAlign: 'middle'

      first:
        width: '100%'