# frozen_string_literal: true

RSpec.describe NotMonads::Result::Failure do
  subject(:result) { described_class.new('foo') }

  let(:failure) { described_class.method(:new) }
  let(:success) { NotMonads::Result::Success.method(:new) }

  it { is_expected.not_to be_success }
  it { is_expected.to be_failure }

  it 'dumps to string' do
    expect(result.to_s).to eql('Failure("foo")')
  end

  it 'has custom inspection' do
    expect(result.inspect).to eql('Failure("foo")')
  end

  describe '#value!' do
    it 'raises an error' do
      expect { result.value! }.to(raise_error do |error|
        expect(error).to be_a NotMonads::Error
        expect(error.message).to match 'value! was called on Failure("foo")'
      end)
    end
  end

  describe '#value_or' do
    it 'returns passed value' do
      expect(result.value_or('baz')).to eql('baz')
    end

    it 'executes a block' do
      expect(result.value_or { 'foobar' }).to eql('foobar')
    end
  end

  describe '#==' do
    it 'matches on the wrapped value' do
      expect(result).to eq failure['foo']
      expect(result).not_to eq failure['fooo']
      expect(result).not_to eq success['foo']
    end
  end

  describe '#===' do
    it 'matches on the wrapped value' do
      expect(failure['foo']).to be === failure['foo']
      expect(failure[/\w+/]).to be === failure['foo']
      expect(failure[:bar]).not_to be === failure['foo']
      expect(failure[10..50]).to be === failure[42]
    end
  end
end
