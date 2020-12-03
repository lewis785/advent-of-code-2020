module Day2
  class Task1
    def self.run
      input_array = File.readlines("input.txt")
      input_array.map(&:split).map do |requires, char, password|
        requires = requires.split("-").map(&:to_i)
        char = char.tr(":", "")
        requires[0] <= password.count(char) && password.count(char) <= requires[1]
      end.count(true)
    end
  end

  class Task2
    def self.run
      input_array = File.readlines("input.txt")
      input_array.map(&:split).map do |requires, char, password|
        char = char.tr(":", "")
        requires = requires.split("-").map(&:to_i)
        (password[requires[0] - 1] == char) ^ (password[requires[1] - 1] == char)
      end.count(true)
    end
  end
end