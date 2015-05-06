# -------
# IMPORTS
# -------

# Vendor
React      = require 'react'
StyleSheet = require 'react-style'

# ---------
# COMPONENT
# ---------

module.exports = React.createClass
  displayName: 'Card'

  # ------
  # RENDER
  # ------

  render: ->
    <div styles={ styles.card }>
      { @props.children }
    </div>

# ------
# STYLES
# ------

styles = StyleSheet.create

  card:
    padding: 15
    boxShadow: '0 1px 2px #aaa'
    background: 'white'
    margin: '10px 0'
    borderRadius: 3
    userSelect: 'none'