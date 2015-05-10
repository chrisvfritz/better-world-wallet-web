# -------
# IMPORTS
# -------

# Vendor
Backbone = require 'backbone'

# Models
DonationCategory = require './donation_category'

# ----------
# COLLECTION
# ----------

class DonationCategories extends Backbone.Collection
  model: DonationCategory
  url: '/donation-categories.json'

  donation_total: ->
    @
      .map (category) ->
        category.donation_float() || 0
      .reduce ( (a,b) -> a + b ), 0

  # Eventually I'll want to fetch records from an API for a specific user with
  # custom params and I may do so similar to below:

  # fetch: (options) ->
  #   Backbone.Collection.prototype.fetch.call(this, _.extend({
  #     data:
  #       user_id: # id of currently logged in user
  #     , options

module.exports = DonationCategories