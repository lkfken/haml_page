require 'rspec'
require_relative '../lib/haml_page'

describe HamlPage do
  before(:each) do
    @page = HamlPage.new
  end

  it 'should render view' do
    @page.view = IO.read('./view.haml')
    expect(@page.to_s).to eq("<h3>Here is my view</h3>\n<p>\n  1\n</p>\n<p>\n  2\n</p>\n<p>\n  3\n</p>\n")
  end

  it 'should render layout' do
    @page.layout = IO.read('./layout.haml')
    @page.title = 'Title - Haml Page Sample'
    expect(@page.to_s).to start_with('<!DOCTYPE html>')
    expect(@page.to_s).to match(/<title>Title - Haml Page Sample<\/title>/)
  end

  it 'should render both the layout and the view' do
    @page.view   = IO.read('./view.haml')
    @page.layout = IO.read('./layout.haml')
    @page.title = 'Title - Haml Page Sample'
    expect(@page.to_s).to start_with('<!DOCTYPE html>')
    expect(@page.to_s).to match(/Here is my view/)
  end

  it 'should be saved as a .html file' do
    @page.view   = IO.read('./view.haml')
    @page.layout = IO.read('./layout.haml')
    @page.title = 'Title - Haml Page Sample'
    File.open('./output/page.html', 'w') { |f| f.puts @page }
  end

  it 'should allow user defined variables' do
    @page.view       = IO.read('./user_defined.haml')
    @page.my_comment = 'Hello World'
    @page.name       = 'Kenneth'
    expect(@page.to_s).to eq("<h3>Hello World.  My name is Kenneth</h3>\n")
  end
end