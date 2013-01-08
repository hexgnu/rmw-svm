require 'test/unit'
require File.join(File.dirname(__FILE__), '../lib/svm')



class SvmExampleTest < Test::Unit::TestCase
  # Problem = [
  #   [5, {:campy => 1, :year => 1987}], 
  #   [3, {:year => 1978}], 
  #   [2, {:year => 1988}]
  # ]
  
  Problem = [
    [5, {:year => 1987, :campy => true, :funny => true}], # Ghost Fever
    [3, {:year => 1978, :man_eating_monsters => true, :horror => true}], # Attack of the Killer Tomatoes
    [2, {:year => 1988, :teens => true}] #The Blob
  ]
  
  def test_years_correctedness
    predictor = SvmPrediction.from_svm_problem(Problem)
    
    assert_equal 5, predictor.predict(:campy => 1)
    assert_equal 3, predictor.predict(:man_eating_monsters => 1)
    assert_equal 2, predictor.predict(:teens => 1)
  end
end
