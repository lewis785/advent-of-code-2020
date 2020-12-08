# frozen_string_literal: true

module Day6
  class Task1
    def self.run
      tickets.max
    end

    def self.tickets
      input_array = File.readlines("input.txt").map(&:strip).map { |element| element.split("") }
      input_array.map do |ticket|
        row = ticket[0..6].each_with_object({ "max": 127, "min": 0 }) do |pos, product|
          middle = (product[:max] + product[:min]) / 2
          pos == "F" ? product[:max] = middle : product[:min] = (middle + 1)
        end

        column = ticket[7..9].each_with_object({ "max": 7, "min": 0 }) do |pos, product|
          middle = (product[:max] + product[:min]) / 2
          pos == "L" ? product[:max] = middle : product[:min] = middle + 1
        end

        (row[:max] * 8) + column[:max]
      end
    end
  end

  class Task2
    def self.run
      tickets = Day6::Task1.tickets.sort

      tickets.reduce(tickets.first - 1) do |product, ticket|
        return product + 1 if product + 1 != ticket

        product = ticket
        product
      end
    end
  end
end
