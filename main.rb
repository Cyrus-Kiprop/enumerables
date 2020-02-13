# ruby standard enumerable class

module Enumerable
  def my_each()
    (0..(size - 1)).each do |i|
      yield(self[i]) if block_given?
    end
  end

  def my_each_with_index()
    (0..(size - 1)).each do |i|
      puts yield(self[i], i) if block_given?
    end
  end

  def my_select()
    result = []
    my_each do |item|
      ret = yield(item) if block_given?
      result << item if ret
    end
    result
  end

  def my_all?()
    my_each do |element|
      ret = yield(element)
      # puts ret
      if ret == false
        return false
        break
      else
        next
      end
    end
    true
  end

  def my_any?(args)
    result = nil
    my_each do |element|
      if args

        reg_result = args.call(element)

        if reg_result != nil
          result = true
          break
        end
      else
        ret = yield(element) if block_given?
        if ret == true
          result = true
          break
        end
      end
    end
    return false if result == nil

    result
  end
end

# # my_each in action with passed block
#   %w[water ant bear].my_each do |item|
#   item.upcase
# end

# # my_each_with_index in action
# %w[water ant bear].my_each_with_index do |item, indx|
#   puts item
#   puts indx
# end

# # my_select in action
# print (%w[water ant bear].my_select do |item|
#   item.length == 3
# end)

# # my_all in action
#  puts (%w[water ant bear].my_all? do |item|
#   item.length >= 3
# end)

# puts %w[ant bear cat].my_any?
%w[ant bear cat].my_any?(/d/)
