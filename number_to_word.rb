ONE_TO_NINETEEN = { 1=> "one", 2=> "two", 3=> "three", 4=> "four", 5=> "five", 6=> "six", 7=> "seven", 8=> "eight", 9=> "nine", 10=> "ten", 11=> "eleven", 12=> "twelve", 13=> "thirteen", 14=> "fourteen", 15=> "fifteen", 16=> "sixteen", 17=> "seventeen", 18=> "eighteen", 19=> "nineteen" }
TENS = {20=>"twenty", 30=>"thirty", 40=>"forty", 50=>"fifty", 60=>"sixty", 70=>"seventy", 80=>"eighty", 90=>"ninety"}
MULTIPLES = {100 => "hundred", 1000 => "thousand", 1000000 => "million", 1000000000 => "billion", 1000000000000 => "trillion" } #extending the numerals it can convert to words can be done by appending the key value pair to the MULTIPLES
 
def arabic2words_under_100(num)
  word = ""
  while num > 19
    divisor_num = (num / 10)
    num = (num % 10)
    (word << TENS[divisor_num * 10]) unless TENS[divisor_num * 10].nil?
  end
  if !word.empty?
    (word << " #{ONE_TO_NINETEEN[num]}") unless ONE_TO_NINETEEN[num].nil?
  else
    (word << "#{ONE_TO_NINETEEN[num]}") unless ONE_TO_NINETEEN[num].nil?
  end
  return nil if word.empty?
  word
end

def arabic2words(num)
  word = ""
  while num >= 100
    MULTIPLES.keys.sort.reverse.each do |multiple|
      divisor_num = (num / multiple)
      next if divisor_num < 1
      if arabic2words(divisor_num).empty?
        pre = arabic2words_under_100(divisor_num)
      else
        pre = arabic2words(divisor_num)
      end
      num = (num % multiple)
      word = "#{word}, " unless word.empty?
      word << "#{pre} "
      word << MULTIPLES[multiple]
    end
  end
  word << " and #{arabic2words_under_100(num)}" unless arabic2words_under_100(num).nil?
  word.gsub(/^ and /,"")
end

puts arabic2words_under_100(101)
