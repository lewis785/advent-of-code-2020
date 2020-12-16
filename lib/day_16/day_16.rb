# frozen_string_literal: true

require "set"

class Day16
  def initialize(input_file)
    @input_array = convert_input File.readlines(input_file, chomp: true).reject { |ele| ele == "" }
  end

  def task_1
    pp find_invalid_numbers(@input_array[:rules].dup, @input_array[:other_tickets].dup).sum
  end

  def task_2
    input = @input_array
    input[:other_tickets] = find_valid_tickets(input[:rules].dup, input[:other_tickets].dup)
    field_names = find_field_names(input[:rules].dup, input[:other_tickets])
    departure_fields_ids = field_names.select { |key, hash| key.include? "departure" }.values.to_set
    input[:your_ticket].select.with_index { |val, index| departure_fields_ids.include? index }.inject(:*)
  end

  private

  def convert_input(input)
    your_ticket = false
    other_tickets = false

    output = { rules: {}, your_ticket: [], other_tickets: [] }
    input.each do |line|
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
    valid_numbers = rules.dup.values.inject(:merge)
    tickets.map { |ticket| ticket.reject { |number| valid_numbers.include? number } }
           .reject(&:empty?).map(&:sum)
  end

  def find_valid_tickets(rules, tickets)
    valid_numbers = rules.values.reduce(Set.new, &:merge)
    tickets.select { |ticket| ticket.reject { |number| valid_numbers.include? number }.length.zero? }
  end

  def find_field_names(rules, tickets)
    rule_map = rules.keys.map { |key| [key, []] }.to_h
    field_values = tickets.transpose

    rules.each do |key, rule_values|
      field_values.each_with_index { |values, index| rule_map[key].append index if values.to_set.subset? rule_values }
    end

    filter_fields([], rule_map)
  end

  def filter_fields(found_fields, rule_map)
    return rule_map if found_fields.length == rule_map.length

    pp rule_map
    found_field = rule_map.values.find { |ele| (ele.is_a? Array) && (ele.length == 1) }[0]
    found_fields.append found_field

    # pp found_fields
    new_rule_map = {}
    rule_map.each do |key, field_ids|
      next new_rule_map[key] = field_ids unless field_ids.is_a? Array
      next new_rule_map[key] = found_field if field_ids.length == 1 && field_ids[0] == found_field

      new_rule_map[key] = field_ids - [found_field]
    end

    filter_fields(found_fields, new_rule_map)
  end
end
