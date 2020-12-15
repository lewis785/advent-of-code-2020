# frozen_string_literal: true

require "set"

class Day14
  def initialize(input_file)
    @input_array = File.readlines(input_file, chomp: true).map do |line|
      action, value = line.split(" = ", 2)

      if action == "mask"
        { action: :mask, value: value }
      else
        { action: :memory, position: action.scan(/\d/).join("").to_i, value: value.to_i.to_s(2).rjust(36, "0") }
      end
    end
  end

  def task_1
    execute_action({}, [], 0).sum
  end

  def task_2
    pp execute_float_action({}, [], 0).values.sum
  end

  private

  def execute_action(memory, mask, line)
    return memory.compact if line >= @input_array.length

    command = @input_array[line]

    if command[:action] == :mask
      mask = command[:value].split("")
    else
      memory[command[:position]] = command[:value].split("").zip(mask).map do |input_value, mask_value|
        mask_value == "X" ? input_value : mask_value
      end.join("").to_i(2)
    end

    execute_action(memory, mask, line + 1)
  end

  def execute_float_action(memory, mask, line)
    return memory.compact if line >= @input_array.length

    command = @input_array[line]

    if command[:action] == :mask
      mask = command[:value].split("")
    else
      generate_values(command[:position].to_s(2).rjust(36, "0").split(""), mask)
        .each { |value| memory[value] = command[:value].to_i(2) }
    end

    execute_float_action(memory, mask, line + 1)
  end

  def generate_values(input, mask)
    base_input = input.zip(mask).map do |input_value, mask_value|
      next "X" if mask_value == "X"

      mask_value == "1" ? "1" : input_value
    end

    generate_variety([], base_input)
  end

  def generate_variety(variety, input)
    return variety << input.join("").to_i(2) if input.count("X").zero?

    position = input.find_index { |ele| ele == "X" }

    input[position] = "0"
    generate_variety(variety, input.dup)
    input[position] = "1"
    generate_variety(variety, input.dup)
  end
end
