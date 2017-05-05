lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'braspag-rest'
require 'json'
require 'pry-byebug'

puts "configuring braspag-rest..."
BraspagRest.config do |config|
  config.logger = Logger.new(STDOUT)
  config.environment = 'test'
  config.config_file_path = './braspag.yml'
end

puts BraspagRest.config.inspect

puts "creating sale..."
sale = BraspagRest::Sale.new(
  order_id: 'abc123',
  request_id: SecureRandom.hex(36),
  customer: {
    name: 'Comprador Teste'
  },
  payment: {
    type: 'CreditCard',
    amount: 15700,
    provider: 'Simulado',
    installments: 1,
    credit_card: {
      number: '0000000000000004',
      holder: 'Teste Holder',
      expiration_date: '12/2021',
      security_code: '123',
      brand: 'Visa'
    },
    recurrent_payment: {
      authorize_now: true,
      end_date: '2019-12-01',
      interval: 'Monthly',
    }
  }
)

if sale.save
  puts "payment status #{sale.payment.status}"
  puts "payment id is #{sale.payment.id}"
else
  puts "errors: #{sale.errors.inspect}"
end
