# frozen_string_literal: true

RSpec.describe 'Basic' do
  subject(:call) { klass.new.call(input_value) }

  let(:input_value) { 10 }
  let(:klass) do
    Class.new do
      prepend NotMonads::Do[:call]

      def call(starting_value)
        value = do_something square(starting_value)
        value = do_something double_value(value)
        Success(value)
      end

      private

      def square(starting_value)
        s = starting_value * starting_value
        Success(s)
      end

      def double_value(starting_value)
        d = starting_value + starting_value
        Success(d)
      end
    end
  end

  it 'returns right value' do
    expect(call).to eq(NotMonads::Result::Success.new(200))
  end
end
