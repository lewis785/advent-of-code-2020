# frozen_string_literal: true

require "set"

class Day15
  def initialize(input_file)
    @input_array = File.readlines(input_file, chomp: true).map { |line| line.split(",") }
  end

  def task_1
    inputs = @input_array.map do |line|
      line.each_with_index.map { |ele, index| [ele.to_i, index] }.to_h
    end

    inputs.map { |input| find_2020_in_sequence(input, input.length, 0) }

    # pp find_2020_in_sequence(inputs.first, 3, 0)
  end

  def task_2

  end

  private

  def find_2020_in_sequence(last_occurrences, turn, value)
    return value if turn + 1 == 2020

    if last_occurrences.key? value
      last_occurred = last_occurrences[value]
      last_occurrences[value] = turn
      find_2020_in_sequence(last_occurrences, turn + 1, turn - last_occurred)
    else
      last_occurrences[value] = turn
      find_2020_in_sequence(last_occurrences, turn + 1, 0)
    end
  end

end
