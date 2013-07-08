BankFan = require './lib/bankfan'
new BankFan require('./twitter_config'),
  live: yes
  lang:'en'
  # emotion over or under this intensity score triggers the bot
  intensity: 2
  track: 'BofA,BofA_Help,Bank of America,BankOfAmerica'
  shame_screen_name: '@BofA_Help'
  shame_name: 'Bank of America'
  shame_link: 'http://goo.gl/OGbaP'