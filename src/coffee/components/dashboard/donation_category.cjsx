# Vendor
React         = require 'react'
BackboneMixin = require 'backbone-react-component'

# Bootstrap
Row = require 'react-bootstrap/lib/Row'
Col = require 'react-bootstrap/lib/Col'

# Components
YoutubeChannelSearch        = require './donation_category/youtube_channel_search'
YoutubeChannelSearchResults = require './donation_category/youtube_channel_search_results'
DonationAmountInput         = require './donation_category/donation_amount_input'
DonateesList                = require './donation_category/donatees_list'

module.exports = React.createClass
  displayName: 'DonationCategory'

  mixins: [ BackboneMixin ]

  getInitialState: ->
    search_query: ''
    search_results: []

  update_search: (new_query, new_results=[]) ->
    @setState
      search_query: new_query || @state.search_query
      search_results: new_results

  clear_search: ->
    @setState
      search_query: ''
      search_results: []

  handle_title_change: (event) ->
    @getModel().set
      title: event.target.value

  render: ->

    <div className='donation_category card'>
      <Row>
        <Col md=6>
          <input
            value     = { @props.model.attributes.title }
            onChange  = { @handle_title_change }
            className = 'donation_category_title'
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
        collection            = { @props.model.attributes.donatees }
        channels              = { @state.search_results            }
        clear_search_callback = { @clear_search                    }
      />
      <h4 className='donation_amount_heading'>
        Donating
        <DonationAmountInput
          amount = { @props.model.attributes.donation }
        />
        to
      </h4>
      <DonateesList
        collection = { @props.model.attributes.donatees }
        donation   = { @props.model.attributes.donation }
      />
    </div>