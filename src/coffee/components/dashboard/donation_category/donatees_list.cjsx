# -------
# IMPORTS
# -------

# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'
Radium        = require 'radium'

# Bootstrap
Table = require 'react-bootstrap/lib/Table'

# Components
Donatee             = require './donatees_list/donatee'
DonationAmountInput = require './donation_amount_input'

# ---------
# COMPONENT
# ---------

module.exports = React.createClass Radium.wrap
  displayName: 'DonateesList'

  mixins: [ BackboneMixin ]

  # ------
  # RENDER
  # ------

  render: ->
    donatees = @getCollection()
    if donatees.length > 0
      <div>
        <h4 style={styles.donation_heading}>
          <span style={[ styles.donation_text.base, styles.donation_text.first ]}>
            Donating
          </span>
          <span style={[ styles.donation_text.base, styles.donation_text.input ]}>
            <DonationAmountInput/>
          </span>
          <span style={[ styles.donation_text.base, styles.donation_text.last ]}>
            to
          </span>
        </h4>
        <Table
          style   = { styles.table }
          striped = true
        >
          <tbody>
            {
              donatees.map (donatee) =>
                <Donatee
                  key      = { donatee.cid                }
                  model    = { donatee                    }
                  donation = { @getModel().get 'donation' }
                />
            }
          </tbody>
        </Table>
      </div>
    else
      <span></span>

# ------
# STYLES
# ------

styles =

  donation_heading:
    margin: '10px 0'
    display: 'tabln'

  donation_text:

    base:
      display: 'table-cell'
      verticalAlign: 'middle'
      padding: '0 4px'

    first:
      paddingLeft: 0

    input:
      width: '100%'

    last:
      paddingRight: 0

  table:
    marginLeft: -3
    marginBottom: 0