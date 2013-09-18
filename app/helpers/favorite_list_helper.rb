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
    
  end
end
