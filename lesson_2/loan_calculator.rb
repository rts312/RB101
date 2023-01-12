require 'yaml'
MESSAGES = YAML.load_file('loan_calculator_messages.yml')

class String
  def remove_leading_zeroes()
    count = 0
    self.each_char do |char|
      if char == '0'
        count += 1
      else
        break
      end
    end
    self.delete_prefix('0' * count)
  end

  def remove_trailing_zeroes()
    # Count trailing zeroes
    count = 0
    self.each_char do |char|
      if char == '0'
        count += 1
      else
        count = 0
      end
    end
    if self.include?('.') == false # Do nothing if input is an integer
      self
    elsif self.to_f - self.to_i == 0.0 # Remove all but one trailing zero if only zeroes are present after decimal
      self.delete_suffix('0' * (count - 1))
    else # Remove trailing zeroes after decimal
      self.delete_suffix('0' * count)
    end
  end

  def remove_fractional_cents()
    dollar_amount = (self.to_f * 100)
    dollar_amount = (dollar_amount.to_i) / 100.00
  end
end

# Check if input was in the form of a float or integer, and if its value is above zero
def valid_number?(value)
    (value.to_f.to_s == value || value.to_i.to_s == value) && value.to_f > 0
end

def prompt(message)
  puts('=>' + message)
end

loop do # Main loop

  principle = ''
  apr = ''
  duration = ''

  # Get loan amount
  loop do
    prompt(MESSAGES['enter_loan'])
    principle = gets.chomp.remove_leading_zeroes.remove_trailing_zeroes
    if valid_number?(principle)
      prompt("the loan amount is $#{principle.remove_fractional_cents}")
      break
    else
      prompt(MESSAGES['invalid_principle'])
    end
  end

  # Get APR
  loop do
    prompt(MESSAGES['enter_apr'])
    apr = (gets.chomp.remove_leading_zeroes.remove_trailing_zeroes)
    if valid_number?(apr) && 0 <= apr.to_i && 100 >= apr.to_i
      prompt("the APR is %#{apr}")
      break
    else
      prompt(MESSAGES['invalid_apr'])
    end
  end

  # Get loan duration in months

  loop do
    prompt(MESSAGES['enter_duration'])
    duration = gets.chomp
    if valid_number?(duration)
      prompt("the loan duration is #{duration} months")
      break
    else
      prompt(MESSAGES['invalid_duration'])
   end
  end

  # Calculate monthly interest rate given a percentage as APR value
  monthly_rate = apr.to_f / 1200

  # Calculate monthly payment
  monthly_payment = principle.to_f * (monthly_rate / (1 - (1 + monthly_rate.to_f) ** (-duration.to_f)))
  prompt("the monthly payment is #{monthly_payment.to_s.remove_fractional_cents}")

  # Output loan amount, duration, monthly payment, and total interest


  # Ask if user wishes to perform another calculation
  prompt(MESSAGES['another_calculation'])
  if gets.chomp.downcase.start_with?("y") == false
    break
  end
  system('clear')
end
