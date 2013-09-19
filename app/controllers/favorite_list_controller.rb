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
  
  def show_correlate
    @correclatedLists = []
    listId = params[:id]
    yourFavoList = FavoriteList.find_by_id(listId)
    typeId = yourFavoList.ranked_list_id
    
    yourFavoItems = FavoriteItem.find_all_by_favorite_list_id(listId)
    yourFavoItems.sort_by{ |e| e[:name] }
    yourRankedItemIds = yourFavoItems.map { |m| m[:ranked_item_id] }
    
    allRankedItems = RankedItem.find_all_by_ranked_list_id(typeId)
    
    # http://stackoverflow.com/questions/5739158/rails-ruby-how-to-sort-an-array
    allRankedItems.sort_by{ |e| e[:name] }
    allRankedItemIds = allRankedItems.map { |m| m[:id] }
    
    # http://stackoverflow.com/questions/6242311/quickly-get-index-of-array-element-in-ruby
    hashAllIndexes = Hash[allRankedItemIds.map.with_index.to_a]
    
    yourIndexes = yourRankedItemIds.map { |m| hashAllIndexes[m] }
    
    # http://api.rubyonrails.org/classes/ActiveRecord/Base.html
    otherFavoLists = FavoriteList.where("ranked_list_id = :ranked_list_id AND user_id <> :user_id",
                                        { ranked_list_id: typeId, user_id: current_user.id })

    correlateChecker = CorrelateChecker.new
    
    otherFavoLists.each do |item|
      otherFavoItems = FavoriteItem.find_all_by_favorite_list_id(item.id)
      otherFavoItems.sort_by{ |e| e[:name] }
      otherRankedItemIds = otherFavoItems.map { |m| m[:ranked_item_id] }
      otherIndexes = otherRankedItemIds.map { |m| hashAllIndexes[m] }
      
      canberra_value = correlateChecker.getDifference(yourIndexes, otherIndexes)
      
      if canberra_value != nil
        corrList = MyFavoriteList.new
        corrList.id = item.id
        corrList.name = item.name
        corrList.type_id = typeId
        corrList.owner_id = item.user_id
        corrList.canberra_value = canberra_value
        
        @correclatedLists.push corrList
      end 
    end
    
    @correclatedLists = @correclatedLists.sort_by { |e| e.canberra_value }
    ownerIds = @correclatedLists.map { |m| m.owner_id }
    users = User.find(ownerIds)
    
    @correclatedLists.each do |item|
      user = users.find{ |x| x.id == item.owner_id }
      item.owner_email = user.email
      
      if (user.fullname == nil || user.fullname == "")
        item.owner_name = user.email
      else
        item.owner_name = user.fullname + " (" + user.email + ")"
      end
    end
    
    respond_to do |format|
      format.json {
        render :json => { :success => true, :data => @correclatedLists }
      }
    end
  rescue Exception => ex
    logger.fatal "Exception in show_correlate action: " + ex.message
    respond_to do |format|
      format.json {
        render :json => { :success => false, :msg => ex.message }
      }
    end
  end
end
