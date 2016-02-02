class Admin::ArticlesController < AdminController
  def new
    @article = Article.new(title: 'New Article', content: "")
  end

  def create
    @article = @current_user.articles.create!(article_params)
    redirect_to edit_admin_article_path(@article)
  end

  def index
    # TODO: Pagination
    @articles = @current_user.articles
  end

  def edit
    @article = Article.find_by(:id => params[:id])
    not_found if @article.nil?
  end

  def update
    @article = Article.find(params[:id])
    @article.update!(article_params)
    @article.sync
    redirect_to admin_articles_path
  end

  def destroy
    @article = Article.find_by(:id => params[:id])
    not_found if @article.nil?
    @article.destroy!
    redirect_to admin_articles_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :content)
    end

    def not_found
      raise ActionController::RoutingError.new('Article Not Found')
    end

end
