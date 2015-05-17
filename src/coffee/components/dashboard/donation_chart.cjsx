# -------
# IMPORTS
# -------

# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'
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

  # -------
  # HELPERS
  # -------

  scale_x: (donation) ->
    donation * 100 / @max_donation()

  max_donation: ->
    _max @getCollection().map (category) ->
      if category.get('donatees').length > 0
        category.donation_float()
      else
        0

  # ------
  # RENDER
  # ------

  render: ->
    <div>
      {
        sorted_categories = _sortBy @getCollection().models, (category) -> -category.donation_float()
        sorted_categories.map (category) =>
          donation = category.donation_float()
          donatees = category.get('donatees')
          if donation > 0 and donatees.length > 0
            <Bar
              key        = { category.cid         }
              collection = { donatees             }
              donation   = { donation             }
              width      = { @scale_x donation    }
              title      = { category.get 'title' }
            />
      }
    </div>