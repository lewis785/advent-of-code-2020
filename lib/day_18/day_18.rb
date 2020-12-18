# frozen_string_literal: true

require "set"

class Day18
  def initialize(input_file)
    @input_array = File.readlines(input_file, chomp: true).map do |line|
      line.scan(/[+*()]|\d+/)
    end
  end

  def task_1
    @input_array
  end

  def task_2
  end

  private

end
