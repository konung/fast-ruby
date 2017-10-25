require "benchmark/ips"


def factorial_recursion(n)
  return 1 if (0..1).include?(n)
  n * factorial_recursion(n - 1)
end

def factorial_loop(n)
  factorial = 1

  begin
    factorial *= n
    n = n - 1
  end while n > 1

  factorial
end

Benchmark.ips do |x|
  x.report("loop")      { factorial_loop(100) }
  x.report("recursion") { factorial_recursion(100) }

  x.compare!
end
