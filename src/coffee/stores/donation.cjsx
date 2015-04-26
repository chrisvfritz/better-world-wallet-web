Reflux          = require 'Reflux'
Accounting      = require 'accounting'
DonationActions = require 'actions/donation'

_donation_amount = 0

module.exports = Reflux.createStore

  listenables: DonationActions

  getInitialState: ->
    _donation_amount

  update: (amount) ->
    _donation_amount = amount unless isNaN(amount) or parseInt(amount) < 0 or !/^[\d,]*\.?\d{0,2}$/.test(amount)
    @trigger _donation_amount
