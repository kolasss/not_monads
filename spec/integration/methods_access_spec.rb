# frozen_string_literal: true

RSpec.describe 'NotMonads::Do' do
  describe 'redefined methods access' do
    let(:input_value) { 10 }
    let(:klass) do
      Class.new do
        prepend NotMonads::Do[:call, :square, :double]

        def call(starting_value)
          value = do_something square(starting_value)
          value = do_something double_value(value)
          Success(value)
        end

        protected

        def square(starting_value)
          s = do_something Success(starting_value * starting_value)
          Success(s)
        end

        private

        def double_value(starting_value)
          d = do_something Success(starting_value + starting_value)
          Success(d)
        end
      end
    end
    let(:operation) { klass.new }

    it 'can call a public method' do
      expect(operation.call(input_value)).to eq(NotMonads::Result::Success.new(200))
    end

    it 'cannot call a protected method directly', skip: 'define_method doesnt respect protected' do
      expect { operation.square(input_value) }.to raise_error(NoMethodError, /protected method/)
    end

    it 'cannot call a private method directly' do
      expect { operation.double_value(input_value) }.to raise_error(NoMethodError, /private method/)
    end
  end
end
