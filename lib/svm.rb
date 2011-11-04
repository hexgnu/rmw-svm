require File.join(File.dirname(__FILE__), 'helper')
require File.join(File.dirname(__FILE__), 'trainer')
require File.join(File.dirname(__FILE__), 'predictor')
require 'yaml'

__END__
problem = [
  [5, {:campy => 1, :year => 1987}], 
  [3, {:mem => 1, :year => 1978}], 
  [2, {:teens => 1, :year => 1988}]
]
svm_model = SvmTrain.new(problem)
svm_predictor = SvmPrediction.new(svm_model.model)


(1978..1990).each do |yr|
  puts [yr, svm_predictor.predict(:year => yr)].join(" >> ")
end
