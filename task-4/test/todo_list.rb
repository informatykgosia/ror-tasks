require_relative 'test_helper'
require_relative '../lib/todo_list'

describe TodoList do
  include TestHelper

  subject(:list)    { TodoList.create(title: title, user_id: user_id) }
  let(:title)       { "Zakupy" }
  let(:user_id)        { 1 }

  it "should pass validation" do
    list.should be_valid
  end

  it "should persist itself" do
    list
    TodoList.last.title.should == "Zakupy"
    TodoList.count.should == 4
  end

  context "without attribute title" do
    let(:title) { nil }
    it { should_not be_valid }
  end

  context "without attribute user_id" do
    let(:user_id) { nil }
    it { should_not be_valid }
  end

  it "should find all lists of given user" do
    add_list
    TodoList.find_by_user(User.find_by_email("lubiepracowac@gmail.com")).count.should == 2
  end

  it "should find list by id and egearly load its items" do
    list = TodoList.find_with_items(fixture_id(:first_list))
    list.title.should == "Pierwsza lista"
    list.todo_items.count.should == 3
  end

  protected

  def add_list
    list
  end
end
