#! /usr/bin/env ruby

require 'dotenv'
require "./lib/takeaway"
require "./lib/menu"

Dotenv.load

menu_list = {
  "chicken" => 3.50,
  "fish" => 2.00,
  "falafel" => 2.50
}

menu = Menu.new(menu_list)
dishes = {}

loop do
  print "What do you want? "
  dish = gets.strip
  break if dish == "done"
  print "How many? "
  quantity = gets.to_i
  dishes[dish] = quantity
end

print "What is your phone number? "
phone = gets

config =
  {
    account_sid: ENV["ACCOUNT_SID"],
    auth_token: ENV["AUTH_TOKEN"],
    from: ENV["PHONE"],
    to: phone,
    body: "Thank you! Your order will be delivered before %s"
}

Takeaway.new(menu: menu, config: config).place_order(dishes)