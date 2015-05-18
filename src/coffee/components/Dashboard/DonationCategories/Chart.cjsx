# -------
# IMPORTS
# -------

# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'
_sortBy       = require 'lodash/collection/sortBy'
_max          = require 'lodash/collection/max'

# Components
Bar = require './Chart/Bar'

# ---------
# COMPONENT
# ---------

module.exports = React.createClass
  displayName: 'Chart'

  mixins: [ BackboneMixin ]

  # -------
  # HELPERS
  # -------

  scaleX: (donation) ->
    donation * 100 / @maxDonation()

  maxDonation: ->
    _max @getCollection().map (category) ->
      if category.get('donatees').length > 0
        category.donationFloat()
      else
        0

  # ------
  # RENDER
  # ------

  render: ->
    <div>
      {
        sortedCategories = _sortBy @getCollection().models, (category) -> -category.donationFloat()
        sortedCategories.map (category) =>
          donation = category.donationFloat()
          donatees = category.get('donatees')
          if donation > 0 and donatees.length > 0
            <Bar
              collection = { donatees             }
              donation   = { donation             }
              width      = { @scaleX donation     }
              title      = { category.get 'title' }
            />
      }
    </div>