# -------
# IMPORTS
# -------

# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'

# Models
DonationCategory = require 'models/DonationCategory'

# Bootstrap
Button    = require 'react-bootstrap/lib/Button'
Glyphicon = require 'react-bootstrap/lib/Glyphicon'

# ---------
# COMPONENT
# ---------

module.exports = React.createClass
  displayName: 'AddCategoryButton'

  mixins: [ BackboneMixin ]

  # -------
  # ACTIONS
  # -------

  addNewCategory: ->
    @getCollection().add new DonationCategory()

  # ------
  # RENDER
  # ------

  render: ->
    <Button
      onClick = { @addNewCategory }
      style   = { @props.styles   }
      bsSize  = 'medium'
      bsStyle = 'primary'
    >
      <Glyphicon glyph='plus'/>
    </Button>