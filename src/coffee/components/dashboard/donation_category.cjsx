# Vendor
React = require 'React'

# Actions
DonationCategoryActions = require 'actions/donation_category'

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

  propTypes:
    title: React.PropTypes.string.isRequired

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
    DonationCategoryActions.update event.target.value

  render: ->
    <div className='donation_category card'>
      <Row>
        <Col md=6>
          <input
            value     = { @props.title         }
            onChange  = { @handle_title_change }
            className = 'donation_category_title'
            type      = 'text'
          />
        </Col>
        <Col md=6>
          <YoutubeChannelSearch
            search_callback       = { @update_search      }
            clear_search_callback = { @clear_search       }
            query                 = { @state.search_query }
          />
        </Col>
      </Row>
      <YoutubeChannelSearchResults
        clear_search_callback = { @clear_search         }
        channels              = { @state.search_results }
      />
      <h4 className='donation_amount_heading'>
        Donating <DonationAmountInput/> to
      </h4>
      <DonateesList/>
    </div>