Reflux                  = require 'Reflux'
DonationCategoryActions = require 'actions/donation_category'

_donation_category_title = 'General'

module.exports = Reflux.createStore

  listenables: DonationCategoryActions

  getInitialState: ->
    _donation_category_title

  update: (title) ->
    _donation_category_title = title
    @trigger _donation_category_title
