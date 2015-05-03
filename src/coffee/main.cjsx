# Vendor
React = require 'react'

# Models
DonationCategories = require 'models/donation_categories'
DonationCategory   = require 'models/donation_category'

# Components
Dashboard = require './components/dashboard'

donation_categories = new DonationCategories [
  new DonationCategory
    title: 'General'
]

window.arst = donation_categories

React.render <Dashboard collection={donation_categories}/>, document.getElementById('dashboard')