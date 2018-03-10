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
    has %w{from:reply.github.com}
    label 'accounts/github'
  }
  filter {
    has %w{from:noreply@github.com}
    label 'accounts/github'
  }
  filter {
    has %w{from:no-reply-epetitions@digital.cabinet-office.gov.uk}
    label 'misc/hm petitions'
  }
  filter {
    has %w{subject:"Website Contact Message" from:daibach.co.uk}
    label 'misc/website-contact'
    never_spam
  }
  filter {
    has %w{subject:"Website Contact Messages" from:daibach.co.uk}
    label 'misc/website-contact'
    never_spam
  }
  filter {
    has %w{subject:"Domain Expiry Alert" from:daibach.co.uk}
    label 'deletable/other-notifications'
    never_spam
  }
end

puts fs.generate
