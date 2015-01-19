require_relative '00_tree_node'

class KnightPathFinder

  attr_reader :visited_positions, :starting_pos, :root_node

  CALC_POS = [
    [ 2,  1],
    [ 1,  2],
    [-2, -1],
    [-1, -2],
    [ 2, -1],
    [-2,  1],
    [ 1, -2],
    [-1,  2]
  ]


  def self.valid_moves(pos)
    positions = []
    CALC_POS.each do |calc|
      to_add = [calc[0] + pos[0], calc[1] + pos[1]]
      positions << to_add if to_add.all? { |coor| coor.between?(0,7) }
    end

    positions
  end


  def initialize(pos)
    @starting_pos = pos
    @visited_positions = [@starting_pos]
  end

  def new_move_positions(pos)
    new_moves = KnightPathFinder.valid_moves(pos)
    new_moves.reject!{|move| @visited_positions.include?(move)}
    @visited_positions.concat(new_moves)
    new_moves
  end

  def build_move_tree
    @root_node = PolyTreeNode.new(starting_pos)
    queue = [@root_node]
    until queue.empty?
      current = queue.shift

      current_children = new_move_positions(current.value)
                          .map { |pos| PolyTreeNode.new(pos) }

      current_children.each { |child| child.parent = current }
      queue.concat(current_children)
    end
  end

  def find_path(end_pos)
    @root_node.dfs(end_pos).trace_path_back
  end



end
