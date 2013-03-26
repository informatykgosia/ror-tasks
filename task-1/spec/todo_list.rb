require 'bundler/setup'
require 'rspec/expectations'
require_relative '../lib/todo_list'
require_relative '../lib/exceptions'

describe TodoList do
  subject(:list)            { TodoList.new(items) }
  let(:items)               { [] }
  let(:item_description)    { "Buy toilet paper" }
    
  def compare_lists(output_list, compare_list)
    output_list.each do |item|
      break if item != compare_list.shift
    end
    compare_list.should be_empty
  end

  it { should be_empty }

  it "should raise an exception when nil is passed to the constructor" do
    expect { TodoList.new(nil) }.to raise_error(IllegalArgument)
  end

  it "should have size of 0" do
    list.size.should == 0
  end

  it "should accept an item" do
    list << item_description
    list.should_not be_empty
  end

  it "should add the item to the end" do
    list << item_description
    list.last.to_s.should == item_description
  end

  it "should have the added item uncompleted" do
    list << item_description
    list.completed?(0).should be_false
  end

  context "with one item" do
    let(:items)             { [item_description] }

    it { should_not be_empty }

    it "should have size of 1" do
      list.size.should == 1
    end

    it "should have the first and the last item the same" do
      list.first.to_s.should == list.last.to_s
    end

    it "should not have the first item completed" do
      list.completed?(0).should be_false
    end

    it "should change the state of a completed item" do
      list.complete(0)
      list.completed?(0).should be_true
    end 
    
    it "should change the state of a item to uncomplited" do
      list.uncomplete(0)
      list.completed?(0).should be_false
    end 
  end

  context "with many items" do
    before:each do
      list.remove_items
      list << "Watch a movie!"
      list << "Go to sleep"
      list << "Buy a cat"
      list << "Read a book"
      list << "Make pancakes!"
      list.complete(1)
      list.complete(3)
    end

    it "should return array containing completed items" do
      output_list = list.return_completed
      compare_lists(output_list, ["Go to sleep", "Read a book"])
    end
    
    it "should return array containing uncompleted items" do
      output_list = list.return_uncompleted
      compare_lists(output_list, ["Watch a movie!","Buy a cat", "Make pancakes!"])
    end
    
    it "should delete all items" do
      list.remove_items
      list.should be_empty
    end

    it "should delete item specified by value" do
      list.delete("Watch a movie!")
      list.first.should == "Go to sleep"
    end

    it "should delete item specified by index" do
      list.delete_at(0)
      list.first.should == "Go to sleep"
    end

    it "should remove all completed items" do
      output_list = list.remove_completed
      compare_lists(output_list, ["Watch a movie!","Buy a cat", "Make pancakes!"])
    end

    it "should revert order of two items" do  
      list[0].should == "Watch a movie!"
      list[2].should == "Buy a cat"
      list.revert(0, 2)
      list[0].should == "Buy a cat"
      list[2].should == "Watch a movie!"
    end

    it "should revert order of all items" do
      output_list = list.revert
      compare_lists(output_list, ["Make pancakes!", "Read a book", "Buy a cat", "Go to sleep", "Watch a movie!"])
    end

    it "should sort all the items" do
      output_list = list.sort
      compare_lists(output_list, ["Watch a movie!", "Go to sleep", "Buy a cat", "Read a book", "Make pancakes!"])
    end

    it "should allows to change item describtion" do
      list[2] = "Love your cat"
      list[2].should == "Love your cat"
    end

    it "List should look like this!" do
      printed = list.print
    end

  end
end
