#!/bin/env ruby

require 'rubygems'
require 'gmail-britta'

if File.exist?(File.expand_path("~/.my-email-addresses.rb"))
  require "~/.my-email-addresses.rb"
else
  # Some fake constants to let you run this (-:
  MY_EMAILS = %w[test@example.com test.tester@example.com]
end

fs = GmailBritta.filterset(:me => MY_EMAILS) do

  filter {
    twitter_emails = %w{
      postmaster.twitter.com
      notify@twitter.com
      info@twitter.com
    }
    has [{:or => "from:(#{twitter_emails.join("|")})"}]
    label 'deletable/twitter'
  }
  filter {
    has %w{from:facebookmail.com}
    label 'deletable/facebook-linkedin'
  }
  filter {
    linkedin_emails = %w{
      linkedin.com
      em.linkedin.com
      e.linkedin.com
    }
    has [{:or => "from:(#{linkedin_emails.join("|")})"}]
    label 'deletable/facebook-linkedin'
  }
  filter {
    has %w{from:wordpress.com}
    label 'deletable/wordpress'
  }
  filter {
    has %w{from:tumblr.com}
    label 'deletable/other-social'
  }
  filter {
    has %w{from:fitbit.com}
    label 'deletable/other-social'
  }
  filter {
    has %w{from:yammer.com}
    label 'deletable/other-social'
  }
  filter {
    has %w{from:foursquare.com}
    label 'deletable/other-social'
  }
  filter {
    has %w{from:untappd.com}
    label 'deletable/other-social'
  }
  #chromaroma
  filter {
    has %w{from:slidesharemail.com}
    label 'deletable/other-social'
  }
  filter {
    has %w{from:flickr.com}
    label 'deletable/other-social'
  }
  filter {
    has %w{from:toby.barnes@wearemudlark.com "Chromaroma"}
    label 'deletable/other-social'
  }
  filter {
    has %w{from:alerts@lanyrd.com}
    label 'deletable/other-social'
  }
  filter {
    has %w{"added you on Google+"}
    label 'deletable/other-social'
  }
  filter {
    has %w{from:auto-message@eventbrite.com}
    label 'deletable/other-social'
  }
  filter {
    has %w{from:calendar-notification@google.com}
    label 'deletable/calendar'
  }
  filter {
    has %w{"Invitation from Google Calendar"}
    label 'deletable/calendar'
  }
  filter {
    has %w{subject:"Updated Invitation"}
    label 'deletable/calendar'
  }
  filter {
    has %w{filename:invite.ics}
    label 'deletable/calendar'
  }
  filter {
    has %w{from:today@sunrise.im}
    label 'deletable/sunrise'
  }
  filter {
    has %w{from:paypal@e.paypal.co.uk}
    label 'deletable/other-notifications'
  }
  filter {
    has %w{from:gis@monmouthshire.gov.uk}
    label 'deletable/other-notifications'
  }
  filter {
    has %w{from:updates.hungryhouse.co.uk}
    label 'deletable/other-notifications'
  }
  filter {
    has %w{from:info.tfl.gov.uk}
    label 'deletable/other-notifications'
  }
  filter {
    has %w{from:newrelic.com}
    label 'deletable/other-notifications'
  }
  filter {
    has %w{from:dropbox.com}
    label 'deletable/other-notifications'
  }
  filter {
    has %w{from:trello.com}
    label 'deletable/other-notifications'
  }
  filter {
    has %w{subject:"Change Request" from:nobody@google.com}
    label 'deletable/other-notifications'
  }
  filter {
    has %w{from:noreply@insideicloud.icloud.com}
    label 'deletable/other-notifications'
  }
  filter {
    has %w{from:nominet@nominet.org.uk}
    label 'deletable/other-notifications'
  }


end

puts fs.generate
