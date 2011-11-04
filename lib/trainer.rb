require 'java'
require 'tempfile'
require 'libsvm.jar'

class SvmTrain
  include Svm::Helper
  attr_reader :model
  def initialize(problem)
    @max_index = 0
    @problem = Java::libsvm::svm_problem.new
    @problem.l = problem.length
    @problem.x = Array.new(@problem.l)
    @problem.y = Array.new(@problem.l)
    problem.each_with_index do |row,index|
      @problem.x[index] = nodes(row[1])
      @problem.y[index] = row.first
    end
    if param.gamma == 0 && @max_index > 0
      param.gamma = 1.0 / @max_index
    end
    @model = Java::libsvm::svm.svm_train(@problem, param)
  end
  
  def save
    @tempfile = Tempfile.new("model")
    Java::libsvm::svm.svm_save_model(@tempfile.path, @model)
    @tempfile.path
  end
  
  def param
    if @param.nil?
      @param = Java::libsvm::svm_parameter.new
      @param.svm_type = Java::libsvm::svm_parameter::C_SVC
      @param.kernel_type = Java::libsvm::svm_parameter::RBF
      @param.degree = 3
      @param.gamma = 0
      @param.coef0 = 0
      @param.nu = 0.5
      @param.cache_size = 100
      @param.C = 1
      @param.eps = 1e-13
      @param.p = 0.1
      @param.shrinking = 1
      @param.probability = 0
      @param.nr_weight = 0
      @param.weight_label = []
      @param.weight = []
    end
    @param
  end
end

# problem = [[5, {1 => 1, 2 => 1}], [3, {3 => 1, 4 => 1}], [2, {5 => 1, 6 => 1}]]
#