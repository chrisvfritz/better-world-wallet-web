# -------
# IMPORTS
# -------

# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'
StyleSheet    = require 'react-style'

# Bootstrap
Row = require 'react-bootstrap/lib/Row'
Col = require 'react-bootstrap/lib/Col'

# Components
Card                        = require 'components/shared/card'
YoutubeChannelSearch        = require './donation_category/youtube_channel_search'
YoutubeChannelSearchResults = require './donation_category/youtube_channel_search_results'
DonationAmountInput         = require './donation_category/donation_amount_input'
DonateesList                = require './donation_category/donatees_list'

# ---------
# COMPONENT
# ---------

module.exports = React.createClass
  displayName: 'DonationCategory'

  mixins: [ BackboneMixin ]

  # ---------
  # LIFECYCLE
  # ---------

  getInitialState: ->
    search_query: ''
    search_results: []

  # -------
  # ACTIONS
  # -------

  update_search: (new_query, new_results=[]) ->
    @setState
      search_query: if new_query != null then new_query else @state.search_query
      search_results: new_results

  clear_search: ->
    @setState
      search_query: ''
      search_results: []

  handle_title_change: (event) ->
    @getModel().set
      title: event.target.value

  # ------
  # RENDER
  # ------

  render: ->

    <Card>
      <Row>
        <Col md=6>
          <input
            value     = { @getModel().get 'title' }
            onChange  = { @handle_title_change    }
            styles    = { styles.title            }
            type      = 'text'
          />
        </Col>
        <Col md=6>
          <YoutubeChannelSearch
            query                 = { @state.search_query }
            search_callback       = { @update_search      }
            clear_search_callback = { @clear_search       }
          />
        </Col>
      </Row>
      <YoutubeChannelSearchResults
        channels              = { @state.search_results }
        clear_search_callback = { @clear_search         }
      />
      <h4 styles={styles.donation_heading}>
        <span styles={[ styles.donation_text.base, styles.donation_text.first ]}>
          Donating
        </span>
        <span styles={[ styles.donation_text.base, styles.donation_text.input ]}>
          <DonationAmountInput/>
        </span>
        <span styles={[ styles.donation_text.base, styles.donation_text.last ]}>
          to
        </span>
      </h4>
      <DonateesList
        collection = { @getModel().get 'donatees' }
        donation   = { @getModel().get 'donation' }
      />
    </Card>

# ------
# STYLES
# ------

styles = StyleSheet.create

  title:
    width: '100%'
    boxShadow: 'none'
    border: 'none'
    padding: 0
    fontSize: 24
    color: '#333'
    lineHeight: '34px'
    fontWeight: 500
    outline: 'none'

  donation_heading:
    margin: '10px 0'
    display: 'tabln'

  donation_text:

    base:
      display: 'table-cell'
      verticalAlign: 'middle'
      padding: '0 4px'

    first:
      paddingLeft: 0

    last:
      paddingRight: 0

    input:
      width: '100%'
