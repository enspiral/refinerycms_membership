# Memberships engine for Refinery CMS.

__A role based membership engine for [refinerycms](http://refinerycms.com)__

## Installation

* To your Gemfile add: 
* gem 'refinerycms-memberships', '1.0', :git => 'git@github.com:ruby-fu-ninja/refinerycms_membership.git'
* Then run:
* bundle install
* rails generate refinerycms_memberships
* rake db:migrate

## Features

* Member authentication + dashboard + profile editing
* Member adminisistration (approve, extend, reject, cancel, delete)
* Role Management (Add new roles and assign them to pages) 
* Email Management (edit email content + configure which emails are sent + to whom)
* Campaign Monitor Support by defining CAMPAIGN_MONITOR_LIST_ID

## Settings

* 'membership_timed_accounts' - Member accounts have a fixed time period
* 'membership_approve_accounts' - Member accounts must be approved by admin
