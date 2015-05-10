# -------
# IMPORTS
# -------

# Vendor
Backbone = require 'backbone'

# Models
Donatee = require './donatee'

# ----------
# COLLECTION
# ----------

class Donatees extends Backbone.Collection
  model: Donatee
  url: '/donatees.json'

  comparator: (donatee) ->
    donatee.get 'title'

module.exports = Donatees