require File.join(File.dirname(__FILE__), 'helper')
require File.join(File.dirname(__FILE__), 'trainer')
require File.join(File.dirname(__FILE__), 'predictor')
require 'yaml'


module Svm
  extend self
  
  def example
    data = [
      [5, {:year => 1987, :campy => 1}], # Ghost Fever
      [3, {:year => 1978, :man_eating_monsters => 1, :horror => 1}], # Attack of the Killer Tomatoes
      [2, {:year => 1988, :teens => 1}] #The Blob
    ]
    predictor = SvmPrediction.from_svm_problem(data)
    
    puts predictor.predict(:year => 1988) #=> 2.0
    puts predictor.predict(:year => 1987) #=> 5.0
    puts predictor.predict(:man_eating_monsters => 1, :teens => 1) #=> 2.0
    puts predictor.predict(:teans => 1) #=> 2.0
    puts predictor.predict(:horror => 1) #=> 3.0
  end
end
