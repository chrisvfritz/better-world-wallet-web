# -------
# IMPORTS
# -------

# Vendor
React  = require 'react'
Radium = require 'radium'

# ---------
# COMPONENT
# ---------

module.exports = React.createClass Radium.wrap
  displayName: 'Label'

  # ----------
  # VALIDATION
  # ----------

  propTypes:
    barWidth:        React.PropTypes.number.isRequired
    isTransitioning: React.PropTypes.bool.isRequired

  # ------
  # RENDER
  # ------

  render: ->
    <span style={[
      styles.label.base
      if @props.barWidth < 50   then styles.label.right         else styles.label.left
      if @props.isTransitioning then styles.label.transitioning else styles.label.stable
    ]}>
      { @props.text }
    </span>

# ------
# STYLES
# ------

styles =

  label:

    base:
      lineHeight: '30px'
      padding: '0 10px'
      position: 'absolute'
      top: 0
      whiteSpace: 'nowrap'
      pointerEvents: 'none'

    stable:
      transition: 'opacity 0.2s'

    transitioning:
      opacity: 0

    left:
      right: 0
      textShadow: Array(10).join('0 0 10px #2377BA,').slice(0,-1)
      color: 'white'

    right:
      left: '100%'