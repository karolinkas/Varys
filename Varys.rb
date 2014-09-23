require "timecop"
require 'date'

class Varys
  # Say the name of the character
  def say_my_name!
    "I am Varys, and I'm here to say what you want to hear."
  end

  # Flatter Cersei
  def say_cersei_rocks!
    "Cersei rocks!"
  end

  # Flatter Joffrey
  def say_joffrey_rocks!
    "Joffrey rocks!"
  end

  # Upon receiving a list of words, reverse them and return only the ones
  # which have five letters or more
  def backwards_wording(arg)
    resp = []
    size = arg.size
    i = 0

    while i < size do
      elem = arg[i]

      if elem.length >= 5
        revelem = elem.split(//).reverse.join('')
        resp << revelem
      end

      i+=1

    end

    return resp

  end

  # Upon receiving a list of float numbers, return a portion of them. If it is
  # Friday, return the ones that are below 0. Otherwise, return the ones above
  # or equal 0.
  def friday_numbers(arg)
    resp = []; i = 0; s = arg.size;

    while i < s do
      e = arg[i]

      if (Time.now.friday? && e < 0) || (!Time.now.friday? && e >= 0)
        resp << e
      end

      if true
        i+= 1
      end
     end

    return resp
  end 
end


describe Varys do
  before do
    @varys = Varys.new
  end

  describe :backwards_wording do
    it "should check if the string is greater than 5 characters" do
      expect(@varys.backwards_wording(["Helllo"])).to eql(["ollleH"])
    end

    it "should not reverse word if it`s smaller then 5" do
      expect(@varys.backwards_wording(["Hey"])).not_to eql(["yeH"])
    end

    it "should return numbers above 0" do
      expect(@varys.friday_numbers([2.4,-1,1.3,0])).to eql([2.4,1.3,0])
    end

    context "if its friday" do 
      before do
        Timecop.freeze(Date.today + 3) 
      end

      after do
        Timecop.return
      end

      it "should return negative numbers if it s friday" do
        expect(@varys.friday_numbers([2.4,-1,1.3,0])).to eql([-1])
      end
    end

  end
end
