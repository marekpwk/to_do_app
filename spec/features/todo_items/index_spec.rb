require 'spec_helper'

describe 'Viewing to todo items' do
  let!(:todo_list) { TodoList.create(title: 'Grocery list',
                                     description: 'Groceries')}
  it 'dispalys no items when a todo list is empty' do
    visit '/todo_lists'
    within "#todo_list_#{todo_list.id}" do
      click_link 'List items'
    end
    expect(page).to have_content("TodoItems#index")  
  end
end