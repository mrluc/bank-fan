Twit = require 'twit'
class BankFan
  scores:
    sue:-4, sued:-4, overdraft:-4, fees:-4, fee:-4, overdrawn:-4, bot:-4, foreclose:-8, foreclosure:-8, foreclosing:-8, lie: -4, 
    account: -4, sucked:-4, sucks:-4, cares: 0, god: -4, routing: -4, thieves:-4, thieving: -8, nypd: -8
    help:-3, checking:-3, app:15, criminals: -8, banks: -1, unacceptable: -4, atm: -8, atms:-8

  constructor: (credentials, opts) ->
    @[k] = v for k, v of opts
    @twit = new Twit credentials
    @twit.get 'application/rate_limit_status', (err, {@resources}, res)=> @log @resources
    @annoy()

  annoy: =>
    stream = @twit.stream 'statuses/filter', {@track, @lang}
    stream.on 'tweet', (tweet) =>
      tweet = tweet.retweeted_status if tweet.retweeted_status?
      if tweet?.user?.id?
        @respond_if_necessary tweet , (args...)=> @log "RESPONDED TO", args, tweet

  respond_if_necessary: ( {id, text, user:{screen_name}}, after) =>
    require('sentiment') text, @scores, (err, result) =>
      @log "SENTIMENT ANALYSIS: ", text, screen_name, JSON.stringify result
      if Math.abs(result.score) > @intensity
        status = if -(@intensity) > result.score
          "@#{screen_name} maybe #{@shame_screen_name} has some input here? http://goo.gl/OGbaP"
        else "@#{screen_name} #{@shame_name} really rocks. http://goo.gl/OGbaP"
        @log "TWEETING #{status}"
        @twit.post( 'statuses/update', {in_reply_to_status_id: id, status}, after) if @live

  log: (args...) -> console.log s for s in args

module.exports = BankFan

