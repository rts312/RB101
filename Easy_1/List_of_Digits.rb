# takes one argument, a positive integer, and returns a list of the digits in the number

def digit_list(int)
  new = int.to_s.chars.map{|n| n.to_i}
end

p digit_list(1234124)
