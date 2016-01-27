require 'rails_helper'
require 'support/shared_examples/admin_controller'

describe Admin::ArticlesController do
  include_examples "an admin controller"
  context 'GET new' do

    it 'responds with success' do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'creates a new article' do
      get :new
      expect(assigns(:article)).to be_a(Article)
      expect(assigns(:article)).to be_new_record
    end

    it 'sets a default title' do
      get :new
      expect(assigns(:article).title).to eql('New Article')
    end

    it 'sets blank content' do
      get :new
      expect(assigns(:article).content).to be_empty
    end

  end

  context 'GET index' do

    before do
      5.times do |i|
        admin_user.articles.create!(title: "Content #{i}", content: "Test content")
      end
      @articles = admin_user.articles
    end

    it 'responds with success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'fetches all articles' do
      get :index
      expect(assigns(:articles)).to eql(@articles)
    end

    it 'renders index' do
      get :index
      expect(response).to render_template(:index)
    end

  end

  context 'POST create' do

    before do
      @params = {:article => {:title => 'Test title', :content => 'Test content'}}
    end

    let(:new_article) { assigns(:article) }

    it 'redirects to edit page' do
      post :create, @params
      expect(response).to redirect_to(edit_admin_article_path(new_article))
    end

    it 'creates a new article' do
      post :create, @params
      expect(new_article.title).to eql(@params[:article][:title])
      expect(new_article.content).to eql(@params[:article][:content])
    end

  end

  context 'GET edit' do

    before do
      @params = {:title => 'Test title', :content => 'Test Content'}
      @article = admin_user.articles.create!(@params)
    end

    it 'responds with success' do
      get :edit, :id => @article.id
      expect(response).to have_http_status(:success)
    end

    it 'renders the edit template' do
      get :edit, :id => @article.id
      expect(response).to render_template(:edit)
    end

    it 'fetches the correct article' do
      get :edit, :id => @article.id
      expect(assigns(:article)).to eql(@article)
    end

    context 'with an unknown article ID' do

      before do
        begin
          @id = rand(100)
        end until Article.find_by(:id => @id).nil?
      end

      it 'responds with not found' do
        expect { get :edit, :id => @id }.to raise_error(ActionController::RoutingError)
      end

    end

  end

  context 'PUT update' do

    before do
      @create_params = {:title => 'Test title', :content => 'Test content'}
      @article = admin_user.articles.create!(@create_params)
      @update_params = {:id => @article.id, :article => {:title => 'Updated title', :content => 'Updated content'}}
    end

    it 'updates the provided params' do
      put :update, @update_params
      expect(assigns(:article).title).to eql(@update_params[:article][:title])
      expect(assigns(:article).content).to eql(@update_params[:article][:content])
    end

    it 'redirects to the index page' do
      put :update, @update_params
      expect(response).to redirect_to(admin_articles_path)
    end

  end

  context 'DELETE destroy' do

    before do
      @article = admin_user.articles.create!({:title => 'Test title', :content => 'Test content'})
    end

    it 'removes the article' do
      expect {delete :destroy, :id => @article.id}.to change(admin_user.articles, :count).by(-1)
    end

    it 'redirects to the index page' do
      delete :destroy, {:id => @article.id}
      expect(response).to redirect_to(admin_articles_path)
    end

    context 'with an unknown article ID' do

      before do
        begin
          @id = rand(100)
        end until Article.find_by(:id => @id).nil?
      end

      it 'responds with not found' do
        expect {delete :destroy, :id => @id }.to raise_error(ActionController::RoutingError)
      end

    end
  end

end