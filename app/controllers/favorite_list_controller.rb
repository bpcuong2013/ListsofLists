class FavoriteListController < ApplicationController
  before_filter :authenticate_user!
  include FavoriteListHelper
  
  def index
  end
  
  def get_favorite_list
    @favorite_list = FavoriteList.find_all_by_user_id(current_user.id)
    #@favorite_list.each do |list|
    #  list.type_name = RankedList.find_by_id(list.rankedlist_id).name
    #end
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
  
  def spellcheck_list
    listName = params[:listName]
    allList = RankedList.all
    @favorite_list = SpellChecker.new.findList(listName, allList)
    respond_to do |format|
      format.json {
          render :json => {:success => true, :data => @favorite_list}
      }
    end
  rescue Exception => ex
    logger.fatal "Exception in spellcheck_list action: " + ex.message
    respond_to do |format|
        format.json {
            render :json => {:success => false, :msg => ex.message}
        }
    end
  end
  
  def spellcheck_item
    typeId = params[:typeId]
    itemName = params[:itemName]
    allItems = RankedItem.find_all_by_rankedlist_id(typeId)
    @favorite_items = SpellChecker.new.findItem(itemName, allItems)
    respond_to do |format|
      format.json {
          render :json => {:success => true, :data => @favorite_items}
      }
    end
  rescue Exception => ex
    logger.fatal "Exception in spellcheck_item action: " + ex.message
    respond_to do |format|
        format.json {
            render :json => {:success => false, :msg => ex.message}
        }
    end
  end
  
  #def get_favorite_list_detail
    
  #end
  
  #def show_correlate
    
  #end
end
