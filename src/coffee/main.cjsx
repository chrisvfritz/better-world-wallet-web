# -------
# IMPORTS
# -------

# Vendor
React            = require 'react'
attach_fastclick = require 'fastclick'

# Models
DonationCategories = require 'models/DonationCategories'
DonationCategory   = require 'models/DonationCategory'

# Components
Dashboard = require './components/Dashboard'

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

React.render <Dashboard collection={ donation_categories }/>, document.getElementById('dashboard')