# frozen_string_literal: true

require "set"

class Day12
  def initialize(input_file)
    @input_array = File.readlines(input_file, chomp: true).map do |line|
      action, value = line.split("", 2)
      { action: action, value: value.to_i }
    end
  end

  def task_1
    position = ship_instructions(0, { x: 0, y: 0 }, :east)
    position[:x].abs + position[:y].abs
  end

  def task_2
    position = waypoint_instructions(0, { x: 0, y: 0 }, { x: 10, y: 1 })
    position[:x].abs + position[:y].abs
  end

  private

  def waypoint_instructions(line, ship, waypoint)
    return ship if line >= @input_array.length

    instruction = @input_array[line]

    case instruction[:action]
    when "N"
      waypoint[:y] = waypoint[:y] + instruction[:value]
    when "S"
      waypoint[:y] = waypoint[:y] - instruction[:value]
    when "E"
      waypoint[:x] = waypoint[:x] + instruction[:value]
    when "W"
      waypoint[:x] = waypoint[:x] - instruction[:value]
    when "L"
      waypoint = rotate_waypoint(waypoint, -instruction[:value])
    when "R"
      waypoint = rotate_waypoint(waypoint, instruction[:value])
    when "F"
      ship[:x] = ship[:x] + (waypoint[:x] * instruction[:value])
      ship[:y] = ship[:y] + (waypoint[:y] * instruction[:value])
    end

    waypoint_instructions(line + 1, ship, waypoint)
  end

  def ship_instructions(line, position, direction)
    return position if line >= @input_array.length

    instruction = @input_array[line]

    case instruction[:action]
    when "N"
      position[:y] = position[:y] + instruction[:value]
    when "S"
      position[:y] = position[:y] - instruction[:value]
    when "E"
      position[:x] = position[:x] + instruction[:value]
    when "W"
      position[:x] = position[:x] - instruction[:value]
    when "L"
      direction = rotate_ship(direction, -instruction[:value])
    when "R"
      direction = rotate_ship(direction, instruction[:value])
    when "F"
      position = go_forward(position, direction, instruction[:value])
    end

    ship_instructions(line + 1, position, direction)
  end

  def go_forward(position, direction, value)
    case direction
    when :north
      position[:y] = position[:y] + value
    when :south
      position[:y] = position[:y] - value
    when :east
      position[:x] = position[:x] + value
    when :west
      position[:x] = position[:x] - value
    end

    position
  end

  def rotate_ship(starting_direction, degrees)
    directions = %i[north east south west]
    direction_index = directions.find_index(starting_direction)
    degrees /= 90
    direction_index = degrees.positive? ? (direction_index + degrees) % 4 : (direction_index + degrees) % -4

    directions[direction_index]
  end

  def rotate_waypoint(waypoint, degrees)
    degrees = 360 + degrees if degrees.negative?
    turns = degrees / 90

    turns.times { waypoint = { x: waypoint[:y], y: -waypoint[:x] } }
    waypoint
  end
end


