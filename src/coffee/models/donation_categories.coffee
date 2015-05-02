# Vendor
Backbone             = require 'backbone'
Backbone.localforage = require 'localforage-backbone'

# Models
DonationCategory = require './donation_category'

class DonationCategories extends Backbone.Collection
  model: DonationCategory
  sync: Backbone.localforage.sync 'DonationCategories'

module.exports = DonationCategories