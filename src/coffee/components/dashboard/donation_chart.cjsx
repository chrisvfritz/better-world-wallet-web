# -------
# IMPORTS
# -------

# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'
StyleSheet    = require 'react-style'
D3            = require 'd3'
_sortBy       = require 'lodash/collection/sortBy'

# Components
Bar = require './donation_chart/bar'

# ---------
# COMPONENT
# ---------

module.exports = React.createClass
  displayName: 'DonationChart'

  mixins: [ BackboneMixin ]

  # ------
  # RENDER
  # ------

  render: ->
    donations = @getCollection().map (category) -> category.donation_float()

    x = D3.scale.linear()
      .domain [ 0, D3.max donations ]
      .range  [ 0, 100 ]

    <div>
      {
        sorted_categories = _sortBy @getCollection().models, (category) -> -category.donation_float()
        sorted_categories.map (category) ->
          donation = category.donation_float()
          if donation > 0
            <Bar
              key      = { category.cid         }
              donation = { donation             }
              width    = { x donation           }
              title    = { category.get 'title' }
            />
      }
    </div>

# ------
# STYLES
# ------

styles = StyleSheet.create
