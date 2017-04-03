#Fibonacci

fib_length = ARGV[0].to_i

def fibonacci(n)
  if n == 0
    return 0
  elsif n == 1
    return 1
  elsif n == 2
    return 1
  else
    return fibonacci(n -1) + fibonacci(n -2)
  end
end

res = []
i = 0

while i<fib_length do
  res.push( fibonacci(i))
  i += 1
end
p res

# Additional task 1

str_var = "dniMyMdegnahCybuR".reverse.capitalize
p str_var

# Additional task 2

var_digit = 1234567.to_s.reverse.to_i
p var_digit

# Additional task 3

var_digit = 123456.to_s
res = 0
i = 0
while i < var_digit.length
  res += var_digit[i].to_i
  i += 1
end
p res

# Additional task 4

var_str = "asddASD"
counter = 0
var_str.each_char{|v| counter += 1 if v.downcase == "a"}
p counter

# Additional task 5

var_polyndrom_str = "asdfghjkllkjhgfdsa".downcase
prep_str = var_polyndrom_str.reverse

if prep_str == var_polyndrom_str
  p "Yes!"
else
  p "No!"
end

# Additional task 6

var_range = *(3..10).reverse_each
res = []
var_range.each { |v|
  if v == 5
    break
  elsif v % 3 == 0
    res.push(v**2)
  else
    res.push(v**2)
  end
}
p res

# Additional task 7

shop = { 'milk' => 10, 'bread' => 8, 'cornflakes' => 12, 'ice_cream' => 15, 'pie' => 20 }
shop.each{ |k,v| p  k if v == 15}

# Additional task 8

incom_arr = [1, 6, 1, 8, 2, -1, 3, 5]
incom_arr[incom_arr.index(incom_arr.max)] = incom_arr.max + 100
p incom_arr

# Additional task 9

inc_arr = [7, 3, [4, 5, 1], 1, 9, [2, 8, 1]]
p inc_arr.flatten.uniq.sort.reverse
