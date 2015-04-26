# Vendor
React = require 'React'

# Bootstrap
Button    = require 'react-bootstrap/lib/Button'
Glyphicon = require 'react-bootstrap/lib/Glyphicon'

module.exports = React.createClass
  displayName: 'ClearSearchButton'

  propTypes:
    click_callback: React.PropTypes.func.isRequired

  render: ->
    <Button onClick={ @props.click_callback }>
      <Glyphicon glyph='remove-circle'/>
    </Button>