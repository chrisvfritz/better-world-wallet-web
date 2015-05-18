# -------
# IMPORTS
# -------

# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'
Radium        = require 'radium'

# Components
Controls = require './DonationCategories/Controls'
List     = require './DonationCategories/List'

# ---------
# COMPONENT
# ---------

module.exports = React.createClass Radium.wrap
  displayName: 'DonationCategories'

  mixins: [ BackboneMixin ]

  # ------
  # RENDER
  # ------

  render: ->
    <div>
      {
        if @getCollection().totalDonatees()
          <Controls/>
      }
      <List/>
    </div>

# ------
# STYLES
# ------

# styles =