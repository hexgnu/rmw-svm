module Svm
  module Helper
    def nodes(svm_hash)
      svm_hash.map do |i,v|
        node = Java::libsvm::svm_node.new
        node.index = i
        if i > (@max_index || 0)
          @max_index = i 
        end
        node.value = v
        node
      end
    end
  end
end