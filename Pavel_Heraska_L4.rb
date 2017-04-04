#!/usr/bin/env ruby

require 'net/http'
require 'uri'

class Command
  ALL_COMMANDS = []
  def say(say_var)
    p "#{Time.now} | #{File.basename(__FILE__)} | #{say_var}"
  end

  def self.command_by_name(name)
    temp_name = name.split
    ALL_COMMANDS.each do |class_in_array|
      if class_in_array.name == temp_name[0].downcase
        temp_var_run = class_in_array.new
        if class_in_array.name == 'echo' || class_in_array.name == 'ping'
          temp_var_run.run(temp_name[1])
        else
          temp_var_run.run
        end
      end
    end
  end
end

class HelpCommand < Command
  Command::ALL_COMMANDS.push(HelpCommand)
  def self.name
    'help'
  end

  def self.description
    'Prints list of commands and their descriptions'
  end

  def run
    Command::ALL_COMMANDS.each do |cmd|
      say "#{cmd.name}: #{cmd.description}"
    end
  end
end

class UptimeCommand < Command
  Command::ALL_COMMANDS.push(UptimeCommand)
  def self.name
    'uptime'
  end

  def self.description
    'Prints the uptime of the system'
  end

  def run
    temp_uptime = File.read('/proc/uptime').split[0].to_i
    p Time.at(temp_uptime).utc.strftime("%Hh %Mmin %Ssec")
  end
end

class DateCommand < Command
  Command::ALL_COMMANDS.push(DateCommand)
  def self.name
    'date'
  end

  def self.description
    'Prints current date and time'
  end

  def run
    p Time.now
  end
end

class EchoCommand < Command
  Command::ALL_COMMANDS.push(EchoCommand)
  def self.name
    'echo'
  end

  def self.description
    'Prints the first received argument'
  end

  def run(echo_var='')
    puts echo_var
  end
end

class PingCommand < Command
  Command::ALL_COMMANDS.push(PingCommand)
  def self.name
    'ping'
  end

  def self.description
    'Prints TRUE if the remote server is accessible, otherwise prints FALSE'
  end

  def run(http_address)
    if http_address == nil
      http_address = 'http://afisha.tut.by'
    end
    if !http_address.include?('http')
      http_address = 'http://' + http_address
    end
    uri = URI.parse(http_address)
    http = Net::HTTP.new(uri.host, uri.port)
    data = http.get(uri.request_uri)
    if data.to_s.include?('HTTPOK') || data.to_s.include?('HTTPMovedPermanently')
      p 'TRUE'
    else
      p 'FALSE'
    end

  end

end

while true
  print '> '
  input_chars = $stdin.gets
  break if input_chars == nil # break on Ctrl-d
  Command.command_by_name(input_chars.chomp!)
end