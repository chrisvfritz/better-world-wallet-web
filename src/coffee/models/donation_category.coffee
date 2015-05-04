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

  initialize: ->
    # When the last donatee in a category has been destroyed
    # and it's not the last category left, destroy the category.
    @attributes.donatees.on 'remove', =>
      @destroy() if @collection.length > 1 and @attributes.donatees.length == 0

module.exports = DonationCategory