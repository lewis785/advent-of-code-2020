# frozen_string_literal: true

require "set"

class Day16
  def initialize(input_file)
    @input_array = File.readlines(input_file, chomp: true).reject { |ele| ele == ""}
  end

  def task_1
    input = convert_input
    pp find_invalid_numbers(input[:rules].dup, input[:other_tickets].dup).sum
  end

  def task_2
  end

  private

  def convert_input
    your_ticket = false
    other_tickets = false

    output = { rules: {}, your_ticket: [], other_tickets: [] }
    @input_array.each do |line|
      next other_tickets = true if line == "nearby tickets:"
      next your_ticket = true if line == "your ticket:"

      if other_tickets
        output[:other_tickets].append line.split(",").map(&:to_i)
      elsif your_ticket
        output[:your_ticket] = line.split(",").map(&:to_i)
      else
        rule, values = line.split(": ", 2)
        output[:rules][rule] = values.split(" or ").reduce(Set.new) do |set, value|
          min, max = value.split("-")
          set.merge(min.to_i..max.to_i)
        end
      end
    end

    output
  end

  def find_invalid_numbers(rules, tickets)
    valid_numbers = rules.values.inject(:merge)
    tickets.map { |ticket| ticket.reject { |number| valid_numbers.include? number } }
           .reject(&:empty?).map(&:sum)
  end

end
