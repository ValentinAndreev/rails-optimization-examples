# gem install kalibera
require 'benchmark/ips'

SIZE = 100_000

def work_with_while
  a = []
  i = 0
  while i <= SIZE
    i += 1
    a << i
  end
end

def work_with_loop
  a = []
  i = 0
  loop do
    break if i == SIZE
    i += 1
    a << i
  end
end

Benchmark.ips do |x|
  # The default is :stats => :sd, which doesn't have a configurable confidence
  # confidence is 95% by default, so it can be omitted
  x.config(:stats => :bootstrap, :confidence => 99)

  x.report("while") { work_with_while }
  x.report("loop") { work_with_loop }
  x.compare!
end
