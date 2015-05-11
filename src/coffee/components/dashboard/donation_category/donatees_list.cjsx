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
    <div>
      <Table
        style   = { styles.table }
        striped = true
      >
        <tbody>
          {
            donatees = @getCollection()
            if donatees.length > 0
              donatees.map (donatee) =>
                <Donatee
                  key      = { donatee.cid                }
                  model    = { donatee                    }
                  donation = { @getModel().get 'donation' }
                />
            else
              <tr>
                <td>Nothing yet.</td>
              </tr>
          }
        </tbody>
      </Table>
    </div>

# ------
# STYLES
# ------

styles =

  table:
    marginLeft: -3
    marginBottom: 0