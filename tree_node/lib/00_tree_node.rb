require 'byebug'

class PolyTreeNode
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent=(new_parent)
    @parent.children.delete(self) if @parent
    @parent = new_parent
    new_parent.children << self if new_parent

  end
  def add_child(child_node)
    child_node.parent = self
  end
  def remove_child(child_node)
    raise "Node is not a child!" unless @children.include?(child_node)
    child_node.parent = nil
    @children.delete(child_node)
  end

  def dfs(target_value)
    return self if self.value == target_value
    self.children.each do |child|
      result = child.dfs(target_value)
      return result unless result == nil
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      front = queue.shift
      return front if front.value == target_value
      #debugger
      queue.concat(front.children) 
    end
    nil
  end
end
