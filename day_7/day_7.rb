# frozen_string_literal: true

module Day7
  class Task1
    def self.run
      input_array = File.readlines("input.txt")
                        .map { |line| line.strip.gsub(/( bag[s]?)|(\d+ )|\./, "") }

      bag_rules = Hash[
        input_array.map { |line| line.split(" contain ", 2) }
                   .map { |element| [element.first, element.last.split(", ")] }
      ]

      bag_rules.keys.map { |colour| bag_allows_gold(bag_rules, colour) }.count(true)
    end

    def self.bag_allows_gold(rules, colour)
      accepted_bags = rules[colour]

      return true if accepted_bags.include? "shiny gold"
      return false if accepted_bags.include? "no other"

      accepted_bags.each do |accepted|
        return true if bag_allows_gold(rules, accepted)
      end
      false
    end
  end

  class Task2
    def self.run
      input_array = File.readlines("input.txt")
                        .map { |line| line.strip.gsub(/ bag[s]?|\./, "") }

      bag_rules = Hash[
        input_array.map do |line|
          map = line.split(" contain ", 2)
          map[-1] = Hash[map.last.split(", ").map { |rule| rule.scan(/\d+|\D+/).map(&:strip).reverse }]
          map
        end
      ]

      bag_count(bag_rules, "shiny gold")
    end

    def self.bag_count(bag_rules, colour)
      accepted_bags = bag_rules[colour]
      return 0 if accepted_bags.keys.include? "no other"

      count = 0
      accepted_bags.keys.each do |key|
        count += (bag_count(bag_rules, key) * accepted_bags[key].to_i) + accepted_bags[key].to_i
      end
      count
    end
  end
end
