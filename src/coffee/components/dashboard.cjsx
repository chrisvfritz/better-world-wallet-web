# -------
# IMPORTS
# -------

# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'
StyleSheet    = require 'react-style'

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

module.exports = React.createClass
  displayName: 'Dashboard'

  mixins: [ BackboneMixin ]

  # ------
  # RENDER
  # ------

  render: ->
    <Row>
      <Col md=6>
        <Card>
          <div styles={ styles.total.container }>
            <h2 styles={[ styles.total.text.base, styles.total.text.first]}>
              Total: ${
                total = @getCollection().donation_total()
                if total % 1 is 0 then total else total.toFixed(2)
              }
            </h2>
            <Button
              onClick = { @add_new_category      }
              styles  = { styles.total.text.base }
              bsSize  = 'medium'
              bsStyle = 'primary'
            >
              <Glyphicon glyph='plus'/>
            </Button>
          </div>
        </Card>
        {
          @getCollection().map (category) ->
            <DonationCategory
              key   = { category.cid }
              model = { category     }
            />
        }
      </Col>
      <Col md=6>
        <Card>
          <h3 styles={ styles.welcome.heading }>
            Welcome!
          </h3>
          <p styles={ styles.welcome.paragraph }>
            As you add donations and categories, a summary graph will appear below to visualize your values as reflected in how you vote with your money.
          </p>
          {
            if @getCollection().length > 1
              <DonationChart/>
          }
        </Card>
      </Col>
    </Row>

  # -------
  # HELPERS
  # -------

  add_new_category: ->
    @getCollection().add new DonationCategoryModel()

# ------
# STYLES
# ------

styles = StyleSheet.create

  welcome:

    heading:
      marginTop: 0

    paragraph:
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