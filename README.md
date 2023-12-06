# Incrementing Message ID Proof of Concept

Given that a message id should be in sequencial and unique and resets every 12 midnight.

# Install

```
bundle install
rails db:create
rails db:migrate
rails s
```

# How to use

On `rails console`

## Create one

Example of creating one record.

```ruby
transfer = TransferRepository.new(amount: 1000).save
transfer.message_id
# => 20231206PAEYPHM2XXXB000000000000001
```

## Generate sample data

Sample for creating multiple records demonstrating incrementing message id.

```ruby
TransferRepository.sample(1000) # for 1,000 samples
# => ["20231206PAEYPHM2XXXB000000000000131",
#  "20231206PAEYPHM2XXXB000000000000132",
#  "20231206PAEYPHM2XXXB000000000000133",
#  "20231206PAEYPHM2XXXB000000000000134",
#  "20231206PAEYPHM2XXXB000000000000135",
#  ...
#  "20231206PAEYPHM2XXXB000000000001000"
# ]
```

## Reset the current counter

Reset message id to 1 or set to a specific number.

```ruby
# resets to 1
TransferRepository.reset_count

# will start at 1000
TransferRepository.reset_count(to: 1000)
```

## Recurring
The message id should reset every day. Use `TransferRepository.reset_count` to
reset the message id every midnight using `cron` or `sidekiq`.
