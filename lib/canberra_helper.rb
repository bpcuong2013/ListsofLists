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
    
    return (2.0 / ne * sum + (2.0 * (ne - k) / ne) * (2 * (k + 1) * (harm(2 * k + 1) - harm(k + 1)) - k))
  end
  
  # from R6 in http://mpba.fbk.eu/files/publications/jurman09canberra.pdf
  def max_dist(p) # p is integer
    r = p.to_f / 4;
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
  
  def average_partial_list(ne, items1, items2)
    tmp1 = 0.0
    tmp2 = 0.0
    
    (0..(ne-1)).each do |i|
      if items1[i] > -1
        tmp1 += 1.0
      end
      
      if items2[i] > -1
        tmp2 += 1.0
      end
    end
    
    return (tmp1 + tmp2) / 2.0
  end
  
  def pnormalizer(ne, nm)
    #puts "ne = " + ne.to_s + ", nm = " + nm.to_s
    nm1 = exact_canberra(nm, nm);
    #puts "exact_canberra(nm, nm) = " + nm1.to_s
    ne1 = exact_canberra(ne, ne)
    #puts "exact_canberra(ne, ne) = " + ne1.to_s
    return (1.0 - nm1 / ne1)
  end
  
  def canberra_quotient(items1, items2, complete, normalize)
    ne = items1.length
    l1tmp = 0
    l2tmp = 0
    
    (0..(ne-1)).each do |i|
      if items1[i] > -1
        l1tmp += 1
      end
      
      if items2[i] > -1
        l2tmp += 1
      end      
    end
    
    #puts "l1tmp = " + l1tmp.to_s
    #puts "l2tmp = " + l2tmp.to_s
    
    list1 = []
    list2 = []
    l1 = 0
    l2 = 0
    
    if l1tmp <= l2tmp
      list1 = items1
      list2 = items2
      l1 = l1tmp
      l2 = l2tmp
    else
      list1 = items2
      list2 = items1
      l1 = l2tmp
      l2 = l1tmp
    end
    
    common = 0
    unused = 0
    intersection = []
    
    (0..(ne-1)).each do |i|
      if list1[i] > -1 && list2[i] > -1
        common += 1
        intersection.push i
      end
      
      if list1[i] == -1 && list2[i] == -1
        unused += 1
      end
    end
    
    distance = 0.0
    tmp2 = 0.0
    tmp3 = 0.0
    
    (0..(common-1)).each do |i|
      ii = intersection[i]
      t1 = list1[ii] + 1
      t2 = list2[ii] + 1
      #puts "i = " + i.to_s + ", t1 = " + t1.to_s + ", t2 = " + t2.to_s
      distance += (t1 - t2).to_f.abs / (t1.abs + t2.abs)
      #puts "distance = " + distance.to_s
      tmp2 += delta(l2 + 1, ne, t1)
      tmp3 += delta(l1 + 1, ne, t2)
    end
    
    #puts "ne = " + ne.to_s + ", l1 = " + l1.to_s + ", l2 = " + l2.to_s
    #puts "tmp2 = " + tmp2.to_s
    #puts "tmp3 = " + tmp3.to_s
    #puts "distance = " + distance.to_s
    
    if l2 != ne
      distance += 1.0 / (ne - l2) * (-tmp2 + l1 * (ne - l2) - 2.0 * eps(ne, l1) + 2.0 * eps(l2, l1))
      #puts "distance.l2 = " + distance.to_s
    end
    
    if l1 != ne
      op1 = -tmp3 + (ne - l1) * l1 - 2.0 * eps(ne, l1) + 2.0 * eps(l1, l1)
      #puts "op1 = " + op1.to_s
      op2 = 2.0 * (xi(l2) - xi(l1))
      #puts "op2 = " + op2.to_s
      op3 = 2.0 * (eps(l1, l2) - eps(l1, l1) + eps(ne, l2) - eps(ne, l1))
      #puts "op3 = " + op3.to_s
      op4 = (ne + l1) * (l2 - l1) + l1 * (l1 + 1.0) - l2 * (l2 + 1.0)
      #puts "op4 = " + op4.to_s
      op = op1 + op2 - op3 + op4
      
      #if op == 0.0
      #  distance += 1.0 / (ne - l1)
      #else
      #  distance += 1.0 / (ne - l1) * (op1 + op2 - op3 + op4)
      #end
      distance += 1.0 / (ne - l1) * (op1 + op2 - op3 + op4)
      
      #puts "distance.l1 = " + distance.to_s
    end
    
    if ne != l1 && ne != l2 && complete == true
      mya = (1.0 * unused) / ((ne - l1) * (ne - l2))
      
      distance += mya * (2.0 * xi(ne) - 2.0 * xi(l2) - 
                         2.0 * eps(l1, ne) + 2.0 * eps(l1, l2) -
                         2.0 * eps(ne, ne) + 2.0 * eps(ne, l2) +
                         (ne + l1) * (ne - l2) + l2 * (l2 + 1.0) - ne * (ne + 1.0))
    end
    
    if normalize
      nm = average_partial_list(ne, list1, list2);
      #puts "nm = " + nm.to_s
      #puts "distance = " + distance.to_s
      if nm.to_i < ne
        pn = pnormalizer(ne, nm.to_i)
        #puts "pn = " + pn.to_s
        distance /= pn
        #puts "distance1 = " + distance.to_s
      end
    end
    
    return distance
  end
  
  def canberra_location(items1, items2, k)
    distance = 0.0
    ne = items1.length
    
    if k > ne || k <= 0
      return nil
    end
    
    k1 = k + 1
    (0..(ne-1)).each do |i|
      l1 = (items1[i] + 1 <= k1) ? items1[i] + 1 : k1
      l2 = (items2[i] + 1 <= k1) ? items2[i] + 1 : k1
      distance += (l1 - l2).to_f.abs / (l1 + l2)
    end
    
    return distance
  end
end
