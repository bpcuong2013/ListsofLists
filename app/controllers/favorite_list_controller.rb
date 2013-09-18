class FavoriteListController < ApplicationController
  before_filter :authenticate_user!
  include FavoriteListHelper
  
  def index
  end
  
  def get_favorite_list
    favorite_list = FavoriteList.find_all_by_user_id(current_user.id)
    ranked_list = { }
    @my_favorite_list = []
    
    favorite_list.each do |list|
      #list.type_name = RankedList.find_by_id(list.ranked_list_id).name
      #list.ranked_list = RankedList.find_by_id(list.ranked_list_id)
      
      if !ranked_list.has_key?(list.ranked_list_id)
        ranked_list[list.ranked_list_id.to_s] = RankedList.find_by_id(list.ranked_list_id)
      end
      
      myFavoriteList = MyFavoriteList.new
      myFavoriteList.id = list.id
      myFavoriteList.name = list.name
      myFavoriteList.type_id = list.ranked_list_id
      myFavoriteList.type_name = ranked_list[list.ranked_list_id.to_s].name
      
      @my_favorite_list.push myFavoriteList
    end
    respond_to do |format|
      format.json {
        render :json => { :success => true, :data => @my_favorite_list }
      }
    end
  rescue Exception => ex
    logger.fatal "Exception in get_favorite_list action: " + ex.message
    respond_to do |format|
      format.json {
        render :json => { :success => false, :msg => ex.message }
      }
    end
  end
  
  def spellcheck_list
    listName = params[:listName]
    allList = RankedList.all
    @favorite_list = SpellChecker.new.findList(listName, allList)
    respond_to do |format|
      format.json {
        render :json => { :success => true, :data => @favorite_list }
      }
    end
  rescue Exception => ex
    logger.fatal "Exception in spellcheck_list action: " + ex.message
    respond_to do |format|
      format.json {
        render :json => { :success => false, :msg => ex.message }
      }
    end
  end
  
  def spellcheck_item
    typeId = params[:typeId]
    itemName = params[:itemName]
    allItems = RankedItem.find_all_by_ranked_list_id(typeId)
    @favorite_items = SpellChecker.new.findItem(itemName, allItems)
    respond_to do |format|
      format.json {
        render :json => { :success => true, :data => @favorite_items }
      }
    end
  rescue Exception => ex
    logger.fatal "Exception in spellcheck_item action: " + ex.message
    respond_to do |format|
      format.json {
        render :json => { :success => false, :msg => ex.message }
      }
    end
  end
  
  def create_favorite_list
    typeId = params[:typeId]
    listName = params[:listName]
    items = params[:items]
    
    if typeId == ""
      rankedList = RankedList.new :name => listName
      favoriteList = rankedList.favorite_lists.build(:name => listName, :user_id => current_user.id)
      
      items.each do |item|
        rankedItem = rankedList.ranked_items.build(:name => item[:name])
        #rankedItem.favorite_items.build(:name => item[:name], :favorite_list => favoriteList)
        favoriteItem = rankedItem.favorite_items.build(:name => item[:name])
        favoriteItem.favorite_list = favoriteList
      end
      
      rankedList.save
    else
      rankedList = RankedList.find_by_id(typeId)
      favoriteList = rankedList.favorite_lists.build(:name => listName, :user_id => current_user.id)
      
      items.each do |item|
        if item[:id] == ""
          rankedItem = rankedList.ranked_items.build(:name => item[:name])
          favoriteItem = rankedItem.favorite_items.build(:name => item[:name])
          favoriteItem.favorite_list = favoriteList
        else
          favoriteList.favorite_items.build(:name => item[:name], :ranked_item_id => item[:id])
        end
      end
      
      rankedList.save
    end
    
    respond_to do |format|
      format.json {
        render :json => { :success => true }
      }
    end
  rescue Exception => ex
    logger.fatal "Exception in create_favorite_list action: " + ex.message
    respond_to do |format|
      format.json {
        render :json => { :success => false, :msg => ex.message }
      }
    end
  end
  
  def delete_favorite_list
    listId = params[:id]
    FavoriteList.destroy(listId)
    
    respond_to do |format|
      format.json {
        render :json => { :success => true }
      }
    end
  rescue Exception => ex
    logger.fatal "Exception in delete_favorite_list action: " + ex.message
    respond_to do |format|
      format.json {
        render :json => { :success => false, :msg => ex.message }
      }
    end
  end
  
  def get_favorite_list_detail
    listId = params[:id]
    @favorite_items = FavoriteItem.find_all_by_favorite_list_id(listId)
    
    respond_to do |format|
      format.json {
        render :json => { :success => true, :data => @favorite_items }
      }
    end
  rescue Exception => ex
    logger.fatal "Exception in get_favorite_list_detail action: " + ex.message
    respond_to do |format|
      format.json {
        render :json => { :success => false, :msg => ex.message }
      }
    end
  end
  
  #def show_correlate
    
  #end
end
