# frozen_string_literal: true

require "set"

class Day15
  def initialize(input_file)
    @input_array = File.readlines(input_file, chomp: true).map { |line| line.split(",") }
  end

  def task_1
    inputs = @input_array.map do |line|
      line.each_with_index.map { |ele, index| [ele.to_i, index + 1] }.to_h
    end

    inputs.map { |input| find_value_in_turn(2020, input, input.length + 1, 0)[:value] }
  end

  def task_2
    inputs = @input_array.map do |line|
      line.each_with_index.map { |ele, index| [ele.to_i, index + 1] }.to_h
    end

    loops = 30000000 / 10000
    inputs.map do |input|
      result = { last_occurrences: input, turn: input.length + 1, value: 0 }

      loops.times do |x|
        result = find_value_in_turn((x + 1) * 10000, result[:last_occurrences], result[:turn], result[:value])
      end
      result[:value]
    end
  end

  private

  def find_value_in_turn(target_turn, last_occurrences, turn, value)
    return { last_occurrences: last_occurrences, turn: turn, value: value } if turn == target_turn

    if last_occurrences.key? value
      last_occurred = last_occurrences[value]
      last_occurrences[value] = turn
      find_value_in_turn(target_turn, last_occurrences, turn + 1, turn - last_occurred)
    else
      last_occurrences[value] = turn
      find_value_in_turn(target_turn, last_occurrences, turn + 1, 0)
    end
  end

end
