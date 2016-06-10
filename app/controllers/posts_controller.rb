class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]

  def index
    @posts = Post.all.valid.active
    @post_accepted = Post.all.valid.accepted
    @posts_selling = Post.all.active.valid.selling
    @posts_buying = Post.all.active.valid.buying
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
    @categories = Category.all
    @edit = false
    # Kuvaukset editointilomakkeen "Hae kategorian kuvausehdotus" -toiminnallisuutta varten
    gon.clear
    gon.default_description = ""
    misc = Category.select { |category| category.name == 'Muu' }
    gon.default_description = misc[0].description unless misc.empty?
    gon.descriptions = Hash[Category.all.map {|a| [a.id, a.description]}]
  end

  # GET /posts/1/edit
  def edit
    @edit = true
    # Kuvaukset editointilomakkeen "Hae kategorian kuvausehdotus" -toiminnallisuutta varten
    gon.clear
    gon.default_description = ""
    misc = Category.select { |category| category.name == 'Muu' }
    gon.default_description = misc[0].description unless misc.empty?
    gon.descriptions = Hash[Category.all.map {|a| [a.id, a.description]}]
  end

  # POST /posts
  # POST /posts.json
  def create
    if current_user && current_user.valid?
      @post = Post.new(post_params)
      @post.user_id = current_user.id
      @post.deleted = false

      respond_to do |format|
        if @post.save
          format.html { redirect_to @post, notice: 'Ilmoitus luotu onnistuneesti.' }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render :new }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params) and @post.user == current_user
        format.html { redirect_to @post, notice: 'Ilmoitus muokattu onnistuneesti.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete_post
    post = Post.find(params[:post_id])
    if current_user && post.user.id == current_user.id
      post.update_attribute(:deleted, true)
    end
    if post.deleted
      redirect_to posts_url, notice: 'Ilmoitus on poistettu onnistuneesti.'
    else
      redirect_to post_path(post), notice: 'Ilmoitusta ei voitu poistaa. Ole yhteydessä asiakaspalveluun.'
    end
  end

  def add_candidate
    post = Post.find(params[:post_id])
    if current_user && !post.helpers.include?(current_user) && current_user != post.user
      candi = Candidate.create post_id:post.id, user_id:current_user.id, denied:false
    end
    if candi.save
      redirect_to :back, notice: 'Sinut on lisätty kiinnostuneeksi.'
    else
      redirect_to :back, alert: 'Kiinnostuneeksi ilmoittautuminen ei onnistunut.'
    end
  end

  def deny_candidate
    post = Post.find(params[:post_id])
    if current_user && current_user == post.user
      candi = Candidate.find_by post_id:post.id, user_id:params[:user_id]
      candi.update_attribute(:denied, true)
    end
    if candi.save
      redirect_to :back, notice: 'Kiinnostunut on hylätty onnistuneesti.'
    else
      redirect_to :back, alert: 'Kiinnostuneen hylkääminen ei onnistunut.'
    end
  end

  def accept_candidate
    post = Post.find(params[:post_id])
    if current_user && current_user == post.user
      post.accepted_candidates.each do |c|
        c.update_attribute(:denied, true)
      end
      post.update_attribute(:doer_id, params[:user_id])
    end
    if !post.doer_id.nil?
      redirect_to :back, notice: 'Kiinnostunut on hyväksytty onnistuneesti.'
    else
      redirect_to :back, alert: 'Kiinnostuneen hyväksyminen ei onnistunut.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :description, :price, :post_type, :ending_date, :address, :zip_code, :city, :radius, :image, :remove_image, :image_cache, category_ids: [])
    end
end
