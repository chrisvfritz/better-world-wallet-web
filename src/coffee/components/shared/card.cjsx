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
  displayName: 'Card'

  # ------
  # RENDER
  # ------

  render: ->
    <div style={ styles.card }>
      { @props.children }
    </div>

# ------
# STYLES
# ------

styles =

  card:
    padding: 15
    boxShadow: '0 1px 2px #aaa'
    background: 'white'
    margin: '10px 0'
    borderRadius: 3
    userSelect: 'none'