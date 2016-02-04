require 'rails_helper'

describe 'article CRUD' do
  include SignInHelper

  before(:all) do
    @user = FactoryGirl.create(:admin)
  end

  before do
    sign_in
  end

  after do
    sign_out
  end

  after(:all) do
    @user.articles.delete_all
    @user.destroy
  end

  context 'creating a new article' do

    it 'presents a title and content form' do
      visit '/admin/articles/new'
      expect(page).to have_field('Title')
      expect(page).to have_field('Content')
    end

    it 'presents the new article in the edit page' do
      test_title, test_content = 'Test Article', 'This is a test'
      visit '/admin/articles/new'
      fill_in 'Title', :with => test_title
      fill_in 'Content', :with => test_content
      click_button 'Save'

      expect(page).to have_field('Title')
      expect(find_field('Title').value).to eql(test_title)
      expect(page).to have_field('Content')
      expect(find_field('Content').value).to eql(test_content)
    end

  end

  context 'editing an existing article' do

    before do
      @article = @user.articles.create(:title => 'Test Title', :content => 'This is a test')
    end

    it 'presents a title and content form' do
      visit "/admin/articles/#{@article.id}/edit"
      expect(page).to have_field('Title')
      expect(page).to have_field('Content')
    end

    it 'updates the article model' do
      updated_title, updated_content = 'Updated Title', 'Updated content...'
      expect(updated_title).to_not eql(@article.title)
      expect(updated_content).to_not eql(@article.content)

      visit "/admin/articles/#{@article.id}/edit"
      fill_in 'Title', :with => updated_title
      fill_in 'Content', :with => updated_content
      click_button 'Save'

      #@article = Article.find(@article.id)
      @article.reload
      @article.fetch_content
      expect(@article.title).to eql(updated_title)
      expect(@article.content).to eql(updated_content)
    end

  end

  context 'viewing all articles' do

    before do
      5.times do |i|
        @user.articles.create!(:title => "Article #{i}", :content => "Article content #{i}")
      end
    end

    it 'displays all articles for the current user' do
      visit '/admin/articles'
      @user.articles.each do |article|
        expect(page).to have_content(article.title)
      end
    end

  end

end