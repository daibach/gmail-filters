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
      info@email.moo.com
      moosletter@moo.com
      amazon-offers@amazon.co.uk
      no-reply-aws@amazon.com
      store-news@amazon.co.uk
      vfe-campaign-response@amazon.co.uk
      martinsmoneytips@moneysavingexpert.com
      promotions@mail.pizzaexpress.com
      offers@send.dominosemail.co.uk
      noreply@brainsoffers.com
      noreply@sabrain.com
      announce@parallels-universe.com
      leclub@accor-mail.com
      info@mail.eastcoast.co.uk
      news.accorhotels@accor-mail.com
      news.ibis@accor-mail.com
      news@wru.co.uk
      bot@recalledproducts.org
      netmag@futuremail.net
      alumni@swansea.ac.uk
      aboutme@about.me
      no-reply@dropboxmail.com
      no-reply@kickstarter.com
      knowledgehub@local.gov.uk
    }
    has [{:or => "from:(#{newsletter_emails.join("|")})"}]
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
  filter {
    has %w{list:open-transport.lists.okfn.org}
    label 'mailinglist/opentransport'
  }.archive_unless_directed

  filter {
    has %w{headoffice@keatons.com}
    label 'deletable/newsletters/deal-with'
  }

end

puts fs.generate