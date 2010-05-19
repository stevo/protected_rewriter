module Selleo
  module ProtectedRewriter
    def self.included(base)
      base.send :include, InstanceMethods
    end

    module InstanceMethods
      def rewrite_params(object, *param_keys)
        main_key = ActionController::RecordIdentifier.singular_class_name(object)
        params[main_key] && param_keys.each do |k|
          object.send "#{k.to_s}=", params[main_key][k] unless params[main_key][k].nil?
        end
      end
    end
  end
end