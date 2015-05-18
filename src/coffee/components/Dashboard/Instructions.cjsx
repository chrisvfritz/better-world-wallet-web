# -------
# IMPORTS
# -------

# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'
Radium        = require 'radium'

# ---------
# COMPONENT
# ---------

module.exports = React.createClass Radium.wrap
  displayName: 'Instructions'

  mixins: [ BackboneMixin ]

  # ------
  # RENDER
  # ------

  render: ->
    <div>
      <h3 style={ styles.welcome.heading }>
        Welcome!
      </h3>
      <p style={[ @getCollection().totalDonatees() > 0 and styles.welcome.paragraph.last ]}>
        As you add donations and categories, a summary graph will appear below to visualize your values as reflected in how you vote with your money.
      </p>
      {
        if @getCollection().totalDonatees() is 0
          <p style={ styles.welcome.paragraph.last }>
            Try adding your first channel now in the <code>Add a new channel...</code> input.
          </p>
      }
    </div>

# ------
# STYLES
# ------

styles =

  welcome:

    heading:
      marginTop: 0

    paragraph:

      last:
        marginBottom: 0