# -------
# IMPORTS
# -------

# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'
Radium        = require 'radium'
_sortBy       = require 'lodash/collection/sortBy'

# Components
SectionTooltip = require './bar/section_tooltip'

# ---------
# COMPONENT
# ---------

module.exports = React.createClass Radium.wrap
  displayName: 'Bar'

  mixins: [ BackboneMixin ]

  # ----------
  # VALIDATION
  # ----------

  propTypes:
    donation: React.PropTypes.number

  # ------
  # RENDER
  # ------

  render: ->
    if @getCollection().length > 0
      <div style={[ styles.bar.base, @dynamic_bar_styles() ]}>
        {
          sorted_donatees = _sortBy @getCollection().models, (donatee) -> -donatee.decimal_percent()
          sorted_donatees.map (donatee) =>
            <div
              key   = donatee.cid
              style = {[ styles.section.base, @dynamic_section_styles(donatee) ]}
            >
              <SectionTooltip model={ donatee }/>
            </div>
        }
        <span style={[ styles.text.base, if @props.width < 50 then styles.text.right else styles.text.left ]}>
          { @props.title }
        </span>
      </div>
    else
      <span></span>

  # -------
  # HELPERS
  # -------

  dynamic_bar_styles: ->
    width: @props.width + '%'

  dynamic_section_styles: (donatee) ->
    width: donatee.decimal_percent() * 100 + '%'

# ------
# STYLES
# ------

styles =

  bar:

    base:
      position: 'relative'
      height: 30
      marginTop: 10
      background: '#ccc'

  section:

    base:
      display: 'inline-block'
      height: '100%'
      borderRight: '1px solid white'
      background: '#2377BA'

      ':hover':
        background: '#1C6DAD'

  text:

    base:
      position: 'absolute'
      lineHeight: '30px'
      padding: '0 10px'
      whiteSpace: 'nowrap'
      pointerEvents: 'none'

    left:
      right: 0
      textShadow: Array(10).join('0 0 10px #2377BA,').slice(0,-1)
      color: 'white'

    right:
      left: '100%'