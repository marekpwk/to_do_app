require 'spec_helper'

describe 'Creating todo lists' do

  def create_todo_list(options={})
    options[:title] ||= 'My todo list'
    options[:description] ||= 'This is my to do list'
    visit '/todo_lists'
    click_link 'New Todo list'
    expect(page).to have_content('New todo_list')

    fill_in 'Title', with: options[:title]
    fill_in 'Description', with: options[:description]
    click_button 'Create Todo list'

  end

  it 'redirects to the todo list index page on success' do
    create_todo_list
    expect(page).to have_content('My todo list')
  end

  it 'displays an error when the todo list has no tilte' do
    expect(TodoList.count).to eq(0)

    create_todo_list title: ''

    expect(page).to have_content('error')
    expect(TodoList.count).to eq(0)

    visit '/todo_lists'
    expect(page).to_not have_content('This is my to do list')
  end

  it 'displays an error when title has less than 3 characters' do
    expect(TodoList.count).to eq(0)

    create_todo_list title: 'Hi'

    expect(page).to have_content('error')
    expect(TodoList.count).to eq(0)

    visit '/todo_lists'
    expect(page).to_not have_content('This is what I need today')
  end

   it 'displays an error when description is not present' do
    expect(TodoList.count).to eq(0)

    create_todo_list title: 'My grocery list', description: ''

    expect(page).to have_content('error')
    expect(TodoList.count).to eq(0)

    visit '/todo_lists'
    expect(page).to_not have_content('My grocery list')
  end


   it 'displays an error when description has less than 5 characters' do
    expect(TodoList.count).to eq(0)

    create_todo_list title: 'My grocery list', description: 'Food'

    expect(page).to have_content('error')
    expect(TodoList.count).to eq(0)

    visit '/todo_lists'
    expect(page).to_not have_content('My grocery list')
  end

end