
# BSG Ruby Client

## Requirements

- [Sign up](https://app.bsg.world) for a free BSG account  
- Create a new **access_key** (live or test access key)

## Installation

Add this line to your `Gemfile`:

```ruby
gem 'bsg', git: 'https://github.com/sofiyareverse/bsg-ruby'
```

Then run:

```bash
bundle install
```

## Usage

Require the gem and create a client instance with your API key:

```ruby
require 'bsg'

client = BSG::Client.new(api_key: ENV['BSG_API_KEY'])
```

### Sending SMS

To send an SMS, use the `message_create` method with the following payload structure:

- `originator` — sender name (string, up to 14 chars, e.g. `"Name"`)  
- `body` — SMS text (string)  
- `validity` — message validity period in hours (string, `"1"` to `"72"`, optional, default `"72"`)  
- `tariff` — tariff number (string, `"0"` to `"9"`, optional, default `"0"`)  
- `destination` — fixed string `"phone"`  
- `msisdn` — recipient phone number without '+' sign (string)  
- `reference` — unique external ID for the message (string, max 32 chars, a-zA-Z0-9)  
- `send_time` — optional scheduled send time (ISO 8601 format string)  
- `options` — array of options (optional, empty array if none)

Example with test number and tariff:

```ruby
require 'securerandom'

payload = {
  originator: ENV['BSG_SENDER_NAME'], # your originator
  body: "Test SMS message",
  validity: "72",
  tariff: "0", # your tariff
  destination: "phone",
  msisdn: "XXXXXXXXXXXX", # phone number
  reference: SecureRandom.hex(8),
  options: []
}

response = client.message_create(payload)

puts response.inspect
```

### Example response on success:

```ruby
#<BSG::MESSAGE:0x007faad71306f8
 @error=0,
 @result={
   "error" => 0,
   "errorDescription" => "No errors",
   "reference" => "ref12345678",
   "id" => "12345",
   "price" => 0.99,
   "currency" => "UAH"
 }>
```

### Error example:

```ruby
#<BSG::MESSAGE:0x007faad71306f8
 @error=24,
 @errorDescription="Invalid request payload">
```

---

If you get error `"External ID already exists"`, generate a new unique `reference` string.

For full API documentation, visit [BSG docs](https://app.bsg.world).
