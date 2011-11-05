require 'test/unit'
require '../lib/svm'



class SvmExampleTest < Test::Unit::TestCase
  # Problem = [
  #   [5, {:campy => 1, :year => 1987}], 
  #   [3, {:year => 1978}], 
  #   [2, {:year => 1988}]
  # ]
  
  Problem = [
    [5, {:year => 1987, :campy => 1}], # Ghost Fever
    [3, {:year => 1978, :man_eating_monsters => 1, :horror => 1}], # Attack of the Killer Tomatoes
    [2, {:year => 1988, :teens => 1}] #The Blob
  ]
  
  def test_years_correctedness
    predictor = SvmPrediction.from_svm_problem(Problem)
    (1978..1982).each do |yr|
      puts yr
      assert_equal 3.0, predictor.predict(:year =>  yr)
    end
    
    (1983..1987).each do |yr|
      assert_equal 5.0, predictor.predict(:year =>  yr)
    end
    
    (1988..2000).each do |yr|
      assert_equal 2.0, predictor.predict(:year =>  yr)
    end
  end
end
