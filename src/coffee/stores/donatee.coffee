Reflux         = require 'Reflux'
_              = require 'lodash'
DonateeActions = require 'actions/donatee'

_donatees = []

module.exports = Reflux.createStore

  listenables: DonateeActions

  getInitialState: ->
    _donatees

  create: (donatee) ->
    unless _.any( _donatees, (d) -> d.id == donatee.id )
      _donatees.push _.extend( {}, donatee )
      @trigger _donatees

  update: (props) ->
    # Get index of video to update
    index = _donatees.indexOf _.find( _donatees, (donatee) -> props.id == donatee.id )
    # Validations
    delete props.percent if isNaN(props.percent) or parseInt(props.percent) < 0
    # Update
    _donatees[index] = _.extend _donatees[index], props
    # Callback
    @trigger _donatees

  destroy: (id) ->
    _.remove _donatees, (donatee) -> donatee.id == id
    @trigger _donatees