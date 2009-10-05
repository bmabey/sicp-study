
def exp_recur(b, n)
  if n == 0
    1
  elsif n.even?
    exp_recur(b, n / 2).square
  else
    b * exp_recur(b, n - 1)
  end
end

def exp_iter_slow(b, n)
  product = b
  n -= 1
  while n > 0
    product *= b
    n -= 1
  end
  product
end

def exp_iter_fast(b, n)
  product = 1
  until n == 0
    if n.even?
      n = n / 2
      b = b * b
    else
      product = b * product
      n -= 1
    end
  end
  product
end


class Fixnum

  def even?
    self % 2 == 0
  end

  def zero?
    self == 0
  end

  def odd?
    !even?
  end

  def square
    self * self
  end

end

