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
    has %w{from:alert@pingdom.com}
    label 'deletable/alert'
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
    linkedin_emails = %w{
      linkedin.com
      em.linkedin.com
      e.linkedin.com
      facebookmail.com
    }
    has [{:or => "from:(#{linkedin_emails.join("|")})"}]
    label 'deletable/facebook-linkedin'
  }


  filter {
    notifications_emails = %w{
      paypal@e.paypal.co.uk
      gis@monmouthshire.gov.uk
      updates.hungryhouse.co.uk
      info.tfl.gov.uk
      newrelic.com
      dropbox.com
      trello.com
      noreply@insideicloud.icloud.com
      nominet@nominet.org.uk
      no-reply@pingdom.com
      docs.google.com
      autoresponder@rightmove.com
      no-reply@certificates.amazon.com
    }
    has [{:or => "from:(#{notifications_emails.join("|")})"}]
    label 'deletable/other-notifications'
  }
  filter {
    has %w{subject:"Change Request" from:nobody@google.com}
    label 'deletable/other-notifications'
  }
  filter {
    has %w{(subject:"expires" OR subject:"expired") from:support-renew@gandi.net}
    label 'deletable/other-notifications'
  }
  filter {
    has %w{(subject:"domain name renewed") from:support-renew@gandi.net}
    label 'deletable/other-notifications'
  }
  filter {
    has %w{(subject:"[GANDI]") from:gandi.net}
    label 'deletable/other-notifications'
  }
  filter {
    has %w{from:paypal@mail.paypal.co.uk subject:"recent transactions"}
    label 'deletable/other-notifications'
  }
  filter {
    has %w{from:notifications@github.com}
    label 'deletable/github'
  }


  filter {
    social_emails = %w{
      auto-message@eventbrite.com
      alerts@lanyrd.com
      info@meetup.com
      noreply@mail.theguardian.com
      applepay.apple.com
      id.apple.com
      fitbit.com
      flickr.com
      foursquare.com
      instagram.com
      slidesharemail.com
      tumblr.com
      yammer.com
      untappd.com
      feedback@slack.com
    }
    has [{:or => "from:(#{social_emails.join("|")})"}]
    label 'deletable/other-social'
  }
  filter {
    has %w{email.apple.com -subject:"invoice:}
    label 'deletable/other-social'
  }
  filter {
    has %w{from:toby.barnes@wearemudlark.com "Chromaroma"}
    label 'deletable/other-social'
  }
  filter {
    has %w{"added you on Google+"}
    label 'deletable/other-social'
  }



  filter {
    twitter_emails = %w{
      postmaster.twitter.com
      notify@twitter.com
      info@twitter.com
      verify@twitter.com
    }
    has [{:or => "from:(#{twitter_emails.join("|")})"}]
    label 'deletable/twitter'
  }



  filter {
    has %w{from:wordpress.com}
    label 'deletable/wordpress'
  }

end

puts fs.generate
