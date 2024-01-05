# frozen_string_literal: true

module NotMonads
  class Result
    attr_reader :success, :failure

    class Success < Result
      def initialize(value)
        super()
        @success = value
      end

      def failure?
        false
      end

      def success?
        true
      end

      def to_s
        "Success(#{success.inspect})"
      end
      alias inspect to_s

      def value!
        success
      end

      def value_or(_val = nil)
        success
      end

      def ==(other)
        other.is_a?(self.class) && value! == other.value!
      end

      def ===(other)
        other.instance_of?(self.class) && value! === other.value!
      end
    end

    class Failure < Result
      def initialize(value)
        super()
        @failure = value
      end

      def failure?
        true
      end

      def success?
        false
      end

      def to_s
        "Failure(#{failure.inspect})"
      end
      alias inspect to_s

      def value!
        raise Error, "value! was called on #{self}"
      end

      def value_or(val = nil)
        if block_given?
          yield
        else
          val
        end
      end

      def ==(other)
        other.is_a?(self.class) && failure == other.failure
      end

      def ===(other)
        other.instance_of?(self.class) && failure === other.failure
      end
    end
  end
end
