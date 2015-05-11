# -------
# IMPORTS
# -------

# Vendor
Backbone = require 'backbone'
_compact = require 'lodash/array/compact'

# Models
ModelBase = require './_model_base'

# -----
# MODEL
# -----

class Donatee extends ModelBase
  url: -> "/donatees/#{@id}.json"

  defaults:
    percent: ''

  decimal_percent: ->
    ( @get('percent') / 100 ) || @default_percent()

  default_percent: ->
    percent = (1 - @defined_percent_sum() / 100) / (@collection.length - @defined_percents().length)
    # http://stackoverflow.com/questions/1458633/how-to-deal-with-floating-point-number-precision-in-javascript#answer-3644302
    parseFloat percent.toPrecision(12)

  max_percent: ->
    percent = @get 'percent'
    # Don't allow the last undefined percent in a category to be defined, as it would allow users to
    # decide leave part of their money unused.
    return 0 if @collection.filter( (donatee) -> donatee.get('percent') ).length is @collection.length - 1 and percent.length is 0
    100 - ( @defined_percent_sum() - percent )

  defined_percent_sum: ->
    defined_percents = @defined_percents()
    if defined_percents.length > 0
      defined_percents.reduce (a,b) -> a + b
    else
      0

  defined_percents: ->
    _compact @collection.map (donatee) -> parseInt donatee.get('percent')

module.exports = Donatee