module Svm
  module Helper
    def update_mapping!(hash)
      @mapping = {} if @mapping.nil?
      hash.keys.each do |k|
        if !@mapping.has_key?(k)
          max = @mapping.values.max || 0
          @mapping[k] = max + 1
        end
      end
    end
    
    def nodes(svm_hash)
      update_mapping!(svm_hash)
      
      svm_hash.map do |i,v|
        node = Java::libsvm::svm_node.new
        node.index = @mapping[i]
        if @mapping[i] > (@max_index || 0)
          @max_index = @mapping[i] 
        end
        node.value = v
        node
      end
    end
  end
end