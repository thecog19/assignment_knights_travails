require_relative "move_tree"
class Knight

  def initialize(args = {})
    @position = args[:start] || [1, 0]
  end

  def move_to(destination)
    available_moves = generate_moves(@position)
    move = breadth_first_search(available_moves, destination)
#p move
    move_sequence = move_sequence(move)
    format_move_sequence(move_sequence)
  end

  def generate_moves(position, move_depth = 5)
    moves = MoveTree.new(position, move_depth)
    moves.generate_moves
    moves
  end

  def breadth_first_search(move_tree, destination = @position)
    queue = []
    queue.unshift(move_tree.root)
    until queue.empty?
puts"#{queue}\n\n"
      current_node = queue.pop
      return current_node if target_square?(current_node, destination)
      current_node.children.each do |child|
        queue.unshift(child) if child
      end
    end
    false
  end

  def target_square?(node, destination)
    [node.x, node.y] == destination
  end

  def move_sequence(move)
    current_move = move
    move_list = []
    while current_move.parent
      move_list << current_move
      current_move = current_move.parent
    end
    move_list
  end

  def format_move_sequence(move_sequence)
    move_sequence = move_sequence.map { |node| "#{node.x}, #{node.y}" }
    move_sequence.unshift("#{@position[0]}, #{@position[1]}")
    move_sequence.join(" -> ")
  end

end

puts Knight.new.move_to([3,4])
