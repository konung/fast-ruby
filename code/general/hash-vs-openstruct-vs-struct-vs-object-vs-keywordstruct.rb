require "benchmark/ips"
require "ostruct"

# Struct
CarStruct = Struct.new(:color, :speed)

def struct_test
  car = CarStruct.new('red', 100)
  car.color
end


# Struct with named params
class KeywordStruct < Struct
  # See this https://stackoverflow.com/questions/5407940/named-parameters-in-ruby-structs
  def initialize(**kwargs)
    super(*members.map{|k| kwargs[k] })
  end
end

CarKeywordStruct = KeywordStruct.new(:color, :speed)

def keyword_struct_test
  car = CarKeywordStruct.new(color: 'red', speed: 100)
  car.color
end

# Hash
def hash_test
  car = {color: 'red', speed: 100}
  car[:color]
end

# Custom Object
class CarObj
  attr_accessor :color, :speed
  def initialize(color: , speed:)
  end
end

def obj_test
  car = CarObj.new(color: 'red', speed: 100)
  car.color
end

# OpenStruct
def openstruct_test
  car = OpenStruct.new(color: 'red', speed: 100)
  car.color
end


Benchmark.ips do |x|

  x.report("Struct")        { struct_test }
  x.report("Hash")          { hash_test }
  x.report("Obj")           { obj_test }
  x.report("KeywordStruct") { keyword_struct_test }
  x.report("OpenStruct")    { openstruct_test }

  x.compare!
end
