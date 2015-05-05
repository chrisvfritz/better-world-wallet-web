# Vendor
Backbone             = require 'backbone'
Backbone.localforage = require 'localforage-backbone'

# Models
Donatee = require './donatee'

class Donatees extends Backbone.Collection
  model: Donatee
  sync: Backbone.localforage.sync 'Donatees'

  comparator: (donatee) ->
    donatee.get 'title'

module.exports = Donatees