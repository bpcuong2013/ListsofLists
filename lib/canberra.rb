class Canberra
  def distance(u, v)
    n = u.length - 1
    sum = 0.0
    
    for i in 0..n
      denominator = u[i].abs + v[i].abs;
      if denominator != 0
        numerator = (u[i] - v[i]).abs
        sum = sum + numerator / denominator;
      end
    end
    
    return sum;
  end
end