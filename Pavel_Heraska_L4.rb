#!/usr/bin/env ruby

def logger
  yield
  nil
rescue StandardError => e
  puts "Err: #{e.class}"
  nil
end
