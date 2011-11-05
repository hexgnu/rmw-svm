require File.join(File.dirname(__FILE__), 'helper')
require File.join(File.dirname(__FILE__), 'trainer')
require File.join(File.dirname(__FILE__), 'predictor')
require 'yaml'


module Svm
  extend self
  
  def example
    data = [
      [5, {:year => 1987, :campy => 1, :horror => 1}], # Ghost Fever
      [3, {:year => 1978, :man_eating_monsters => 1, :horror => 1}], # Attack of the Killer Tomatoes
      [2, {:year => 1988, :teens => 1}] #The Blob
    ]
    svm_predictor = SvmPrediction.from_svm_problem(data)
    
    svm_predictor.predict(:year => 1988) #=> 2.0
    svm_predictor.predict(:year => 1987) #=> 5.0
    svm_predictor.predict(:year => 1985) #=> 5.0
    svm_predictor.predict(:year => 1987, :teens => 1) #=> 2.0
  end
end
