Requirements
------------
- [Sign up](https://app.bsg.hk/auth/registration) for a free BSG account
- Create a new `access_key` (live or test access key)

Examples
--------
First, you need to create an instance of **BSG::Client**. Be sure to replace **YOUR_ACCESS_KEY** with something real in the bottom example.

```ruby
require 'pp'              # Only needed for this example
client = BSG::Client.new(YOUR_ACCESS_KEY)
```

That's easy enough. Now we can query the server for information.


##### Messages
Chances are that the most common use you'll have for this API client is the ability to send out text messages. For that purpose we have created the **message_create** method, which takes the required *originator*, one or more *msisdn* and a *body* text for parameters.


```ruby
pp client.message_create(destination: 'phone', originator: 'SENDER', body: 'message text', msisdn: '380662341945', reference: 'MyReference')

#<BSG::MESSAGE:0x007faad71306f8
 @error=0,
 @id="172",
 @price="0.2300000",
 @currency="EUR">
```


