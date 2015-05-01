# Vendor
React      = require 'react'
Reflux     = require 'reflux'
Accounting = require 'accounting'

# Actions
DonationCategoryActions = require 'actions/donation_category'

# Bootstrap
Input = require 'react-bootstrap/lib/Input'

module.exports = React.createClass
  displayName: 'DonationAmountInput'

  handle_change: (event) ->
    DonationCategoryActions.update
      id: @props.category_id
      donation: event.target.value

  render: ->
    amount = if @props.amount == 0 then '' else @props.amount

    <span className='form-inline'>
      <Input
        onChange    = { @handle_change }
        value       = { amount         }
        addonBefore = '$'
        bsSize      = 'medium'
        type        = 'text'
        placeholder = '0'
      />
    </span>