# Vendor
Backbone             = require 'backbone'
Backbone.localforage = require 'localforage-backbone'

# Models
ModelBase = require './_model_base'

class Donatee extends ModelBase
  sync: Backbone.localforage.sync 'Donatee'

  defaults:
    percent: null

module.exports = Donatee