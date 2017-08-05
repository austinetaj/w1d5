require_relative "poly_tree_node.rb"

class KnightPathFinder
  def initialize(start_pos)
    @visited_positions = [start_pos]
    @start_pos = start_pos
    @move_tree = build_move_tree(@start_pos)
  end
  def build_move_tree(parent_pos)
    root = PolyTreeNode.new(parent_pos)
    queue = [root]
    until queue.empty?
      front = queue.shift
      new_move_positions(front.value).each do |pos|
        child = PolyTreeNode.new(pos)
        child.parent = front
        queue.concat([child])
      end
    end
    root
  end

  def valid_moves(pos)
    possible_moves = []
    jumps = [[2,1],[2,-1],[1,2],[1,-2],[-2,1],[-2,-1],[-1,2],[-1,-2]]

    jumps.each do |move|
      x = move[0] + pos[0]
      y = move[1] + pos[1]
      if valid_move?([x, y])
        possible_moves << [x, y]
        @visited_positions << [x ,y]
      end
    end
    possible_moves
  end
  def valid_move?(pos)
    pos[0].between?(0,7) && pos[1].between?(0,7) && !@visited_positions.include?(pos)
  end

  def new_move_positions(pos)
    valid_moves(pos)
  end

  def find_path(end_pos)

    trace_path_back(@move_tree.bfs(end_pos))
  end
  def trace_path_back(end_pos_node)
    tree_path = [end_pos_node]
    until tree_path.first == @move_tree
      tree_path.unshift(tree_path.first.parent)
    end

    tree_path.map{|el| el.value }
  end
end


kpf = KnightPathFinder.new([0,0])
p kpf.find_path([6,5])


# kpf.findpath([2,1])
# kpf.findpath([3,3])
