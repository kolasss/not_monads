# frozen_string_literal: true

RSpec.describe NotMonads::Result::Success do
  subject(:result) { described_class.new('foo') }

  let(:success) { described_class.method(:new) }
  let(:failure) { NotMonads::Result::Failure.method(:new) }

  it { is_expected.to be_success }
  it { is_expected.not_to be_failure }

  it 'dumps to string' do
    expect(result.to_s).to eql('Success("foo")')
  end

  it 'has custom inspection' do
    expect(result.inspect).to eql('Success("foo")')
  end

  describe '#value!' do
    it 'unwraps the value' do
      expect(result.value!).to eql('foo')
    end
  end

  describe '#value_or' do
    it 'returns existing value' do
      expect(result.value_or('baz')).to eql(result.value!)
    end

    it 'ignores a block' do
      expect(result.value_or { 'baz' }).to eql(result.value!)
    end
  end

  describe '#==' do
    it 'matches on the wrapped value' do
      expect(result).to eq success['foo']
      expect(result).not_to eq success['fooo']
      expect(result).not_to eq failure['foo']
    end
  end

  describe '#===' do
    it 'matches on the wrapped value' do
      expect(success['foo']).to be === success['foo']
      expect(success[/\w+/]).to be === success['foo']
      expect(success[:bar]).not_to be === success['foo']
      expect(success[10..50]).to be === success[42]
    end
  end
end
