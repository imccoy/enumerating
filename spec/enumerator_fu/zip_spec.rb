require "spec_helper"
require "enumerator_fu/zip"

describe EnumeratorFu::Zip do

  include EnumeratorFu

  it "zips together multiple Enumerables" do
    @array1 = [1,3,6]
    @array2 = [2,4,7]
    @array3 = [5,8]
    @zip = Zip.new([@array1, @array2, @array3])
    @zip.to_a.should == [[1,2,5], [3,4,8], [6,7,nil]]
  end

  failing_enumerable = Class.new do

    include Enumerable
    
    def each
      yield 1
      yield 2
      raise "hell"
    end
    
  end
  
  it "is lazy" do
    @zip = Zip.new([%w(a b c), failing_enumerable.new])
    @zip.take(2).should == [["a", 1], ["b", 2]]
    lambda do
      @zip.take(3)
    end.should raise_error("hell")
  end

end