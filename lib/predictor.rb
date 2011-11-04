require 'java'
require 'libsvm.jar'


class SvmPrediction
  include Svm::Helper
  def initialize(model)
    @model = model
  end
  
  def predict(x)
    puts x.inspect
    Java::libsvm::svm.svm_predict(@model, nodes(x))
  end
end


  