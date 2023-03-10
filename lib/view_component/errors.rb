module ViewComponent
  module Errors
    class BaseError < StandardError
      class_attribute :number
      class_attribute :registered_error_numbers
      self.registered_error_numbers = []

      def self.error_number(integer)
        self.number = integer

        if registered_error_numbers.include?(integer)
          raise ArgumentError.new("Attempted to register two errors with ID #{integer}")
        else
          registered_error_numbers << integer
        end
      end

      def self.error_prefix
        "ViewComponent error #VC#{number} (#{name.demodulize})"
      end

      def prefixed_message(message)
        "#{self.class.error_prefix}: #{message}"
      end
    end

    class InitializerViewContextDependency < BaseError
      error_number 1

      def initialize(method_name)
        super(
          prefixed_message(
              "`##{method_name}` can't be used during initialization, as it depends " \
            "on the view context that only exists once a ViewComponent is passed to " \
            "the Rails render pipeline.\n\n" \
            "It's sometimes possible to fix this issue by moving code dependent on " \
            "`##{method_name}` to `#before_render`: https://viewcomponent.org/api.html#before_render--void."
          )
        )
      end
    end
  end
end