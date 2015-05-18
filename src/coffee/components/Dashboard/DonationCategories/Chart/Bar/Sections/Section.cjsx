# -------
# IMPORTS
# -------

# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'
Radium        = require 'radium'

# Components
Tooltip = require './Section/Tooltip'

# ---------
# COMPONENT
# ---------

module.exports = React.createClass Radium.wrap
  displayName: 'Section'

  mixins: [ BackboneMixin ]

  # -------
  # HELPERS
  # -------

  dynamicSectionStyles: ->
    width: @getModel().decimalPercent() * 100 + '%'

  # ------
  # RENDER
  # ------

  render: ->
    <div style={[ styles.section.base, @dynamicSectionStyles() ]}>
      <Tooltip/>
    </div>

# ------
# STYLES
# ------

styles =

  section:

    base:
      display: 'inline-block'
      height: '100%'
      boxSizing: 'content-box'
      transition: 'width 0.2s'
      borderRight: '1px solid white'

      ':hover':
        background: '#1C6DAD'