# Vendor
Reflux = require 'Reflux'
_      = require 'lodash'

# Actions
DonationCategoryActions = require 'actions/donation_category'

_next_id = 1

_donation_categories = [
  {
    id: _next_id++
    title: 'General'
    donation: 0
    donatees: []
  }
]

module.exports = Reflux.createStore

  listenables: DonationCategoryActions

  getInitialState: ->
    _donation_categories

  create: ->
    id = _next_id++
    _donation_categories.push
      id: id
      title: "Category #{id}"
      donation: 0
      donatees: []
    @trigger _donation_categories

  update: (category) ->
    # Find
    index = _donation_categories.indexOf _.find( _donation_categories, (c) -> category.id is c.id )
    # Validate
    delete category.donation if category.donation and isNaN(category.donation) or parseInt(category.donation) < 0 or !/^[\d,]*\.?\d{0,2}$/.test(category.donation)
    # Update
    _donation_categories[index] = _.merge _donation_categories[index], category
    # Callback
    @trigger _donation_categories

  remove_donatee: (category_id, donatee_id) ->
    # Find
    category_index = _donation_categories.indexOf _.find( _donation_categories, (c) -> category_id is c.id )
    donatee_index = _donation_categories[category_index].donatees.indexOf _.find( _donation_categories[category_index].donatees, (d) -> donatee_id is d.id )
    # Update
    _donation_categories[category_index].donatees.splice donatee_index, 1
    # Callback
    @trigger _donation_categories

  update_donatee_percent: (category_id, donatee_id, percent) ->
    # Find
    category_index = _donation_categories.indexOf _.find( _donation_categories, (c) -> category_id is c.id )
    donatee_index = _donation_categories[category_index].donatees.indexOf _.find( _donation_categories[category_index].donatees, (d) -> donatee_id is d.id )
    # Update
    _donation_categories[category_index].donatees[donatee_index].percent = percent
    # Callback
    @trigger _donation_categories
