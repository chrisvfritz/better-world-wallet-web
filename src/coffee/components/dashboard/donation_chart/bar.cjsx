# -------
# IMPORTS
# -------

# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'
StyleSheet    = require 'react-style'

# ---------
# COMPONENT
# ---------

module.exports = React.createClass
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

  dynamic_bar_styles: ->
    width: @props.width + '%'

  dynamic_section_styles: (donatee) ->
    width: donatee.decimal_percent() * 100 + '%'

  render: ->
    <div styles={[ styles.bar.base, @dynamic_bar_styles() ]}>
      {
        @getCollection().models.map (donatee) =>
          <div
            key    = { donatee.cid }
            styles = {[ styles.section.base, @dynamic_section_styles(donatee) ]}
          >
          </div>
      }
      <span styles={[ styles.text.base, if @props.width < 50 then styles.text.right else styles.text.left ]}>
        { @props.title }
      </span>
    </div>

# ------
# STYLES
# ------

styles = StyleSheet.create

  bar:

    base:
      position: 'relative'
      height: 30
      marginTop: 10
      background: '#2377BA'

  section:

    base:
      display: 'inline-block'
      height: '100%'
      borderRight: '1px solid white'

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