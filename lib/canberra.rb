class Canberra
  # Canberra distance
  def distance(u, v)
    if u.length != v.length
      return nil
    end
    
    n = u.length - 1
    sum = 0.0
    
    for i in 0..n
      if u[i] == -1 || v[i] == -1
        sum += 1.0 / n
      else
        denominator = u[i].abs + v[i].abs;
        if denominator != 0
          numerator = (u[i] - v[i]).abs
          sum += numerator / denominator;
        end
      end
    end
    
    return sum;
  end
  
  def distance_v1(u, v)
    ne = u.length
    
    if ne != v.length
      return nil
    end
    
    k = ne
    helper = CanberraHelper.new
    distance = helper.canberra_location(u, v, k)
    exact = helper.exact_canberra(ne, k)
  end
  
  # Qualified canberra distance
  # u and v are vectors of integers with length equal 
  def distanceq(u, v, complete, normalize, forcenormal)
    ne = u.length
        
    if ne != v.length
      return nil
    end
    
    helper = CanberraHelper.new
    distance = helper.canberra_quotient(u, v, complete, normalize)
    distnorm = 0.0
    
    if forcenormal
      maxdist = helper.max_dist(ne)
      distnorm = distance / maxdist
    else
      exact = helper.exact_canberra(ne, ne)
      distnorm = distance / exact
    end
    
    return distnorm
  end
end