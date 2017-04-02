# Task 1 proc and time

def deb_time(proc)
  cur_time = Time.now
  proc.call
  return Time.now-cur_time
end

proc = Proc.new do
  (1..5000000).each{|v| v}
end

p deb_time(proc)

# Task 2 Array mega_sum (block inject map)

arr = [1, 2, 3, 4]

def mega_sum (array,digit=0, &block)
  array.map! {|v| block.call(v)} if block_given?
  array.inject(digit){|sum,x| sum + x }
end

p mega_sum(arr,10){|i| i**2}


# Task 3

(1..1000).detect{|v| p v if (v.to_s.size == 3) && (v % 7 == 3) }

# Task 4

def calculation(*args, a:, b:, &block)
  if block_given?
    args.each {|v| p block.call(v)}
  elsif
    puts "ERROR"
  end
end

calculation(1, 2, 3, 4, 5, a: 6, b: 7){|v| v}

# Task 5

class Array
  def even_numbers
    even_arr = self.select{|v| v.even?}
    if even_arr.empty?
      return nil
    else
      if block_given?
        return even_arr.select! {|v| yield(v)}
      else
        return even_arr
      end
    end
  end
end

puts [1, 2, 3, 4, 5, 6, 7].even_numbers { |i| i > 2}.inspect
puts [1, 2, 3, 4, 5, 6, 7].even_numbers { |i| i > 10}.inspect
puts [2, 4, 6, 8, 10, 12, 7].even_numbers {|i| i.between?(6, 12)}.inspect