# -------
# IMPORTS
# -------

# Vendor
React  = require 'react'
Radium = require 'radium'

# Bootstrap
Button    = require 'react-bootstrap/lib/Button'
Glyphicon = require 'react-bootstrap/lib/Glyphicon'

# ---------
# COMPONENT
# ---------

module.exports = React.createClass Radium.wrap
  displayName: 'ClearSearchButton'

  # ----------
  # VALIDATION
  # ----------

  propTypes:
    click_callback: React.PropTypes.func.isRequired

  # ------
  # RENDER
  # ------

  render: ->
    <Button
      onClick = { @props.click_callback }
      style   = { styles.button         }
    >
      <Glyphicon glyph='remove-circle'/>
    </Button>

# ------
# STYLES
# ------

styles =

  button:
    height: 34