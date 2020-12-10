# frozen_string_literal: true

require "set"

class Day10
  def initialize(input_file)
    @input_array = File.readlines(input_file, chomp: true).map(&:to_i).sort
  end

  def task_1
    jolt_differences = jolt_difference [], 0, 0
    jolt_differences.count(1) * jolt_differences.count(3)
  end

  def task_2
    must_exist = []
    @input_array.reduce(0) do |previous_ele, current_ele|
      must_exist.append previous_ele if current_ele - previous_ele == 3
      must_exist.append current_ele if current_ele - previous_ele == 3
      current_ele
    end

    @input_set = @input_array.dup.to_set
    must_exist.append @input_array.max
    must_exist.unshift(0)
    ranges = must_exist.each_slice(2).to_a

    ranges.filter_map { |range| valid_paths range[0], range[1] unless range[1] - range[0] == 1 }
          .reject(&:zero?).inject(:*)
  end

  private

  def jolt_difference(jolts_array, previous_jolt, index)
    return jolts_array.append(3) if index == @input_array.length

    jolts_array.append @input_array[index] - previous_jolt
    jolt_difference jolts_array, @input_array[index], index + 1
  end

  def valid_paths(number, target)
    return 0 unless (@input_set.include? number) || number.zero?
    return 1 if number == target

    valid_paths(number + 1, target) + valid_paths(number + 2, target) + valid_paths(number + 3, target)
  end
end


