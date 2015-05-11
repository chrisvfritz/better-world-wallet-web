# -------
# IMPORTS
# -------

# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'
StyleSheet    = require 'react-style'
_sortBy       = require 'lodash/collection/sortBy'
_max          = require 'lodash/collection/max'

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
    <div>
      {
        sorted_categories = _sortBy @getCollection().models, (category) -> -category.donation_float()
        sorted_categories.map (category) =>
          donation = category.donation_float()
          if donation > 0
            <Bar
              key        = { category.cid            }
              collection = { category.get 'donatees' }
              donation   = { donation                }
              width      = { @scale_x donation       }
              title      = { category.get 'title'    }
            />
      }
    </div>

  # -------
  # HELPERS
  # -------

  scale_x: (donation) ->
    donation * 100 / @max_donation()

  max_donation: ->
    _max @getCollection().map (category) -> category.donation_float()

# ------
# STYLES
# ------

styles = StyleSheet.create
