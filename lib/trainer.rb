require 'java'
require File.join(File.dirname(__FILE__), 'libsvm.jar')

class SvmTrain
  include Svm::Helper
  attr_reader :model, :mapping, :min, :max
  def initialize(data)
    @min, @max = scale(data)
    @max_index = 0
    @mapping = {}
    
    @problem = Java::libsvm::svm_problem.new
    @problem.l = data.length
    
    @problem.x = Array.new(@problem.l)
    @problem.y = Array.new(@problem.l)
    
    data.each_with_index do |row,index|
      @problem.x[index] = nodes(row[1])
      @problem.y[index] = row.first
    end
    
    if param.gamma == 0 && @max_index > 0
      param.gamma = 1.0 / @max_index
    end
    
    @model = Java::libsvm::svm.svm_train(@problem, param)
  end
  
  def param
    if @param.nil?
      @param = Java::libsvm::svm_parameter.new
      yml = YAML::load(File.open(File.join(File.dirname(__FILE__), '../config/defaults.yml')))
      yml.each do |config_param, value|
        @param.send("#{config_param}=", value)
      end
    end
    @param
  end
  
  def scale(data)
    @min, @max = data.map {|row| row[1].values }.flatten.minmax
  end
end