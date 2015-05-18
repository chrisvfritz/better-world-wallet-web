# -------
# IMPORTS
# -------

# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'
Radium        = require 'radium'

# Bootstrap
Row = require 'react-bootstrap/lib/Row'
Col = require 'react-bootstrap/lib/Col'

# Components
Card                        = require 'components/shared/card'
YoutubeChannelSearch        = require './Category/ChannelSearch'
YoutubeChannelSearchResults = require './Category/ChannelSearch/Results'
DonationAmountInput         = require './Category/DonationInput'
DonateesList                = require './Category/Donatees/List'

# ---------
# COMPONENT
# ---------

module.exports = React.createClass Radium.wrap
  displayName: 'DonationCategory'

  mixins: [ BackboneMixin ]

  # ---------
  # LIFECYCLE
  # ---------

  getInitialState: ->
    mobile: @isOnMobile()
    searchQuery: ''
    searchResults: []

  componentWillMount: ->
    @checkForMobile()

  componentDidMount: ->
    window.addEventListener 'resize', @checkForMobile
    React.findDOMNode(@).scrollIntoView true

  componentWillUnmount: ->
    window.removeEventListener 'resize', @checkForMobile

  # -------
  # ACTIONS
  # -------

  updateSearch: (newQuery, newResults=[]) ->
    @setState
      searchQuery: if newQuery? then newQuery else @state.searchQuery
      searchResults: newResults

  clearSearch: ->
    @setState
      searchQuery: ''
      searchResults: []

  handleTitleChange: (event) ->
    @getModel().set
      title: event.target.value

  # -------
  # HELPERS
  # -------

  isOnMobile: ->
    document.body.clientWidth < 992

  checkForMobile: ->
    @setState
      mobile: @isOnMobile()

  # ------
  # RENDER
  # ------

  render: ->
    <Card>
      <Row>
        <Col md=6>
          <input
            value     = { @getModel().get 'title' }
            onChange  = { @handleTitleChange      }
            style     = {[ styles.title.base, @state.mobile and styles.title.mobile ]}
            type      = 'text'
          />
        </Col>
        <Col md=6>
          <YoutubeChannelSearch
            query               = { @state.searchQuery }
            searchCallback      = { @updateSearch      }
            clearSearchCallback = { @clearSearch       }
          />
        </Col>
      </Row>
      <YoutubeChannelSearchResults
        channels            = { @state.searchResults }
        clearSearchCallback = { @clearSearch         }
      />
      {
        donatees = @getModel().get 'donatees'
        if donatees.length > 0
          <div>
            <h4 style={styles.donationHeading}>
              <span style={[ styles.donationText.base, styles.donationText.first ]}>
                Donating
              </span>
              <span style={[ styles.donationText.base, styles.donationText.input ]}>
                <DonationAmountInput/>
              </span>
              <span style={[ styles.donationText.base, styles.donationText.last ]}>
                to
              </span>
            </h4>
            <DonateesList
              collection = { donatees                   }
              donation   = { @getModel().get 'donation' }
            />
          </div>
      }
    </Card>

# ------
# STYLES
# ------

styles =

  title:

    base:
      width: '100%'
      boxShadow: 'none'
      border: 'none'
      padding: 0
      fontSize: 24
      color: '#333'
      lineHeight: '34px'
      fontWeight: 500
      outline: 'none'
      borderBottom: '1px dashed #ccc'

    mobile:
      marginBottom: 10

  donationHeading:
    margin: '10px 0'
    display: 'tabln'

  donationText:

    base:
      display: 'table-cell'
      verticalAlign: 'middle'
      padding: '0 4px'

    first:
      paddingLeft: 0

    input:
      width: '100%'

    last:
      paddingRight: 0