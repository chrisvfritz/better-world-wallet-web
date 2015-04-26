# Vendor
React  = require 'react'
Reflux = require 'reflux'

# Stores
DonateeStore  = require 'stores/donatee'
DonationStore = require 'stores/donation'

# Bootstrap
Table = require 'react-bootstrap/lib/Table'

# Components
Donatee             = require './donatees_list/donatee'
DonationAmountInput = require './donation_amount_input'

module.exports = React.createClass
  displayName: 'DonateesList'

  mixins: [ Reflux.connect DonateeStore, 'donatees' ]

  render: ->
    sorted_donatees = @state.donatees.sort (a,b) ->
      title_a = a.title.toLowerCase()
      title_b = b.title.toLowerCase()
      return -1 if title_a < title_b
      return  1 if title_a > title_b
      0

    <div id='donatees'>
      <Table striped=true>
        <tbody>
          {
            if sorted_donatees.length > 0
              for donatee in sorted_donatees
                <Donatee
                  key={donatee.id}
                  {... donatee}
                />
            else
              <tr>
                <td>Nothing yet.</td>
              </tr>
          }
        </tbody>
      </Table>
    </div>