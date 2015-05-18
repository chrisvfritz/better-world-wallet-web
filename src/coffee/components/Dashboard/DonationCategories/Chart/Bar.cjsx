# -------
# IMPORTS
# -------

# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'
Radium        = require 'radium'
TweenState    = require 'react-tween-state'

# Components
Sections = require './Bar/Sections'
Label    = require './Bar/Label'

# ---------
# COMPONENT
# ---------

module.exports = React.createClass Radium.wrap
  displayName: 'Bar'

  mixins: [ BackboneMixin, TweenState.Mixin ]

  # ----------
  # VALIDATION
  # ----------

  propTypes:
    donation: React.PropTypes.number.isRequired

  # ---------
  # LIFECYCLE
  # ---------

  getInitialState: ->
    width: @props.width
    isTransitioning: false

  componentWillReceiveProps: (nextProps) ->
    if @props.width != nextProps.width
      @setState
        isTransitioning: true
    @tweenState 'width',
      duration: 200
      endValue: nextProps.width
      onEnd: =>
        @setState
          isTransitioning: false

  # -------
  # HELPERS
  # -------

  dynamicBarStyles: ->
    width: @getTweeningValue('width') + '%'

  # ------
  # RENDER
  # ------

  render: ->
    <div style={[ styles.bar.base, @dynamicBarStyles() ]}>
      <Sections/>
      <Label
        barWidth        = { @getTweeningValue 'width' }
        isTransitioning = { @state.isTransitioning    }
        text            = { @props.title              }
      />
    </div>

# ------
# STYLES
# ------

styles =

  bar:

    base:
      position: 'relative'
      height: 30
      marginTop: 10
      background: '#2377BA'