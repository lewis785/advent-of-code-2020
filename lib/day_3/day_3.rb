# frozen_string_literal: true

module Day3
  class Task1
    def self.run
      input_array = File.readlines("input.txt").map(&:strip)
      input_array.each_with_index.map { |line, index| line[(3 * index) % line.length] == "#" }.count(true)
    end
  end

  class Task2
    def self.run
      input_array = File.readlines("input.txt").map(&:strip)
      input_array.each_with_index.each_with_object([0, 0, 0, 0, 0]) do |(line, index), product|
        length = line.length
        product[0] += 1 if line[(1 * index) % length] == "#"
        product[1] += 1 if line[(3 * index) % length] == "#"
        product[2] += 1 if line[(5 * index) % length] == "#"
        product[3] += 1 if line[(7 * index) % length] == "#"
        product[4] += 1 if index.even? && line[(1 * (index / 2)) % length] == "#"
      end.reduce(&:*)
    end
  end
end
