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
    clickCallback: React.PropTypes.func.isRequired

  # ------
  # RENDER
  # ------

  render: ->
    <Button
      onClick = { @props.clickCallback }
      style   = { styles.button.base   }
    >
      <Glyphicon glyph='remove-circle'/>
    </Button>

# ------
# STYLES
# ------

styles =

  button:

    base:
      height: 34