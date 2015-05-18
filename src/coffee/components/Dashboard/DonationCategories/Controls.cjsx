# -------
# IMPORTS
# -------

# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'
Radium        = require 'radium'

# Components
Card              = require 'components/shared/Card'
DonationTotal     = require './Controls/DonationTotal'
AddCategoryButton = require './Controls/AddCategoryButton'

# ---------
# COMPONENT
# ---------

module.exports = React.createClass Radium.wrap
  displayName: 'Controls'

  mixins: [ BackboneMixin ]

  # ------
  # RENDER
  # ------

  render: ->
    <Card>
      <div style={ styles.total.container.base }>
        <DonationTotal style={[ styles.total.text.base, styles.total.text.first ]}/>
        <AddCategoryButton/>
      </div>
    </Card>

# ------
# STYLES
# ------

styles =

  total:

    container:

      base:
        display: 'table'

    text:

      base:
        display: 'table-cell'
        lineHeight: 1
        verticalAlign: 'middle'

      first:
        width: '100%'