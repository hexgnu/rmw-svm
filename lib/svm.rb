require 'helper'
require 'trainer'
require 'predictor'

__FILE__
problem = [[5, {1 => 1, 2 => 1}], [3, {3 => 1, 4 => 1}], [2, {5 => 1, 6 => 1}]]
svm_model = SvmTrain.new(problem)
svm_predictor = SvmPrediction.new(svm_model.model)
