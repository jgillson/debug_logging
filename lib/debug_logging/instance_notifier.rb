# frozen_string_literal: true

module DebugLogging
  class InstanceNotifier < Module
    def initialize(i_methods: nil)
      super()
      @instance_methods_to_notify = Array(i_methods) if i_methods
    end

    def included(base)
      return unless @instance_methods_to_notify

      base.send(:include, ArgumentPrinter)
      instance_method_notifier = DebugLogging::InstanceNotifierModulizer.to_mod(methods_to_notify: @instance_methods_to_notify)
      base.send(:prepend, instance_method_notifier)
    end
  end
end
