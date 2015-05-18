# -------
# IMPORTS
# -------

# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'
Radium        = require 'radium'

# Components
Category = require './List/Category'

# ---------
# COMPONENT
# ---------

module.exports = React.createClass Radium.wrap
  displayName: 'List'

  mixins: [ BackboneMixin ]

  # ------
  # RENDER
  # ------

  render: ->
    <div>
      {
        @getCollection().map (category) ->
          <Category
            key   = { category.cid }
            model = { category     }
          />
      }
    </div>

# ------
# STYLES
# ------

# styles =