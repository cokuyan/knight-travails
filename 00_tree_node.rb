class PolyTreeNode

  attr_reader :children, :parent, :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    @parent.children.delete(self) unless @parent.nil?
    @parent = node
    @parent.children << self unless @parent.nil?
  end

  def add_child(child_node)
    child_node.parent = self

  end

  def remove_child(child)
    raise "Not a child" unless children.include?(child)
    child.parent = nil

  end

  def dfs(target_value)
    return self if value == target_value
    children.each do |child|
      result = child.dfs(target_value)
      return result if result
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      current = queue.shift
      return current if current.value == target_value
      queue.concat(current.children)
    end
    nil
  end

  def trace_path_back
    path = [self.value]
    current = self
    until current.nil?
      path << current.parent.value unless current.parent.nil?
      current = current.parent
    end
    path.reverse
  end
end
