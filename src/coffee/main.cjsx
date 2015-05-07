# -------
# IMPORTS
# -------

# Vendor
React            = require 'react'
attach_fastclick = require 'fastclick'

# Models
DonationCategories = require 'models/donation_categories'
DonationCategory   = require 'models/donation_category'

# Components
Dashboard = require './components/dashboard'

# ----------
# INITIALIZE
# ----------

attach_fastclick document.body

donation_categories = new DonationCategories [
  new DonationCategory
    title: 'General'
]

# ------
# RENDER
# ------

React.render <Dashboard collection={donation_categories}/>, document.getElementById('dashboard')