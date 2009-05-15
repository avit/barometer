require 'spec_helper'

describe "Forecast Measurement" do
  
  describe "when initialized" do
    
    before(:each) do
      @forecast = Measurement::Forecast.new
    end
    
    it "responds to date" do
      @forecast.date.should be_nil
    end

    it "responds to low" do
      @forecast.low.should be_nil
    end
    
    it "responds to high" do
      @forecast.high.should be_nil
    end
    
    it "responds to pop" do
      @forecast.pop.should be_nil
    end
    
    it "responds to night" do
      @forecast.night.should be_nil
    end
    
  end
  
  describe "when writing data" do
    
    before(:each) do
      @forecast = Measurement::Forecast.new
    end
    
    it "only accepts Date for date" do
      invalid_data = 1
      invalid_data.class.should_not == Date
      lambda { @forecast.date = invalid_data }.should raise_error(ArgumentError)
      
      valid_data = Date.new
      valid_data.class.should == Date
      lambda { @forecast.date = valid_data }.should_not raise_error(ArgumentError)
    end
    
    it "only accepts Data::Temperature for high" do
      invalid_data = 1
      invalid_data.class.should_not == Data::Temperature
      lambda { @forecast.high = invalid_data }.should raise_error(ArgumentError)
      
      valid_data = Data::Temperature.new
      valid_data.class.should == Data::Temperature
      lambda { @forecast.high = valid_data }.should_not raise_error(ArgumentError)
    end
    
    it "only accepts Data::Temperature for low" do
      invalid_data = 1
      invalid_data.class.should_not == Data::Temperature
      lambda { @forecast.low = invalid_data }.should raise_error(ArgumentError)
      
      valid_data = Data::Temperature.new
      valid_data.class.should == Data::Temperature
      lambda { @forecast.low = valid_data }.should_not raise_error(ArgumentError)
    end
    
    it "only accepts Fixnum for pop" do
      invalid_data = "test"
      invalid_data.class.should_not == Fixnum
      lambda { @forecast.pop = invalid_data }.should raise_error(ArgumentError)
      
      valid_data = 50
      valid_data.class.should == Fixnum
      lambda { @forecast.pop = valid_data }.should_not raise_error(ArgumentError)
    end
    
    it "only accepts Measurement::ForecastNight for night" do
      invalid_data = 1
      invalid_data.class.should_not == Measurement::ForecastNight
      lambda { @forecast.night = invalid_data }.should raise_error(ArgumentError)
      
      valid_data = Measurement::ForecastNight.new
      valid_data.class.should == Measurement::ForecastNight
      lambda { @forecast.night = valid_data }.should_not raise_error(ArgumentError)
    end
    
  end
  
  describe "answer simple questions, like" do
    
    before(:each) do
      @forecast = Measurement::Forecast.new
    end
    
    describe "wet?" do
      
      describe "wet_by_pop?" do
        
        it "requires real threshold number (or nil)" do
          lambda { @forecast.send("_wet_by_pop?","invalid") }.should raise_error(ArgumentError)
          lambda { @forecast.send("_wet_by_pop?") }.should_not raise_error(ArgumentError)
          lambda { @forecast.send("_wet_by_pop?",50) }.should_not raise_error(ArgumentError)
        end

        it "returns nil when no pop" do
          @forecast.pop?.should be_false
          @forecast.send("_wet_by_pop?",50).should be_nil
          @forecast.wet?.should be_nil
          @forecast.pop = 60
          @forecast.pop?.should be_true
          @forecast.send("_wet_by_pop?",50).should_not be_nil
          @forecast.wet?.should_not be_nil
        end

        it "return true when current pop over threshold" do
          @forecast.pop = 60
          @forecast.send("_wet_by_pop?",50).should be_true
          @forecast.wet?.should be_true
        end

        it "return false when current pop under threshold" do
          @forecast.pop = 40
          @forecast.send("_wet_by_pop?",50).should be_false
          @forecast.wet?.should be_false
        end

      end
      
    end
    
  end
  
end