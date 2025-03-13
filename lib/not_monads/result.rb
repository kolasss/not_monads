# frozen_string_literal: true

module NotMonads
  class Result
    def initialize(value)
      @value = value
    end

    class Success < Result
      def failure?
        false
      end

      def success?
        true
      end

      def to_s
        "Success(#{value!.inspect})"
      end
      alias inspect to_s

      def value!
        @value
      end

      def value_or(_val = nil)
        @value
      end

      def ==(other)
        other.is_a?(self.class) && value! == other.value!
      end

      def ===(other)
        other.instance_of?(self.class) && value! === other.value!
      end
    end

    class Failure < Result
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

      def failure
        @value
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
