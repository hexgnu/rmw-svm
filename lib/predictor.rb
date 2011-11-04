class SvmPrediction
  include Svm::Helper
  def initialize(model)
    @model = model
  end
  
  def predict(x)
    Java::libsvm::svm.svm_predict(@model, nodes(x))
  end
end


  