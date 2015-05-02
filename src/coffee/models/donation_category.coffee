# Vendor
Backbone             = require 'backbone'
Backbone.localforage = require 'localforage-backbone'

# Models
ModelBase = require './_model_base'
Donatees  = require './donatees'

class DonationCategory extends ModelBase
  sync: Backbone.localforage.sync 'DonationCategory'

  defaults: ->
    title: 'Untitled Category'
    donation: 0
    donatees: new Donatees()

module.exports = DonationCategory