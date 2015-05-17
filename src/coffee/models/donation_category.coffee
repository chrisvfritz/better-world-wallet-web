# -------
# IMPORTS
# -------

# Vendor
Backbone = require 'backbone'

# Models
ModelBase = require './_model_base'
Donatees  = require './donatees'

# -----
# MODEL
# -----

class DonationCategory extends ModelBase
  url: -> "/donation-categories/#{@id}.json"

  defaults: ->
    title: 'Untitled Category'
    donation: 0
    donatees: new Donatees()

  initialize: ->
    # When the last donatee in a category has been destroyed
    # and it's not the last category left, destroy the category.
    donatees = @get 'donatees'
    donatees.on 'remove', =>
      if donatees.length is 0
        if @collection.length > 1
          @collection.remove @
        else
          @set 'title', 'General'
          @set 'donation', 0
    donatees.on 'add remove', =>
      @trigger 'change'

  donation_float: ->
    parseFloat @get('donation')

module.exports = DonationCategory