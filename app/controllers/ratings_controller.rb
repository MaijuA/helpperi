class RatingsController < ApplicationController

  def create
    Rating.create reviewer_id:params[:reviewer_id], reviewed_id:params[:reviewed_id], review:params[:review], score:params[:score], post_id:params[:post_id]
    redirect_to :back, notice: "Arviointi onnistui"
  end

end