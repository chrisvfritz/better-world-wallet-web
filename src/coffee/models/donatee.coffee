# -------
# IMPORTS
# -------

# Vendor
Backbone = require 'backbone'

# Models
ModelBase = require './_model_base'

# -----
# MODEL
# -----

class Donatee extends ModelBase
  url: -> "/donatees/#{@id}.json"

  defaults:
    percent: null

module.exports = Donatee