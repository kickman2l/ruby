#!/usr/bin/env ruby

require 'yaml'

CFG = YAML.load_file('config.yml')

# Head class command
class Command
  ALL_COMMANDS = []

  def say(say_variable, *name)
    p say_variable
    open(CFG['output_log'], 'a') do |var|
      var.puts "#{Time.now} | #{name[0]} | #{say_variable}"
    end
  end

  def self.command_by_name(name)
    ALL_COMMANDS.each do |cls|
      if cls.name == name.split[0].downcase
        if cls.name == 'echo'
          cls.new.run(name)
        elsif cls.name == 'ping'
          cls.new.run(name.split[1])
        else
          cls.new.run
        end
      end
    end
  end
end

# Help command prints name and description about commands
class HelpCommand < Command
  Command::ALL_COMMANDS.push(HelpCommand)

  def self.name
    'help'
  end

  def self.description
    CFG['commands'][0]['help']
  end

  def run
    Command::ALL_COMMANDS.each do |v|
      say "#{v.name}: #{v.description}"
    end
  end
end

# Uptime command shows how much time system is up
class UptimeCommand < Command
  Command::ALL_COMMANDS.push(UptimeCommand)

  def self.name
    'uptime'
  end

  def self.description
    CFG['commands'][1]['uptime']
  end

  def run
    if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM).nil?
      say 'Operating system is Windows based.', UptimeCommand.name
    else
      u_ptime = File.read('/proc/uptime').split[0].to_i
      say Time.at(u_ptime).utc.strftime('%Hh %Mmin %Ssec'), UptimeCommand.name
    end
  end
end

# Date command shows current date timestamp
class DateCommand < Command
  Command::ALL_COMMANDS.push(DateCommand)

  def self.name
    'date'
  end

  def self.description
    CFG['commands'][2]['date']
  end

  def run
    say "Current date is: #{Time.now}", DateCommand.name
  end
end

# Ping command runs system ping
class PingCommand < Command
  Command::ALL_COMMANDS.push(PingCommand)

  def self.name
    'ping'
  end

  def self.description
    CFG['commands'][3]['ping']
  end

  def run(ip_addr)
    if !(/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM).nil?
      %x(`ping #{ip_addr} > nul`).inspect
    else
      %x(`ping #{ip_addr} -W 5 -c 5 > /dev/null`).inspect
    end
    result = $CHILD_STATUS.to_s.split[3]
    if result.to_i.zero?
      say 'True', PingCommand.name
    else
      say 'False', PingCommand.name
    end
  end
end

# Echo command echo first argument received
class EchoCommand < Command
  Command::ALL_COMMANDS.push(EchoCommand)

  def self.name
    'echo'
  end

  def self.description
    CFG['commands'][4]['echo']
  end

  def run(echo_var = '')
    if echo_var != ''
      data = echo_var.split
      data.delete_at(0)
      string = data.join(' ').gsub(/[^a-zA-Z0-9[:space:]\-]/, '')
      say string, EchoCommand.name
    else
      say echo_var, EchoCommand.name
    end
  end
end

loop do
  begin
    print '=> '
    input_chars = $stdin.gets
    exec('echo "Good Bye!"') if input_chars == "exit\n" || input_chars.nil?
    Command.command_by_name(input_chars.chomp!)
  rescue Interrupt
    exec('echo "Good Bye!"')
  rescue => err
    open(CFG['error_log'], 'a') do |var|
      if CFG['debug'] == true
        var.puts "#{Time.now} | #{err.backtrace}"
      else
        var.puts "#{Time.now} | #{err.message}"
      end
    end
  end
end
