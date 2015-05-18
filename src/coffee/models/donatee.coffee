# -------
# IMPORTS
# -------

# Vendor
Backbone = require 'backbone'
_compact = require 'lodash/array/compact'

# Models
ModelBase = require './_ModelBase'

# -----
# MODEL
# -----

class Donatee extends ModelBase
  url: -> "/donatees/#{@id}.json"

  defaults:
    percent: ''

  decimalPercent: ->
    ( @get('percent') / 100 ) || @defaultPercent()

  defaultPercent: ->
    percent = (1 - @definedPercentSum() / 100) / (@collection.length - @definedPercents().length)
    # http://stackoverflow.com/questions/1458633/how-to-deal-with-floating-point-number-precision-in-javascript#answer-3644302
    parseFloat percent.toPrecision(12)

  maxPercent: ->
    percent = @get 'percent'
    # Don't allow the last undefined percent in a category to be defined, as it would allow users to
    # decide leave part of their money unused.
    return 0 if @collection.filter( (donatee) -> donatee.get('percent') ).length is @collection.length - 1 and percent.length is 0
    100 - ( @definedPercentSum() - percent )

  definedPercentSum: ->
    definedPercents = @definedPercents()
    if definedPercents.length > 0
      definedPercents.reduce (a,b) -> a + b
    else
      0

  definedPercents: ->
    _compact @collection.map (donatee) -> parseInt donatee.get('percent')

module.exports = Donatee