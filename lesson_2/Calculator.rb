# User inputs 2 numbers and an operation, and the result is printed.

# Get numbers from the user to be operated on
puts "enter a number to be operated on:"
num1 = Kernel.gets().chomp().to_f
puts "enter the second number to be operated on:"
num2 = Kernel.gets().chomp().to_f

validop = false

while validop == false
# Get which operation to complete
puts "Which operaton to perform? Options: 'add' 'subtract' 'mulitply' 'divide'"
operation = Kernel.gets().chomp()
# Perform the chosen opration on the input
  if operation == "add"
    puts num1 + num2
  elsif operation == "subtract"
    puts num1 - num2
  elsif operation == "multiply"
    puts num1 * num2
  elsif operation == "divide"
    puts num1 / num2
  else
    puts "Not a valid opertaion. Please choose from among these options: 'add' 'subtract' 'mulitply' 'divide'"
    next
  end
validop = true
end
