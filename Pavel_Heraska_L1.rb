#!/usr/bin/env ruby

=begin

checking system version:
[student@epbyminw2470 ruby_tasks]$ ruby -v
ruby 2.0.0p648 (2015-12-16) [x86_64-linux]

change version with rvm
[student@epbyminw2470 ruby_tasks]$ rvm use 2.4.1
Using /home/student/.rvm/gems/ruby-2.4.1
[student@epbyminw2470 ruby_tasks]$ ruby -v
ruby 2.4.1p111 (2017-03-22 revision 58053) [x86_64-linux]

Get gemset list:
[student@epbyminw2470 ruby_tasks]$ rvm gemset list

gemsets for ruby-2.4.1 (found in /home/student/.rvm/gems/ruby-2.4.1)
=> (default)
   global
   mnt

Use created mnt gemset:
[student@epbyminw2470 ruby_tasks]$ rvm gemset use mnt
Using ruby-2.4.1 with gemset mnt

Getting installed gems in gemset mnt
[student@epbyminw2470 ruby_tasks]$ gem list

*** LOCAL GEMS ***

bigdecimal (default: 1.3.0)
bundler-unload (1.0.2)
coderay (1.1.1)
did_you_mean (1.1.0)
executable-hooks (1.3.2)
gem-wrappers (1.2.7)
io-console (default: 0.4.6)
json (default: 2.0.2)
method_source (0.8.2)
minitest (5.10.1)
net-telnet (0.1.1)
openssl (default: 2.0.3)
power_assert (0.4.1)
pry (0.10.4)
psych (default: 2.2.2)
rake (12.0.0)
rdoc (default: 5.0.0)
rubygems-bundler (1.4.4)
rvm (1.11.3.9)
slop (3.6.0)
sqlite3 (1.3.13)
test-unit (3.2.3)
xmlrpc (0.2.1)
[student@epbyminw2470 ruby_tasks]$

=end


############################## Task 1 bucket with max balls number #####################################################

# buckets hash
buckets = { 'red' => 50, 'green' => 100, 'blue' => 30, 'yellow' => 60 }

# getting bucket with max balls
buckets.each { |k, v| puts "Bucket with max balls: #{k}\n" if v == buckets.values.max }

# check which bucket contains more balls
if (buckets['green'] > buckets['yellow']) || (buckets['green'] > (buckets['red'] + buckets['blue']))
  puts "Yes. Green contains more balls.\n"
else
  puts "No. Green not contains more balls.\n"
end

################################## Task 2 currency task ################################################################

#define variables
exchange = 11170
collection = 30
needed_usd = 270
person_money = 5600000
icecream_cost = 10000

#calculate
needed_byr = (exchange * needed_usd) + ((exchange * needed_usd) / 100.0) * collection
received_usd = person_money / (exchange + exchange/100.0 * collection)
possibility = (person_money % (exchange + exchange/100.0 * collection)) > icecream_cost

print "To buy #{needed_usd} person need #{needed_byr}.\n"
print "Person with #{person_money} byr could buy #{received_usd.to_i} usd.\n"
print "Could person by ice cream with his balance: #{possibility}.\n"
