# frozen_string_literal: true

require_relative 'result'

module NotMonads
  module Do
    module MixinInstance
      # rubocop:disable Naming/MethodName
      def Success(value = nil)
        NotMonads::Result::Success.new(value)
      end

      def Failure(value = nil)
        NotMonads::Result::Failure.new(value)
      end
      # rubocop:enable Naming/MethodName

      def doit(result)
        return result.value! if result.success?

        halt(result)
      end

      def halt(result)
        raise Halt, result
      end
    end

    class Halt < StandardError
      attr_reader :result

      def initialize(result)
        super()
        @result = result
      end
    end

    class << self
      def [](*methods)
        Module.new do
          methods.each do |method|
            define_method(method) do |*args, **kwargs, &block|
              super(*args, **kwargs, &block)
            rescue Halt => e
              e.result
            end
          end

          include MixinInstance
        end
      end
    end
  end
end
