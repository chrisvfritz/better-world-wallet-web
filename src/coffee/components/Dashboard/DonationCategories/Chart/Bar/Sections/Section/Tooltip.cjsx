# -------
# IMPORTS
# -------

# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'

# Bootstrap
OverlayTrigger = require 'react-bootstrap/lib/OverlayTrigger'
Tooltip        = require 'react-bootstrap/lib/Tooltip'

# ---------
# COMPONENT
# ---------

module.exports = React.createClass
  displayName: 'Tooltip'

  mixins: [ BackboneMixin ]

  # ------
  # RENDER
  # ------

  render: ->
    <OverlayTrigger
      overlay   = { <Tooltip>{ @getModel().get 'title' }</Tooltip> }
      placement = 'top'
    >
      <div style={height: '100%', width: '100%'}></div>
    </OverlayTrigger>
