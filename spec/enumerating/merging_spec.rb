require "spec_helper"

describe Enumerating, :needs_enumerators => true do

  describe ".merging" do

    it "merges multiple Enumerators" do
      @array1 = [1,3,6]
      @array2 = [2,4,7]
      @array3 = [5,8]
      @merge = Enumerating.merging(@array1, @array2, @array3)
      @merge.to_a.should == [1,2,3,4,5,6,7,8]
    end

    it "is lazy" do
      @enum1 = [1,3]
      @enum2 = [2,4].with_time_bomb
      @merge = Enumerating.merging(@enum1, @enum2)
      @merge.take(4).should == [1,2,3,4]
    end

  end

  describe ".merging_by" do

    it "uses the block to determine order" do
      @array1 = %w(cccc dd a)
      @array2 = %w(eeeee bbb)
      @merge = Enumerating.merging_by(@array1, @array2) { |s| -s.length }
      @merge.to_a.should == %w(eeeee cccc bbb dd a)
    end

  end

end