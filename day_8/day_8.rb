# frozen_string_literal: true

require "set"

class Day8
  def initialize
    @input_array = File.readlines("input.txt", chomp: true).map do |line|
      operation, argument = line.split
      { operation: operation, argument: argument.to_i }
    end
  end

  def task_1
    loop_finder(@input_array, 0, 0, Set.new)
  end

  def task_2
    swap_lines = SortedSet.new

    @input_array.each_with_index do |instruction, index|
      next if instruction[:operation] == "acc"
      next if instruction[:operation] == "jmp" && instruction[:argument] == 1
      next if instruction[:operation] == "nop" && instruction[:argument] == 0

      swap_lines.add index
    end

    swap_lines.map do |index|
      new_instructions = swap_instruction(@input_array, index)
      terminator_finder(new_instructions, 0, 0, Set.new)
    end.max

  end

  private

  def loop_finder(program, accumulator, line, previously_visited)
    return accumulator if previously_visited.include? line

    previously_visited.add line
    instruction = program[line]
    case instruction[:operation]
    when "acc"
      loop_finder(program, accumulator + instruction[:argument], line + 1, previously_visited)
    when "jmp"
      loop_finder(program, accumulator, line + instruction[:argument], previously_visited)
    when "nop"
      loop_finder(program, accumulator, line + 1, previously_visited)
    end
  end

  def swap_instruction(instructions, index)
    new_instructions = instructions.dup
    new_instruction = instructions[index].dup
    new_instruction[:operation] = new_instruction[:operation] == "jmp" ? "nop" : "jmp"
    new_instructions[index] = new_instruction
    new_instructions
  end

  def terminator_finder(program, accumulator, line, previously_visited)
    return 0 if previously_visited.include? line
    return accumulator if line >= program.length

    previously_visited.add line
    instruction = program[line]
    case instruction[:operation]
    when "acc"
      terminator_finder(program, accumulator + instruction[:argument], line + 1, previously_visited)
    when "jmp"
      terminator_finder(program, accumulator, line + instruction[:argument], previously_visited)
    when "nop"
      terminator_finder(program, accumulator, line + 1, previously_visited)
    end
  end

end


