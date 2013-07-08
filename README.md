BankFan                                                                                              
========                                                                                             

The code behind [@BofA_Fan](https://twitter.com/BofA_Fan).

BankFan is a little proof-of-concept Twitter bot in the spirit of Bank of America's
great [@BofA_Help bot](https://twitter.com/BofA_Help),
which listens to a keyword stream and tweets replies,
with ... [results](http://eksith.wordpress.com/2013/07/07/bank-of-america-bot/).
                                                                                                     
This bot is definitely abuse under the Twitter
[Automation Best Practices](https://support.twitter.com/groups/56-policies-violations/topics/237-guidelines/articles/76915-automation-rules-and-best-practices),
just like the original @Bofa_Help bot. Be advised that running
it will probably get your account suspended every few hours unless you make 
the messages more diverse.

To run it, just add a file called `twitter_config.coffee` that looks like:                           
                                                                                                     
```coffeescript                                                                                      
module.exports =                                                                                     
  consumer_key: ''                                                                                   
  consumer_secret: ''                                                                                
  access_token: ''                                                                                   
  access_token_secret: ''                                                                            
```

You can fill in the values from any application in your dev.twitter.com account. Then run:

    coffee bankfan.coffee

## So, what'd you learn? 

That the Twitter API changes a *lot*. Beware your library selection. 

Oh, yeah, and something something social media customer service.

