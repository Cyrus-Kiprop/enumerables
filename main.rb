# ruby standard enumerable class
module Enumerable
  

  def my_count(*args)
    counter = 0
    if block_given? 
      to_a.my_each do |item|
        counter += 1 if yield item
      end
    elsif args.length.positive? and to_a.length.positive?
        to_a.my_each do |item|
          counter += 1 if item == args[0]
        end
    elsif args.join().empty? and !block_given?
        return to_a.size
    end
    counter
  end




end

# # my_each in action
# [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5].my_each_with_index { |even, idx|
#   puts idx * even
# }

# # my_select in action
# p [1, 2, 3, 4, 5].my_select(&:even?) #=> [2, 4]
# p (1..10).my_select { |i| i % 3 == 0 } #=> [3, 6, 9]
# p %i[foo bar].my_select { |x| x == :foo } #=> [:foo]

# my_all in action
# p %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
# p %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
# p %w[ant bear cat].my_all?(/\w/)                       #=> false
# p [1, 2i, 3.14].my_all?(Numeric)                       #=> true
# p [nil, true, 99].my_all?                              #=> false
# p [].my_all?                                           #=> true

# my_any? in action
# p %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
# p %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
# p %w[ant bear cat].my_any?(/d/)                        #=> false
# p [nil, true, 99].my_any?                              #=> true
# p [].any?                                              #=> false

# my_none? in action
# p %w{ant bear cat}.none? { |word| word.length == 5 } #=> true
# p %w{ant bear cat}.none? { |word| word.length >= 4 } #=> false
# p %w{ant bear cat}.none?(/d/)                        #=> true
# p [1, 3.14, 42].none?(Float)                         #=> false
# p [].none?                                           #=> true
# p [nil].none?                                        #=> true
# p [nil, false].none?                                 #=> true
# p [nil, false, true].none?                           #=> false

# my_count in action
 ary = [1, 2, 4, 2]
p ary.my_count               #=> 4
p ary.my_count(2)            #=> 2
p ary.my_count(2) { |x| x%2==0 } #=> 3