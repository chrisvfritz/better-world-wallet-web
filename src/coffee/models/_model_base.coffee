# -------
# IMPORTS
# -------

# Vendor
Backbone = require 'backbone'

# -----
# MODEL
# -----

class ModelBase extends Backbone.Model
  set: (attrs) ->
    self = @
    if attrs.collection
      # Bind any child collection changes to the model by triggering `change`.
      # This allows the root components to be aware that we need to change the
      # DOM.
      attrs.collection.on 'add remove change', ->
        self.trigger 'change'
    Backbone.Model.prototype.set.apply @, arguments

module.exports = ModelBase