# -------
# IMPORTS
# -------

# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'
Radium        = require 'radium'
Accounting    = require 'accounting'
TweenState    = require 'react-tween-state'


# ---------
# COMPONENT
# ---------

module.exports = React.createClass Radium.wrap
  displayName: 'DonationTotal'

  mixins: [ BackboneMixin, TweenState.Mixin ]

  # ----------
  # VALIDATION
  # ----------

  propTypes:
    style: React.PropTypes.array

  # ---------
  # LIFECYCLE
  # ---------

  getInitialState: ->
    total: @getCollection().donationTotal()

  componentWillReceiveProps: (nextProps) ->
    @tweenState 'total',
      duration: 200
      endValue: @getCollection().donationTotal()

  # ------
  # RENDER
  # ------

  render: ->
    <h2 style={ @props.style }>
      Total: { Accounting.formatMoney @getTweeningValue('total') }
    </h2>