# frozen_string_literal: true

module Day6
  class Task1
    def self.run
      input_array = File.readlines("input.txt").map(&:strip)
      input_array = input_array.each_with_object([[]]) do |line, product|
        next product.append([]) if line == ""

        product[-1] = product.last + line.split("")
      end

      input_array.map { |element| element.uniq.count }.sum
    end
  end

  class Task2
    def self.run
      input_array = File.readlines("input.txt").map(&:strip)
      groups = input_array.each_with_object([Group.new]) do |line, product|
        next product.append(Group.new) if line == ""

        array = product.last&.array
        product.last&.array = array + line.split("")
        product.last&.size += 1
      end
      groups.map { |element| element.array.find_all { |x| element.array.count(x) == element.size }.uniq.count }.sum
    end

    class Group
      attr_accessor :size, :array

      def initialize
        @size = 0
        @array = []
      end
    end
  end
end
