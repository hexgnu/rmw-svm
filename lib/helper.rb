module Svm
  module Helper
    def update_mapping!(hash)
      if @mapping.nil?
        @mapping = {} 
      end
      
      hash.keys.each do |k|
        if !@mapping.has_key?(k)
          max = @mapping.values.max || 0
          @mapping[k] = max + 1
        end
      end
    end
    
    def nodes(svm_hash)
      update_mapping!(svm_hash)
      m = (2.0 / (@max - @min))
      b = 1 - (2.0 * @max) / (@max - @min)
      svm_hash.map do |i,v|
        node = Java::libsvm::svm_node.new
        value = coerce(v)
        
        
        node.index = @mapping[i]
        if @mapping[i] > (@max_index || 0)
          @max_index = @mapping[i] 
        end

        node.value = m * value + b
        node
      end
    end
    
    def coerce(value)
      if value.is_a?(TrueClass)
        1
      elsif value.is_a?(FalseClass)
        0
      else
        value
      end
    end
  end
end