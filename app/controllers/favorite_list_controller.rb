class FavoriteListController < ApplicationController
  before_filter :authenticate_user!
  def index
  end
  
  def get_favorite_list
    @favorite_list = FavoriteList.find_all_by_user_id(current_user.id)
    respond_to do |format|
      format.json {
          render :json => {:success => true, :data => @favorite_list}
      }
    end
  rescue Exception => ex
    logger.fatal "Exception in get_favorite_list action: " + ex.message
    respond_to do |format|
        format.json {
            render :json => {:success => false, :msg => ex.message}
        }
    end
  end
  
  #def spellcheck_list
    
  #end
  
  #def spellcheck_item
    
  #end
  
  def get_favorite_list_detail
    
  end
  
  #def show_correlate
    
  #end
end
