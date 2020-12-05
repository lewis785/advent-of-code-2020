# frozen_string_literal: true

module Day4
  class Task1
    def self.run
      input_array = File.readlines("input.txt").map(&:strip)
      fields = input_array.each_with_object([[]]) do |line, product|
        if line == ""
          product.append([])
        else
          product[-1] = product.last + line.split(" ").reduce([]) { |arr, element| arr << element.split(":")[0] }
        end
      end

      fields.map { |element| element.intersection(%w[byr iyr eyr hgt hcl ecl pid]).length == 7 }.count(true)
    end
  end

  class Task2
    def self.run
      input_array = File.readlines("input.txt").map(&:strip)
      fields = input_array.each_with_object([{}]) do |line, product|
        if line == ""
          product.append({})
        else
          product[-1] = product.last.merge(Hash[line.split(" ").map { |l| l.chomp.split(":", 2) }])
        end
      end

      fields.map { |element| valid_field element }.count(true)
    end

    def self.valid_field(element)
      return false unless %w[byr iyr eyr hgt hcl ecl pid].all? { |s| element.key? s }
      return false unless element["byr"].to_i >= 1920 && element["byr"].to_i <= 2002
      return false unless element["iyr"].to_i >= 2010 && element["iyr"].to_i <= 2020
      return false unless element["eyr"].to_i >= 2020 && element["eyr"].to_i <= 2030
      return false unless element["hcl"].match(/^#[a-f0-9]{6}$/)
      unless element["hgt"].match(/^(1[5-8][0-9]|19[0-3])cm$/) || element["hgt"].match(/^(59|6[0-9]|7[0-6])in$/)
        return false
      end
      return false unless %w[amb blu brn gry grn hzl oth].include? element["ecl"]
      return false unless element["pid"].match(/^[0-9]{9}$/)

      true
    end
  end
end
