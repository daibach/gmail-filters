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
      info@news.moo.com
      noreply@amazon.co.uk
      amazon-offers@amazon.co.uk
      no-reply-aws@amazon.com
      store_news@amazon.co.uk
      vfe-campaign-response@amazon.co.uk
      aws-marketing-email-replies@amazon.com
      martinsmoneytips@moneysavingexpert.com
      promotions@mail.pizzaexpress.com
      offers@send.dominosemail.co.uk
      noreply@brainsoffers.com
      announce@parallels-universe.com
      leclub@accor-mail.com
      info@mail.eastcoast.co.uk
      firstgreatwestern@e.firstgreatwestern.co.uk
      news.accorhotels@accor-mail.com
      news.ibis@accor-mail.com
      news@wru.sportmailer.com
      retail@wru.sportmailer.com
      netmag@futuremail.net
      newsletter@creativebloq.com
      alumni@swansea.ac.uk
      aboutme@about.me
      no-reply@dropboxmail.com
      no-reply@kickstarter.com
      knowledgehub@local.gov.uk
      news@barburrito.co.uk
      arranwhisky.com
      queenelizabetholympicpark-london.co.uk
      microsoftuk@e-mail.microsoft.com
      John_Lewis@em.johnlewis.com
      thefrontrow@england2015.rugbyworldcup.com
      events@cratebrewery.com
      supportlondon@uber.com
      waitrose@em.waitrose.com
      mywaitrose@em.waitrose.com
      resources@bitly.com
      noreply@medium.com
      email.thetimes.co.uk
      info@eebria.com
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
    has %w{from:digital.cabinet-office.gov.uk subject:"teacamp"}
    label 'deletable/newsletters'
  }
  filter {
    has %w{from:dxw.com subject:"teacamp"}
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
