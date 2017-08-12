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
    amazon_emails = %w{
      auto-shipping@amazon.co.uk
      auto-confirm@amazon.co.uk
      order-update@amazon.co.uk
      digital-no-reply@amazon.co.uk
      noreply@despatch.net
      yourdelivery@dpd.co.uk
      aws-receivables@amazon.com
      aws-receivables-support@email.amazon.com
      shipment-tracking@amazon.co.uk
    }
    has [{:or => "from:(#{amazon_emails.join("|")})"}]
    label 'billing & banking/amazon'
    never_spam
  }


  filter {
    apple_emails = %w{
      do_not_reply@itunes.com
      do_not_reply@apple.com
      coventgarden@apple.com
      stratfordcity@apple.com
      stdavids2@apple.com
    }
    has [{:or => "from:(#{apple_emails.join("|")})"}]
    label 'billing & banking/apple'
    never_spam
  }
  filter {
    has %w{from:email.apple.com subject:"invoice"}
    label 'billing & banking/apple'
    never_spam
  }



  filter {
    comms_provider_emails = %w{
      O2Shop@o2.com
      noreply@isetup.o2.co.uk
      support@plus.net
      ebilling@bt.com
      no-reply@bt.com
      btcomms@btcomms.com
      no_reply@giffgaff.com
      tubewifi@virginmedia.com
    }
    has [{:or => "from:(#{comms_provider_emails.join("|")})"}]
    label 'billing & banking/comms'
    never_spam
  }



  filter {
    has %w{support-en@support.gandi.net}
    label 'billing & banking/gandi'
  }



  filter {
    has %w{from:hello@bulb.co.uk}
    label 'billing & banking/house'
  }
  filter {
    has %w{from:thameswater.co.uk}
    label 'billing & banking/house'
  }



  filter {
    takeaway_emails = %w{
      deliveroo.com
      deliveroo.co.uk
      dominos.co.uk
      hungryhouse.co.uk
      just-eat.co.uk
      just-eat.info
    }
    has [{:or => "from:(#{takeaway_emails.join("|")})"}]
    label 'billing & banking/takeaway'
    never_spam
  }



  filter {
    travel_emails = %w{
      accorhotels.reservation@accor.com
      noreply@eastcoast.co.uk
      webmaster@travelodge.co.uk
      autoresponse@tfl.gov.uk
      zipcar.com
      mytaxi.com
      mytaxi.net
      enterprise.com
    }
    has [{:or => "from:(#{travel_emails.join("|")})"}]
    label 'billing & banking/travel'
    never_spam
  }
  filter {
    has %w{from:Expedia@uk.expediamail.com subject:confirmation}
    label 'billing & banking/travel'
    never_spam
  }.otherwise {
    has %w{from:Expedia@uk.expediamail.com subject:"final\ details"}
    label 'billing & banking/travel'
    never_spam
  }.otherwise {
    has %w{from:Expedia@uk.expediamail.com}
    label 'deletable/newsletters'
  }
  filter {
    has %w{from:info@mail.hotels.com subject:confirmation}
    label 'billing & banking/travel'
    never_spam
  }.otherwise {
    has %w{from:info@mail.hotels.com subject:"final\ details"}
    label 'billing & banking/travel'
    never_spam
  }.otherwise {
    has %w{from:info@mail.hotels.com}
    label 'deletable/newsletters'
  }

  filter {
    has %w{from:donotreply@tfl.gov.uk}
    label 'billing & banking/notices'
  }


  filter {
    online_shop_emails = %w{
      support@github.com
    }
    has [{:or => "from:(#{online_shop_emails.join("|")})"}]
    label 'billing & banking'
    never_spam
  }
  filter {
    has %w{-list:"mcsv.net" from:noreply@eebria.com}
    label 'billing & banking'
  }

end

puts fs.generate
