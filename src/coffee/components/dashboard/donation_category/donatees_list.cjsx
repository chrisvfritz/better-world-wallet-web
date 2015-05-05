# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'

# Bootstrap
Table = require 'react-bootstrap/lib/Table'

# Components
Donatee             = require './donatees_list/donatee'
DonationAmountInput = require './donation_amount_input'

module.exports = React.createClass
  displayName: 'DonateesList'

  mixins: [ BackboneMixin ]

  render: ->
    sorted_donatees = @getCollection().sort()

    <div className='donatees_list'>
      <Table striped=true>
        <tbody>
          {
            if sorted_donatees.length > 0
              for donatee in sorted_donatees.models
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