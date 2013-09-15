class CanberraHelper
  # Finds the harmonic value for the value n
  def harm(n)
    sum = 0.0
    
    (1..n).each do |i|
      sum += 1.0 / i.to_f
    end
    
    return sum
  end
  
  def e_harm(n)
    return 0.5 * harm((n.to_f / 2.0).floor)
  end
  
  def o_harm(n)
    return (harm(n) - e_harm(n))
  end
  
  def a_harm(n)
    return o_harm(n) if n.even?
    return e_harm(n)
  end
  
  def xi(s)
    return ((s + 0.5) * (s + 0.5) * harm(2 * s + 1) - 0.125 * harm(s) - 0.25 * (2.0 * s * s + s + 1.0))
  end
  
  def eps(k, s)
    return (0.5 * (s - k) * (s + k + 1.0) * harm(s + k + 1) + 0.5 * k * (k + 1) * harm(k + 1) + 0.25 * s * (2.0 * k - s - 1.0))
  end
  
  def delta(a, b, c)
    d = 0.0
    
    (a..b).each do |i|
      d += (c - i).abs.to_f / (c + i).to_f
    end
    
    return d
  end
  
  def exact_canberra(ne, k)
    sum = 0.0
    
    (1..k).each do |i|
      sum += i * (a_harm(2*k - i) - a_harm(i))
    end
    
    return (2.0 / ne * sum + (2.0 * (ne -k) / ne) * (2 * (k + 1) * (harm(2*k + 1) - harm(k + 1)) - k))
  end
  
  # from R6 in http://mpba.fbk.eu/files/publications/jurman09canberra.pdf
  def max_dist(p) # p is integer
    r = p / 4;
    q = p % 4
    maxdist = 0.0
    
    if q == 0
      maxdist = (2.0 * r * (harm(3.0 * r) - harm(r)))
    elsif q == 1
      maxdist = (2.0*r + 1.0)*harm(6.0*r + 1.0) + r*harm(3.0*r + 1.0) - (r + 0.5)*harm(3.0*r) - (2.0*r + 1.0)*harm(2.0*r +1.0) + 0.5*harm(r)
    elsif q == 2
      maxdist = (2.0*r +1.0)*(2.0*harm(6.0*r + 3.0) - harm(3.0*r + 1.0) - 2.0*harm(2.0*r + 1.0) + harm(r))
    else
      maxdist = (2.0*r + 1.0)*harm(6.0*r + 5.0) + 0.5*harm(3.0*r + 2.0) - (2.0*r + 1.0)*harm(2.0*r + 1.0) - (r + 1.0)*harm(r+1.0) + (r + 0.5)*harm(r)
    end
    
    return maxdist
  end
  
  def canberra_quotient(items1, items2, complete, normalize)
    ne = items1.length
    indicator = 0.0
    l1tmp = 0
    l2tmp = 0
    
    (1..ne).each do |i|
      if items1[i-1] > -1
        l1tmp += 1
      end
      
      if items2[i-1] > -1
        l2tmp += 1
      end      
    end
    
    if l1tmp <= l2tmp
        
    else
      
    end
    
    if normalize
      nm = average_partial_list(nl, ne, lists);
      indicator /= pnormalizer(ne, nm);
    end
    
    return indicator
  end
end
