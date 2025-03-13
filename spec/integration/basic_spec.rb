# frozen_string_literal: true

RSpec.describe 'Basic' do
  subject(:call) { klass.new.call(input_value) }

  let(:input_value) { 10 }
  let(:klass) do
    Class.new do
      prepend NotMonads::Do[:call]

      def call(starting_value)
        doit validate(starting_value)
        value = doit square(starting_value)
        value = doit double_value(value)
        Success(value)
      end

      private

      def validate(starting_value)
        return Success(starting_value) if starting_value.is_a?(Integer)

        Failure('not an integer')
      end

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

  context 'when input is not an integer' do
    let(:input_value) { 'foo' }

    it 'returns failure' do
      expect(call).to eq(NotMonads::Result::Failure.new('not an integer'))
    end
  end
end
