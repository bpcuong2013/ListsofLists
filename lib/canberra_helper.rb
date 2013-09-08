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
  
  def canberra_quotient()
    
  end
end