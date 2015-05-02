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
    sorted_donatees = @props.collection.models.sort (a,b) ->
      title_a = a.attributes.title.toLowerCase()
      title_b = b.attributes.title.toLowerCase()
      return -1 if title_a < title_b
      return  1 if title_a > title_b
      0

    <div className='donatees_list'>
      <Table striped=true>
        <tbody>
          {
            if sorted_donatees.length > 0
              for donatee in sorted_donatees
                <Donatee
                  key      = { donatee.cid     }
                  model    = { donatee         }
                  donation = { @props.donation }
                />
            else
              <tr>
                <td>Nothing yet.</td>
              </tr>
          }
        </tbody>
      </Table>
    </div>