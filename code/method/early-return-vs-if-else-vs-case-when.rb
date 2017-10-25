require "benchmark/ips"

NUMS = ([1,2,3]*1000).shuffle

def early_return(x)
  return 'one' if x == 1
  return 'two' if x == 2
  return 'three'
end

def if_esle(x)
  if x == 1
    'one'
  elsif x == 2
    'two'
  else
    'three'
  end
end

def case_when(x)
  case x
  when 1
    'one'
  when 2
    'two'
  else
    'three'
  end
end


Benchmark.ips do |x|
  x.report("early return")  { NUMS.each{|n| early_return(n)} }
  x.report("if-else")       { NUMS.each{|n| if_esle(n)} }
  x.report("case_when")     { NUMS.each{|n| case_when(n)} }

  x.compare!
end
