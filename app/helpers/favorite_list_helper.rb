module FavoriteListHelper
  class SpellChecker
    def findList(favoriteName, lists)
      tolerance_limit = 2 # The maximum edit distance allowed for corrected words
      m = favoriteName.length
      lower_bound = m - tolerance_limit
      upper_bound = m + tolerance_limit
      result = []
      levenshtein = Levenshtein.new
      favoNameDowncase = favoriteName.downcase
      
      lists.each do |list|
        n = list.name.length
        pickedSuccess = false
        
        if lower_bound <= n && n <= upper_bound
          levenshtein_distance = levenshtein.distance(favoNameDowncase, list.name)
          if levenshtein_distance <= tolerance_limit
            result.push list
            pickedSuccess = true
          end
        end
        
        if pickedSuccess == false
          if searchString(list.name, favoNameDowncase)
            result.push list
          end
        end
      end
      
      return result
    end
    
    def findItem(favoriteName, items)
      tolerance_limit = 2 # The maximum edit distance allowed for corrected words
      m = favoriteName.length
      lower_bound = m - tolerance_limit
      upper_bound = m + tolerance_limit
      result = []
      levenshtein = Levenshtein.new
      favoNameDowncase = favoriteName.downcase 
      
      items.each do |item|
        n = item.name.length
        pickedSuccess = false
        
        if lower_bound <= n && n <= upper_bound
          levenshtein_distance = levenshtein.distance(favoNameDowncase, item.name)
          if levenshtein_distance <= tolerance_limit
            result.push item
            pickedSuccess = true
          end
        end
        
        if pickedSuccess == false
          if searchString(item.name, favoNameDowncase)
            result.push item
          end
        end
      end
      
      return result
    end
    
    private
    def searchString(originalText, searchTokenDowncase)
      return originalText.downcase.include? searchTokenDowncase
    end
  end
  
  class CorrelateChecker
    def getDifference(arr1, arr2)
      if arr1.length == 0 || arr2.length == 0
        return nil
      end
      
      mergedResult = (arr1 | arr2).sort
      list1 = []
      list2 = []
      specialValue = -1
      
      #mergedResult.each do |item|
      #  if arr1.include? item
      #    list1.push item
      #  else
      #    list1.push specialValue
      #  end
        
      #  if arr2.include? item
      #    list2.push item
      #  else
      #    list2.push specialValue
      #  end
      #end
      
      all_hash = { }
      arr1_hash = { }
      arr2_hash = { }
      
      (0..(arr1.length-1)).each do |i|
        result = arr1[i]
        
        if all_hash.has_key?(result)
          all_hash[result] += 1
        else
          all_hash[result] = 1
        end
        
        arr1_hash[result] = i
      end
      
      (0..(arr2.length-1)).each do |i|
        result = arr2[i]
        
        if all_hash.has_key?(result)
          all_hash[result] += 1
        else
          all_hash[result] = 1
        end
        
        arr2_hash[result] = i
      end
      
      all_hash.keys.each do |key|
        if arr1_hash.has_key?(key)
          list1.push arr1_hash[key]
        else
          list1.push specialValue
        end
        
        if arr2_hash.has_key?(key)
          list2.push arr2_hash[key]
        else
          list2.push specialValue
        end
      end
      
      #puts all_hash
      #puts arr1_hash
      #puts arr2_hash
      #puts list1
      #puts list2
      
      #return Canberra.new.distance(list1, list2)
      return Canberra.new.distanceq(list1, list2, false, true, true)
    end
  end
end
