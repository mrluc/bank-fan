BankFan                                                                                              
========                                                                                             

The code behind [@BofA_Fan](https://twitter.com/BofA_Fan).

BankFan is a little proof-of-concept Twitter bot in the spirit of Bank of America's
great [@BofA_Help bot](https://twitter.com/BofA_Help),
which listens to a keyword stream and tweets replies,
with ... [results](http://eksith.wordpress.com/2013/07/07/bank-of-america-bot/).

### Bot Behavior

The bot currently listens for mentions of Bank of America, or BofA, and 
then does sentiment analysis based on the [AFINN wordlist](http://neuro.imm.dtu.dk/wiki/AFINN).

For instance, the tweet:

> Protip:the @highmuseumofart is free 4 Bank of America users the 1st weekend of every month, & the new girl w/ a pearl earring exhib is great

... appears positive. Sentiment analysis confirms:

    SENTIMENT ANALYSIS:
    
    {"score":4,"comparative":0.15384615384615385,
     "tokens":["protipthe","highmuseumofart","is","free","","bank","of","america","users","the",
               "st","weekend","of","every","month","amp","the","new","girl","w","a","pearl",
               "earring","exhib","is","great"],
     "words":["free","great"],
     "positive":["free","great"],
     "negative":[]
    }

... and so BankFan responds positively, with a link to a news story about
another great Bank of America initiative: their bots!

> @screenName Bank of America really rocks. http://t.co/mzr134Z5hM

Meanwhile, the tweet:

> So the Bank of America ATM wants to play games w/me tonight &amp; take all my money I worked for all day today &amp; say it wasn't processed. Cool.

Is recognized as negative, because we've extended the wordlist 
with words like 'atm', 'checking', 'routing', etc. They need help, 
and we respond appropriately, alerting them to
the fantastic automated @BofA_Help service!

> @screenName maybe @BofA_Help has some input here? http://t.co/mzr134Z5hM


### That Sounds Pretty Fishy

This bot is definitely abuse under the Twitter
[Automation Best Practices](https://support.twitter.com/groups/56-policies-violations/topics/237-guidelines/articles/76915-automation-rules-and-best-practices),
just like the original @Bofa_Help bot. Be advised that running
it will probably get your account suspended every few hours unless you make 
the messages more diverse.

### So How Do I Run It

Install the BankFan library with:

    npm install bank-fan

And in the same directory, make a javascript file called `biggest_fan.js`:

```javascript
    BankFan = require('bank-fan');
    
    new BankFan( {
      consumer_key: '',
      consumer_secret: '',
      access_token: '',
      access_token_secret: ''
    }, {
      live: true,
      lang:'en',
      intensity: 2,
      track: 'BofA,BofA_Help,Bank of America,BankOfAmerica',
      shame_screen_name: '@BofA_Help',
      shame_name: 'Bank of America',
      shame_link: 'http://goo.gl/OGbaP'
    });
```

Then run your fan with

    node biggest_fan.js

You can fill in the values from any application in your dev.twitter.com account, 
where you will see those fields on the first page of any of your apps.


## So, what'd you learn? 

That the Twitter API changes a *lot*. Beware your library selection.

That Sentiment Analysis algorithms are more than 70% accurate,
but that humans only agree about 80% of the time -- making them
almost as good as humans, though even with the AFINN list, you
can tell that tiny messages make it harder.

Oh, yeah, and something something social media customer service.
