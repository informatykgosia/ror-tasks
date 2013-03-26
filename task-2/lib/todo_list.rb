class TodoList

  # Initialize the TodoList with +items+ (empty by default).
  def initialize(items=[])
    if items[:db] == nil
      raise IllegalArgument
    elsif
      @database = items[:db]
    end
  end

  def size
    @database.items_count
  end

  def empty?
    true if @database.items_count == 0
  end

  def << (other_object)
    if other_object == nil
      raise IllegalArgument  
    elsif other_object[:title] == ""
      nil  
    else
      @database.add_todo_item(other_object)
    end
  end

  def first
    @database.get_todo_item(0)
  end

  def last
    @database.get_todo_item(self.size - 1)
  end
  
  def toggle_state(index)
    if @database.todo_item_completed?(index)
      @database.complete_todo_item(0, true)
    else
      @database.complete_todo_item(index, false)
    end
  end
end
