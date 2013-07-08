Twit = require 'twit'
sentiment = require 'sentiment'

class BankFan

  scores:
    sue:-4, overdraft:-4, fees:-4, fee:-4, overdrawn:-4, bot:-4,
    foreclose:-8, foreclosure:-8, foreclosing:-8, lie: -4, thieves:-4,
    account: -4, sucked:-4, sucks:-4, cares: 0, god: -4, routing: -4,
    help:-3, checking:-3, app:15, criminals: -8, banks: -1, unacceptable: -4, atm: -8, atms:-8
    thieving: -8, nypd: -8

  constructor: (credentials, opts) ->
    @[k] = v for k, v of opts
    @twit = new Twit credentials
    @annoy()

  check_limits: => @twit.get 'application/rate_limit_status', (err, {@resources}, res)=> @log @resources

  annoy: =>
    @check_limits()
    counter = 0
    stream = @twit.stream 'statuses/filter', {@track, @lang}
    stream.on 'limit', @log
    stream.on 'warning', @log
    stream.on 'tweet', (tweet) =>
      tweet = tweet.retweeted_status if tweet.retweeted_status?
      if tweet?.user?.id?
        @respond_if_necessary tweet , =>
          @log "RESPONDED TO", tweet
          process.exit() if (counter++) > 1000

  respond_if_necessary: ( {id, text, user:{screen_name}}, after) =>
    sentiment text, @scores, (err, result) =>
      @log "SENTIMENT ANALYSIS: ", text, screen_name, JSON.stringify result
      if Math.abs(result.score) > @intensity
        status = if -(@intensity) > result.score
          "@#{ screen_name } maybe @BofA_Help has some input here? http://goo.gl/OGbaP"
        else "@#{ screen_name } Bank of America really rocks. http://goo.gl/OGbaP"
        
        @say {in_reply_to_status_id: id, status}, after

  say: (status, after) =>
    log_then = (args...) => @log args; after()
    return @twit.post( 'statuses/update', status, log_then ) if @live
    log_then status

  log: (args...) -> console.log s for s in args

opts = live: yes, lang:'en', intensity: 2, track: 'BofA,BofA_Help,Bank of America,BankOfAmerica'
bot = new BankFan require('./twitter_config'), opts
