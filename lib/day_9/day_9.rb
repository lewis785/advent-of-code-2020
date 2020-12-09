# frozen_string_literal: true

require "set"

class Day9
  def initialize (input_file, preamble)
    @input_array = File.readlines(input_file, chomp: true).map(&:to_i)
    @preamble = preamble.to_i
  end

  def task_1
    find_weakness(@input_array[0..(@preamble - 1)], @preamble)
  end

  def task_2
    target = task_1
    @input_array.each_index do |index|
      consecutive_values = consecutive_values_match_target target, [], index
      return consecutive_values.min + consecutive_values.max unless consecutive_values == false
    end
  end

  private

  def consecutive_values_match_target(target, consecutive_numbers, index)
    return consecutive_numbers if consecutive_numbers.sum == target
    return false if consecutive_numbers.sum > target

    consecutive_numbers.append @input_array[index]
    consecutive_values_match_target target, consecutive_numbers, index + 1
  end

  def find_weakness(encryption_keys, index)
    value = @input_array[index]
    return value unless encryption_keys.combination(2).lazy.any? { |x, y| x + y == value }

    encryption_keys.shift
    encryption_keys.append(@input_array[index])

    find_weakness(encryption_keys, index + 1)
  end
end


