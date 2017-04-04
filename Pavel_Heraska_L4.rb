#!/usr/bin/env ruby

class Command
  ALL_COMMANDS = []

  def say(say_variable)
    p "#{say_variable}"
  end

  def self.command_by_name(name)
    temp_name = name.split[0]
    temp_arr = name.split
    ALL_COMMANDS.each{ |class_in_array|
      if class_in_array.name == temp_name.downcase
        temp_var_run = class_in_array.new
        if class_in_array.name == 'echo'
          temp_var_run.run(name)
        elsif class_in_array.name == 'ping'
          temp_var_run.run(temp_arr[1])
        else
          temp_var_run.run
        end
      end
    }
  end
end

# Help command prints name and description about commands
class HelpCommand < Command
  Command::ALL_COMMANDS.push(HelpCommand)
  def self.name
    'help'
  end

  def self.description
    'Prints list of commands and their descriptions'
  end

  def run
    Command::ALL_COMMANDS.each {|v|
      say "#{v.name}: #{v.description}"
    }
  end
end

#Uptime command shows how much time system is up
class UptimeCommand < Command
  Command::ALL_COMMANDS.push(UptimeCommand)
  def self.name
    'uptime'
  end

  def self.description
    'Prints the uptime of the system'
  end

  def run
    if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
      say ("Operating system is Windows based. Nothing to do here.")
    else
      u_ptime = File.read('/proc/uptime').split[0].to_i
      say (Time.at(u_ptime).utc.strftime("%Hh %Mmin %Ssec"))
    end
  end
end

#Date command shows current date timestamp
class DateCommand < Command
  Command::ALL_COMMANDS.push(DateCommand)
  def self.name
    'date'
  end

  def self.description
    'Prints current date and time'
  end

  def run
    say ("Current date is: #{Time.now}")
  end
end

#Ping command runs system ping
class PingCommand < Command
  Command::ALL_COMMANDS.push(PingCommand)
  def self.name
    'ping'
  end

  def self.description
    'Prints TRUE if the remote server is accessible, otherwise prints FALSE'
  end

  def run(ip_addr)
    #check operating system
    if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
      %x[ping #{ip_addr} > nul].inspect
    else
      %x[ping #{ip_addr} -W 5 -c 5 > /dev/null].inspect
    end
    var_tt = $?
    result = var_tt.to_s.split[3]
    if result.to_i == 0
      say('True')
    else
      say('False')
    end
  end
end

#Echo command echo first argument received
class EchoCommand < Command
  Command::ALL_COMMANDS.push(EchoCommand)
  def self.name
    'echo'
  end

  def self.description
    'Prints all received arguments as string'
  end

  def run(echo_var='')
    if echo_var != ''
      data = echo_var.split
      data.delete_at(0)
      string = data.join(" ").gsub(/[^a-zA-Z0-9[:space:]\-]/,"")
      say (string)
    else
      say(echo_var)
    end
  end
end

while true
  print '=> '
  input_chars = $stdin.gets
  break if input_chars == nil
  Command.command_by_name(input_chars.chomp!)
end