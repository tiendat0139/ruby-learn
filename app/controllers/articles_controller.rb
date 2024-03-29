class ArticlesController < ApplicationController

  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_permission, only: [:edit, :destroy]
  
  def show
  end

  def index
    category = params[:category]
    if category
      @articles = Category.find_by(name: category).articles.paginate(page: params[:page], per_page: 4)
    else
      @articles = Article.all.paginate(page: params[:page], per_page: 4)
    end
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:notice] = "Article was created successfully"
      redirect_to @article
    else
      render 'new'
    end 
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article was updated successfully"
      redirect_to @article
    else 
      flash[:errors] = @article.errors.full_messages
      redirect_to edit_article_path(@article)
    end
  end

  def destroy 
    @article.destroy
    redirect_to articles_path
  end

  private
  
  def set_article 
    @article = Article.find(params[:id]);
  end

  def article_params
    params.require(:article).permit(:title, :description, category_ids: [])
  end

  def require_permission
    if current_user != @article.user && !current_user.admin?
      redirect_to article_path(@article)
    end
  end

end