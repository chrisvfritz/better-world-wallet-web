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
    @get('donatees').on 'remove', =>
      if @get('donatees').length == 0
        if @collection.length > 1
          @destroy()
        else
          @set 'title', 'General'

  donation_float: ->
    parseFloat @get('donation')

module.exports = DonationCategory