# frozen_string_literal: true

require "set"

class Day11
  def initialize(input_file)
    @input_array = File.readlines(input_file, chomp: true).map { |line| line.split "" }
  end

  def task_1
    find_stable_state([], @input_array.dup).map { |line| line.count("#") }.sum
  end

  def task_2; end

  private

  def find_stable_state(previous_state, current_state)
    return current_state if current_state == previous_state

    initial_state = current_state.dup
    new_state = current_state.each_with_index.map do |row, row_num|
      row.each_with_index.map do |column, col_num|
        find_new_state(initial_state, row_num, col_num)
      end
    end

    find_stable_state initial_state, new_state
  end

  def find_new_state(layout, row, column)
    current_state = find_state layout, row, column
    return current_state if current_state == "."

    empty = 0

    empty += 1 unless find_state(layout, row - 1, column - 1) == "L" || find_state(layout, row - 1, column - 1) == "."
    empty += 1 unless find_state(layout, row - 1, column) == "L" || find_state(layout, row - 1, column) == "."
    empty += 1 unless find_state(layout, row - 1, column + 1) == "L" || find_state(layout, row - 1, column + 1) == "."
    empty += 1 unless find_state(layout, row, column - 1) == "L" || find_state(layout, row, column - 1) == "."
    empty += 1 unless find_state(layout, row, column + 1) == "L" || find_state(layout, row, column + 1) == "."
    empty += 1 unless find_state(layout, row + 1, column - 1) == "L" || find_state(layout, row + 1, column - 1) == "."
    empty += 1 unless find_state(layout, row + 1, column) == "L" || find_state(layout, row + 1, column) == "."
    empty += 1 unless find_state(layout, row + 1, column + 1) == "L" || find_state(layout, row + 1, column + 1) == "."

    if current_state == "L" && empty.zero?
      "#"
    elsif current_state == "#" && empty >= 4
      "L"
    else
      current_state
    end
  end

  def find_state(layout, row, column)
    return "L" if row.negative? || row >= layout.length
    return "L" if column.negative? || column >= layout.first.length

    layout[row][column]
  end



end


