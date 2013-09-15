module FavoriteListHelper
  class SpellChecker
    def findList(favoriteName, lists)
      tolerance_limit = 2 # The maximum edit distance allowed for corrected words
      m = favoriteName.length
      lower_bound = m - tolerance_limit
      upper_bound = m + tolerance_limit
      result = []
      levenshtein = Levenshtein.new
      
      lists.each do |list|
        n = list.name.length
        if lower_bound <= n && n <= upper_bound
          levenshtein_distance = levenshtein.distance(favoriteName, list.name)
          if levenshtein_distance <= tolerance_limit
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
      
      items.each do |item|
        n = item.name.length
        if lower_bound <= n && n <= upper_bound
          levenshtein_distance = levenshtein.distance(favoriteName, item.name)
          if levenshtein_distance <= tolerance_limit
            result.push item
          end
        end
      end
      
      return result
    end
  end
  
  class CorrelateChecker
    
  end
end
