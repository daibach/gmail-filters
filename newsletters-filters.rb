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
    newsletter_emails = %w{
      news_europe@insideapple.apple.com
      amazon-offers@amazon.co.uk
      no-reply-aws@amazon.com
      store_news@amazon.co.uk
      aws-marketing-email-replies@amazon.com
      martinsmoneytips@moneysavingexpert.com
      announce@parallels-universe.com
      no-reply@dropboxmail.com
      no-reply@kickstarter.com
      arranwhisky.com
      noreply@medium.com
      news@grindandco.com
      oreilly@post.oreilly.com
      openrightsgroup.org
      ocado@ocadomail.com
      ecomm.bt.com
    }
    has [{:or => "from:(#{newsletter_emails.join("|")})"}]
    label 'deletable/newsletters'
  }
  filter {
    has %w{from:GOVUK@public.govdelivery.com}
    label 'deletable/newsletters'
  }
  filter {
    has %w{from:gareth@morethanseven.net}
    label 'mailinglist/devops'
  }
  filter {
    has %w{from:roo.reynolds@gmail.com}
    label 'mailinglist/roosletter'
  }

end

puts fs.generate
