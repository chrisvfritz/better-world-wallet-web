# Vendor
React      = require 'react'
Reflux     = require 'reflux'
Accounting = require 'accounting'

# Bootstrap
Input = require 'react-bootstrap/lib/Input'

# Stores
DonationStore = require 'stores/donation'

# Actions
DonationActions = require 'actions/donation'

module.exports = React.createClass
  displayName: 'DonationAmountInput'

  mixins: [ Reflux.connect DonationStore, 'amount' ]

  handle_change: (event) ->
    DonationActions.update event.target.value

  render: ->
    amount = if @state.amount == 0 then '' else @state.amount

    <span className='form-inline'>
      <Input
        onChange    = { @handle_change }
        value       = { amount         }
        addonBefore = '$'
        bsSize      = 'large'
        type        = 'text'
        placeholder = '0'
      />
    </span>