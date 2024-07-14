# Atm::Eth

ATM-Eth is a Ruby gem that provides a simplified interface for interacting with the Ethereum blockchain. With ATM-Eth, you can easily generate wallets, send transactions, check balances, and monitor transaction statuses on the Ethereum network. This gem abstracts complex Ethereum operations, allowing you to focus on building Ethereum-powered applications without the hassle of low-level details.

## Installation
 
If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install atm-eth-0.1.0.gem

## Usage
    
    $ bundle exec rails console

    require 'atm/eth'

    # Initialize the Ethereum instance
    ethereum = AtmEth::Ethereum.new('https://your-ethereum-provider-url.com')

    # Generate a new wallet
    wallet = ethereum.generate_wallet
    puts "Generated Wallet:"
    puts "Address: #{wallet[:address]}"
    puts "Private Key: #{wallet[:private_key]}"

    # Get balance of an Ethereum address
    address = '0xYourEthereumAddress'
    balance = ethereum.get_balance(address)
    puts "Balance of #{address}: #{balance} ETH"

    # Send transaction from wallet
    sender_wallet = ethereum.generate_wallet
    receiver_address = '0xReceiverAddress'
    value_in_wei = 10000000000000000  # Value in wei (0.01 ETH)
    transaction_hash = ethereum.send_transaction_from_wallet(sender_wallet, receiver_address, value_in_wei)
    puts "Transaction Hash: #{transaction_hash}"

    # Get transaction status
    status = ethereum.get_transaction_status(transaction_hash)
    puts "Transaction Status: #{status}" 

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tominugen/atm-eth. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/atm-eth/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Atm::Eth project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/tominugen/atm-eth/blob/master/CODE_OF_CONDUCT.md).
