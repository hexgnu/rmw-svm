class SvmPrediction
  include Svm::Helper

  def initialize(model)
    @trained_model = model
    @mapping = model.mapping
    @min, @max = model.min, model.max
  end
  
  def predict(x)
    Java::libsvm::svm.svm_predict(@trained_model.model, nodes(x))
  end
  
  def self.from_svm_problem(problem)
    trained_model = SvmTrain.new(problem)
    new(trained_model)
  end
end
