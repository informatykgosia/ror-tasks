class TodoList

  # Initialize the TodoList with +items+ (empty by default).
  def initialize(items=[])
    @items=items
    @list={}
    if @items==nil
     raise IllegalArgument
    end
  end
 
  def empty?
    @items.empty?
  end

  def complete(index)
    @list[@items[index]]=true
  end

  def completed?(action)
    true if @list[@items[action]] == true
    
  end

  def uncompleted
    @list[@items[index]]=false
  end
 
  def size
     @items.size
  end
  
  def <<(something)
    @items << something
    @list[something]=false
    
  end

  def first
    @items.first
  end

  def last
    @items.last
  end
end
