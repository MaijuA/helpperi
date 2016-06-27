class UsersController < ApplicationController

  def show
    @user = User.find params[:id]
    @user_posts = @user.posts.active.valid
    if current_user == @user
      @user_expired_posts = @user.posts.active.expired
    end
  end

  def review
    @post = Post.find params[:post_id]
  end

  def ratings
    @user = User.find(params[:id])
  end

  # GET /posts
  # GET /posts.json
  def index
    @rating = Rating.new
    if current_user
      params[:page1] = 1 if params[:page1] == ''
      params[:page2] = 1 if params[:page2] == ''
      params[:page3] = 1 if params[:page3] == ''
      params[:page4] = 1 if params[:page4] == ''

      @user_posts = current_user.posts.active.valid.paginate(:page => params[:post_page], :per_page => 5)

      @user_selling_posts = current_user.posts.valid.not_rated.selling
      @user_buying_posts = current_user.posts.valid.not_rated.buying
      @user_performer_posts = Post.where(doer_id:current_user.id).valid
      @user_performer_buying_posts = Post.where(doer_id:current_user.id).valid.buying # ne joissa ratings.count < 2
      @user_performer_selling_posts = Post.where(doer_id:current_user.id).valid.selling # ne joissa ratings.count < 2

      @user_accepted_posts = current_user.posts.valid.accepted.not_rated.paginate(:page => params[:accepted_page], :per_page => 5)
      @user_expired_posts = current_user.posts.active.expired.paginate(:page => params[:expired_page], :per_page => 5)
      @user_performed_posts = current_user.posts.rated.paginate(:page => params[:expired_page], :per_page => 5)

    end
  end

  def history
    if current_user
      params[:page1] = 1 if params[:page1] == ''
      params[:page2] = 1 if params[:page2] == ''
      params[:page3] = 1 if params[:page3] == ''
      @user_expired_posts = current_user.posts.active.expired.paginate(:page => params[:expired_page], :per_page => 5)
      @user_performed_buying_tasks = current_user.posts.rated.buying
      @user_performed_selling_tasks = current_user.posts.rated.selling
      @user_performed_buying_posts = Post.where(doer_id:current_user.id).rated.buying
      @user_performed_selling_posts = Post.where(doer_id:current_user.id).rated.selling

      @user_performed_posts = current_user.posts.rated.paginate(:page => params[:expired_page], :per_page => 5)
      @user_performed_tasks = Post.where(doer_id:current_user.id).rated.paginate(:page => params[:tasks_page], :per_page => 5)
    end
  end

  # def interests
  #   if current_user
  #     params[:page1] = 1 if params[:page1] == ''
  #     params[:page2] = 1 if params[:page2] == ''
  #     params[:page3] = 1 if params[:page3] == ''
  #     @user_tasks = current_user.tasks.active.valid.not_rated.paginate(:page => params[:tasks_page], :per_page => 5)
  #     @user_performer_posts = Post.where(doer_id:current_user.id).valid.not_rated.paginate(:page => params[:performer_page], :per_page => 5)
  #     @user_performed_tasks = Post.where(doer_id:current_user.id).rated.paginate(:page => params[:tasks_page], :per_page => 5)
  #   end
  # end

  def create_rating
    @post = Post.find(params[:post_id])
    if current_user == @post.user || current_user == @post.performer
      @rating = Rating.create reviewer_id:params[:reviewer_id], reviewed_id:params[:reviewed_id], review:params[:review], score:params[:score], post_id:params[:post_id]
    if @rating.save
        redirect_to users_path, notice: "Arviointi onnistui"
    else
      if params[:score].to_i < 1 || params[:score].to_i > 3
        redirect_to :back, alert: "Sinun täytyy valita tähtien määrä"
      else
        redirect_to users_path, notice: "Arviointi epäonnistui"
      end
    end
    end
  end
end