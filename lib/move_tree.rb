
#Move = Struct.new(:x, :y, :depth, :children, :parent)

require_relative 'move'

class MoveTree
  attr_reader :max_depth, :root

  def initialize(coordinates, max_depth)
    #assumes input is valid, please please please. Thanks.
    @coordinates = coordinates
    @max_depth   = max_depth
    @upper_limit = 7
    @lower_limit = 0
    @left_limit  = 0
    @right_limit = 7
    @node_count = 0
  end

  # recursion just for kit
  def generate_moves(coordinates = @coordinates, current_depth = 0, max_depth = @max_depth, parent = nil)
    return if current_depth > max_depth
    x, y = coordinates
    current_node =  Move.new(x, y, current_depth, [], parent)
    @node_count += 1
    parent.children << current_node if parent
    @root = current_node if current_depth == 0
    move_posibilities.each do |delta|
      unless out_of_bounds([x, y], delta)
        delta_x, delta_y = delta
        generate_moves([x + delta_x, y+ delta_y], current_depth + 1, max_depth, current_node)
      end
    end
  end

  def move_posibilities
    [[-1, 2], [1, 2], [2, 1], [2, -1],
     [1, -2], [-1, -2], [-2, 1], [-2, -1], ]
  end

  def out_of_bounds(start, delta)
    x, y = start
    delta_x, delta_y = delta
    x + delta_x > @right_limit ||  x + delta_x < @left_limit ||
      y + delta_y > @upper_limit || y + delta_y < @lower_limit
  end

  def inspect
    p "Max depth is #{ max_depth } | Number of nodes is #{@node_count}"
  end

end

#start = Move.new(0,0)
#p MoveTree.new([0,0],1).out_of_bounds([0,0],[1,2])

# coordinates = [5, 5]

# tree = MoveTree.new(coordinates, 5)

# tree.moves_from
# tree.inspect


