# -------
# IMPORTS
# -------

# Vendor
React      = require 'React'
StyleSheet = require 'react-style'

# Bootstrap
Button    = require 'react-bootstrap/lib/Button'
Glyphicon = require 'react-bootstrap/lib/Glyphicon'

# ---------
# COMPONENT
# ---------

module.exports = React.createClass
  displayName: 'ClearSearchButton'

  # ------
  # RENDER
  # ------

  render: ->
    <Button
      onClick = { @props.click_callback }
      styles  = { styles.button         }
    >
      <Glyphicon glyph='remove-circle'/>
    </Button>

# ------
# STYLES
# ------

styles = StyleSheet.create

  button:
    height: 34