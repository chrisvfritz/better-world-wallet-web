# -------
# IMPORTS
# -------

# Vendor
React      = require 'react'
StyleSheet = require 'react-style'
D3         = require 'd3'

# ---------
# COMPONENT
# ---------

module.exports = React.createClass
  displayName: 'Bar'

  # ----------
  # VALIDATION
  # ----------

  propTypes:
    donation: React.PropTypes.number

  # ------
  # RENDER
  # ------

  dynamic_styles: ->
    width: @props.width + '%'

  render: ->
    <div styles={[ styles.bar.base, @dynamic_styles() ]}>
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

  text:

    base:
      position: 'absolute'
      lineHeight: '30px'
      whiteSpace: 'nowrap'

    left:
      right: 10
      color: 'white'

    right:
      left: '100%'
      marginLeft: 10