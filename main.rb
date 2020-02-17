# rubocop: disable Metrics/CyclomaticComplexity, Metrics/ModuleLength, Metrics/MethodLength, Metrics/PerceivedComplexity

module Enumerable
  def my_each
    return enum_for(:my_each) unless block_given?

    0.upto(to_a.size - 1) do |k|
      yield to_a[k]
    end
    to_a
  end

  def my_each_with_index
    return enum_for(:my_each) unless block_given?

    0.upto(to_a.size - 1) do |k|
      yield to_a[k], k
    end
    to_a
  end

  def my_select
    return enum_for(:my_each) unless block_given?

    result = []
    0.upto(to_a.size - 1) do |k|
      ret = yield to_a[k]
      result << to_a[k] if ret == true
    end
    result
  end

  def my_all?(*args)
    if block_given?
      to_a.my_each do |item|
        return false unless yield item
      end
    elsif args&.length&.positive? and to_a.length.positive?
      if args[0].class == Regexp
        to_a.my_each do |item|
          return false unless item.to_s =~ args[0]
        end
      elsif args[0].class == Class
        to_a.my_each do |item|
          return false unless item.is_a?args[0]
        end
      else
        to_a.my_each do |item|
          return false unless item == args[0]
        end
      end
    else
      to_a.my_each do |item|
        return false unless item
      end
    end
    true
  end

  def my_any?(*args)
    if block_given?
      to_a.my_each do |item|
        return true if yield item
      end
    elsif args&.length&.positive? and to_a.length.positive?
      if args[0].class == Regexp
        to_a.my_each do |item|
          return true if item.to_s =~ args[0]
        end
      elsif args[0].class == Class
        to_a.my_each do |item|
          return true if item.is_a?args[0]
        end
      else
        to_a.my_each do |item|
          return true if item == args[0]
        end
      end
    else
      to_a.my_each do |item|
        return true if item
      end
    end
    false
  end

  def my_none?(*args)
    if block_given?
      to_a.my_each do |item|
        return false unless yield item
      end
    elsif args&.length&.positive? and to_a.length.positive?
      if args[0].class == Regexp
        to_a.my_each do |item|
          return false unless item.to_s =~ args[0]
        end
      elsif args[0].class == Class
        to_a.my_each do |item|
          return false unless item.is_a?args[0]
        end
      else
        to_a.my_each do |item|
          return false unless item == args[0]
        end
      end
    else
      to_a.my_each do |item|
        return false unless item
      end
    end
    true
  end

  def my_count(*args)
    counter = 0
    if !args.empty? && block_given?
      puts '(repl):xx: warning: given block not used'
      to_a.my_each do |item|
        counter += 1 if item == args[0]
      end
    elsif block_given?
      to_a.my_each do |item|
        counter += 1 if yield item
      end
    elsif args.length.positive? and to_a.length.positive?
      to_a.my_each do |item|
        counter += 1 if item == args[0]
      end
    elsif args.join.empty? and !block_given?
      return to_a.size
    end
    counter
  end

  def my_map
    return to_a.enum_for(:my_map) unless block_given?

    result = []
    to_a.my_each { |item| result << yield(item) }
    result
  end

  def my_inject(*args)
    acc = args[0].class == Integer ? args[0] : to_a[0]

    if block_given? and args.join.empty?
      to_a.my_each do |item|
        acc = yield(acc, item)
      end

    elsif block_given? || args[0].class == Integer and args.length == 1
      to_a.my_each do |item|
        acc = yield(acc, item)
      end

    elsif args.length == 2 and args[0].class == Integer
      acc = args[0]
      to_a.my_each do |item|
        #  acc = acc.send(args[1].to_s, item)
        acc = args[1].to_proc.call(acc, item)
      end
    end
    acc
  end
end
# rubocop: enable Metrics/CyclomaticComplexity, Metrics/ModuleLength, Metrics/MethodLength, Metrics/PerceivedComplexity

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
# p [].any?                                           elsif args   #=> false

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
p ary.my_count #=> 4
p ary.my_count(2) #=> 2
p ary.my_count(2, &:even?) #=> 2 #Plus the blck not used error


# my_map in action
# p (1..4).my_map { |i| i*i }      #=> [1, 4, 9, 16]
# p (1..4).my_map { "cat"  }   #=> ["cat", "cat", "cat", "cat"]
# p (1..4).my_map

# my_inject in action
# p %w[ant dog cat bird].my_inject { |sum, n| sum + n }
# p (1..6).my_inject(1) { |sum, n| sum * n }
# p (1..6).my_inject(0) { |sum, n| sum + n }
# p (1..6).my_inject(0, :+)
# p (5..10).my_inject(1, :*)
# p (5..10).reduce(1, :*)

# e =  %w[cat sheep bear].my_inject do |acc, word|
#   acc.length > word.length ? acc : word
# end
# p e
