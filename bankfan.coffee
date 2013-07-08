Twit = require 'twit'
sentiment = require 'sentiment'
{Module} = require './extensions'

class BankFan extends Module

  scores:
    sue:-4, overdraft:-4, fees:-4, fee:-4, overdrawn:-4, bot:-4,
    foreclose:-8, foreclosure:-8, foreclosing:-8, lie: -4, thieves:-4,
    account: -4, sucked:-4, sucks:-4, cares: 0, god: -1, routing: -4,
    help: -3, checking: -3
  constructor: (credentials, opts)->
    @[k] = v for k, v of opts
    @twit = new Twit credentials
    @annoy()

  check_limits: => @twit.get 'application/rate_limit_status', (err, {@resources}, res)=> @log @resources
  valid_tweet: (t)-> t?.user?.id?

  annoy: =>
    @check_limits()
    counter = 0
    stream = @twit.stream 'statuses/filter', {@track, @lang}
    stream.on 'tweet', (tweet)=>
      if @valid_tweet tweet
        @if_we_should_respond tweet , =>
          @respond_to tweet, -> process.exit() if (counter++) > 10

  if_we_should_respond: ({text, user:{screen_name}}, respond)=>
    sentiment text, @scores, (err, result)=>
      @log "SENTIMENT ANALYSIS: ", text, screen_name, JSON.stringify result
      respond() if -(@intensity) > result.score or result.score > @intensity  

  respond_to: ({id, user: {screen_name}}, after) =>
    status =
      in_reply_to_status_id: id
      status: "Hey @#{ screen_name }, maybe @BofA_Help has some input here? http://goo.gl/OGbaP"
    @say status, after

  say: (status, after)=>
    log_then = (args...)=> @log args; after()
    return @twit.post( 'statuses/update', status, log_then ) if @live
    log_then status

  log: (args...)-> console.log s for s in args

opts = live: yes, lang:'en', intensity: 3, track: 'BofA,BofA_Help,Bank of America,BankOfAmerica'
bot = new BankFan require('./twitter_config'), opts
