# -------
# IMPORTS
# -------

# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'
Radium        = require 'radium'

# Bootstrap
Table = require 'react-bootstrap/lib/Table'

# Components
Donatee = require './List/Donatee'

# ---------
# COMPONENT
# ---------

module.exports = React.createClass Radium.wrap
  displayName: 'DonateesList'

  mixins: [ BackboneMixin ]

  # ------
  # RENDER
  # ------

  render: ->
    <Table
      style   = { styles.table.base }
      striped = true
    >
      <tbody>
        {
          @getCollection().map (donatee) =>
            <Donatee
              key      = { donatee.cid                }
              model    = { donatee                    }
              donation = { @getModel().get 'donation' }
            />
        }
      </tbody>
    </Table>

# ------
# STYLES
# ------

styles =

  table:

    base:
      marginLeft: -3
      marginBottom: 0