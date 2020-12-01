# frozen_string_literal: true

module Day1
  class Task1
    def self.run
      input_array = File.readlines("input.txt").map(&:to_i)
      input_array.map { |x| 2020 - x }.intersection(input_array).reduce(:*)
    end
  end

  class Task2
    def self.run
      input_array = File.readlines("input.txt").map(&:to_i)
      input_array.combination(3).lazy.find { |x, y, z| x + y + z == 2020 }&.reduce(:*)
    end
  end
end
