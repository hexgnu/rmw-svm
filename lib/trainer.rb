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
    
    x = []
    y = []
    
    data.each do |row|
      x << nodes(row[1])
      y << row.first
    end
    
    @problem.x = x
    @problem.y = y
    
    if param.gamma == 0 && @max_index > 0
      param.gamma = 1.0 / @max_index
    end
    
    puts @max_index
    
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
    vals = data.map do |row| 
      row[1].values.map do |val|
        coerce(val)
      end
    end
  
    @min, @max = vals.flatten.minmax
  end
end