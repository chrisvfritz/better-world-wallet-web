# Vendor
Backbone             = require 'backbone'
Backbone.localforage = require 'localforage-backbone'

# Models
DonationCategory = require './donation_category'

class DonationCategories extends Backbone.Collection
  model: DonationCategory
  sync: Backbone.localforage.sync 'DonationCategories'

  # Eventually I'll want to fetch records from an API for a specific user with
  # custom params and I may do so similar to below.

  # fetch: (options) ->
  #   Backbone.Collection.prototype.fetch.call(this, _.extend({
  #     data:
  #       user_id: # id of currently logged in user
  #     , options

module.exports = DonationCategories