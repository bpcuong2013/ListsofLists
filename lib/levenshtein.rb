class Levenshtein
  def distance(s, t)
    m = s.length
    n = t.length
    
    return m if n == 0
    return n if m == 0
    
    dm = Array.new(m + 1) { Array.new(n + 1) } # distance matrix
    
    # Initialize first row values
    (0..m).each { |i| dm[i][0] = i }
    
    # Initialize first column values
    (0..n).each { |j| dm[0][j] = j }
    
    (1..n).each do |j|
      (1..m).each do |i|
        if s[i-1] == t[j-1] # adjust index into string
          dm[i][j] = dm[i-1][j-1] # no operation required
        else
          dm[i][j] = [
                        dm[i-1][j] + 1, # deletion
                        dm[i][j-1] + 1, # insertion
                        dm[i-1][j-1] + 1 # substitution
                     ].min
        end
      end
    end
    
    dm[m][n]
  end
end
