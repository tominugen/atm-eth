# lib/atm/eth/ethereum.rb
require 'net/http'
require 'json'
require 'openssl'
require 'digest'
require 'digest/keccak'

module AtmEth
  class Ethereum
    def initialize(provider_url)
      @provider_url = provider_url 
    end

    def generate_wallet
      key = SecureRandom.hex(32)
      private_key = "0x#{key}"
      address = generate_address_from_private_key(private_key)

      { address: address, private_key: private_key }
    end

    def send_transaction_from_wallet(wallet, to, value_in_wei)
      nonce = get_nonce(wallet[:address])
      gas_price = estimate_gas_price

      transaction_data = {
        nonce: nonce,
        gasPrice: gas_price,
        gasLimit: '0x5208',
        to: to,
        value: value_in_wei,
        data: ''
      }

      signed_transaction = sign_transaction(transaction_data, wallet[:private_key])

      send_raw_transaction(signed_transaction)
    end

    def get_balance(address)
      uri = URI("#{@provider_url}?module=account&action=balance&address=#{address}&tag=latest")
      response = Net::HTTP.get(uri)
      balance_wei = JSON.parse(response)['result']
      wei_to_ether(balance_wei)
    end

    def get_transaction_status(tx_hash)
      uri = URI("#{@provider_url}?module=proxy&action=eth_getTransactionReceipt&txhash=#{tx_hash}")
      response = Net::HTTP.get(uri)
      receipt = JSON.parse(response)['result']

      if receipt.nil?
        'Pending' 
      else
        receipt['status'] == '0x1' ? 'Successful' : 'Failed'
      end
    end

    private

    def generate_address_from_private_key(private_key)
      require 'openssl'
      private_key = private_key.sub(/^0x/, '') # remove "0x"
      private_key_bn = OpenSSL::BN.new(private_key, 16)

      group = OpenSSL::PKey::EC::Group.new('secp256k1')
      point = group.generator.mul(private_key_bn)
      x_bn = point.to_bn
      y_bn = point.to_bn

      public_key_hex = '04' + x_bn.to_s(16) + y_bn.to_s(16)

      keccak_hash = Digest::Keccak.new
      keccak_hash.update([public_key_hex].pack('H*'))
      hashed_public_key = keccak_hash.hexdigest[24..-1]

      '0x' + hashed_public_key
    end

    def wei_to_ether(wei)
      wei.to_f / 1_000_000_000_000_000_000
    end

    def sign_transaction(transaction_data, private_key)
      key = OpenSSL::PKey::EC.new('secp256k1')
      key.private_key = OpenSSL::BN.new(private_key, 16)
      signature = key.dsa_sign_asn1(Digest::SHA3.hexdigest(transaction_data.to_json))

      r, s = signature.unpack('H64H64')
      v = key.dsa_verify_asn1(Digest::SHA3.hexdigest(transaction_data.to_json), signature) + 27

      {
        r: "0x#{r}",
        s: "0x#{s}",
        v: v
      }
    end

  end
end

