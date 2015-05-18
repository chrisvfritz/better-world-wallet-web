# -------
# IMPORTS
# -------

# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'
Radium        = require 'radium'
_sortBy       = require 'lodash/collection/sortBy'

# Components
Section = require './Sections/Section'

# ---------
# COMPONENT
# ---------

module.exports = React.createClass Radium.wrap
  displayName: 'Sections'

  mixins: [ BackboneMixin ]

  # ------
  # RENDER
  # ------

  render: ->
    sortedDonatees = _sortBy @getCollection().models, (donatee) -> -donatee.decimalPercent()
    <div style={ styles.wrapper.base }>
      {
        sortedDonatees.map (donatee) ->
          <Section model={ donatee }/>
      }
    </div>

# ------
# STYLES
# ------

styles =

  wrapper:

    base:
      width: '100%'
      height: '100%'
      whiteSpace: 'nowrap'
      overflow: 'hidden'