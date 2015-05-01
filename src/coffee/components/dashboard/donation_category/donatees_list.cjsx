# Vendor
React  = require 'react'
Reflux = require 'reflux'

# Actions
DonationCategoryActions = require 'actions/donation_category'

# Bootstrap
Table = require 'react-bootstrap/lib/Table'

# Components
Donatee             = require './donatees_list/donatee'
DonationAmountInput = require './donation_amount_input'

module.exports = React.createClass
  displayName: 'DonateesList'

  remove_donatee: (donatee_id) ->
    DonationCategoryActions.remove_donatee @props.category_id, donatee_id

  update_percent: (donatee_id, percent) ->
    DonationCategoryActions.update_donatee_percent @props.category_id, donatee_id, percent

  render: ->
    sorted_donatees = @props.donatees.sort (a,b) ->
      title_a = a.title.toLowerCase()
      title_b = b.title.toLowerCase()
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
                  key              = { donatee.id      }
                  donatees         = { @props.donatees }
                  donation         = { @props.donation }
                  remove_callback  = { @remove_donatee }
                  percent_callback = { @update_percent }
                  {... donatee }
                />
            else
              <tr>
                <td>Nothing yet.</td>
              </tr>
          }
        </tbody>
      </Table>
    </div>