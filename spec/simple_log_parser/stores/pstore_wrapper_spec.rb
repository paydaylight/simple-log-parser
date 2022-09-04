# frozen_string_literal: true

RSpec.describe SimpleLogParser::Stores::PStoreWrapper do
  include PStoreSpec

  subject(:pstore_wrapper) { described_class.new(store_path: default_pstore_path) }

  let(:default_pstore_path) { './spec/files/pstore_wrapper_spec.pstore' }
  let(:direct_store_access) { PStore.new(default_pstore_path) }
  let(:route) { '/index' }
  let(:ip) { '127.0.0.1' }

  it_behaves_like 'not able to access', :store
  it_behaves_like 'able to access', :store_path

  describe '#push' do
    before { pstore_wrapper.push(route, ip) }

    it 'works' do
      expect(store_at(route)).to eq({ ip => 1 })
    end

    context 'when calling several times' do
      it 'keeps track of previous calls' do
        pstore_wrapper.push(route, ip)

        expect(store_at(route)).to eq({ ip => 2 })
      end
    end

    context 'when passing empty value' do
      context 'when route' do
        context 'when nil' do
          let(:route) { nil }

          it('does not log views') { expect(store_at(route)).to be_nil }
        end

        context 'when empty string' do
          let(:route) { '' }

          it('does not log views') { expect(store_at(route)).to be_nil }
        end
      end

      context 'when ip' do
        context 'when nil' do
          let(:ip) { nil }

          it('does not log views') { expect(store_at(route)).to be_nil }
        end

        context 'when empty' do
          let(:route) { '' }

          it('does not log views') { expect(store_at(route)).to be_nil }
        end
      end
    end

    def store_at(key)
      direct_store_access.transaction(true) { direct_store_access[key] }
    end
  end

  describe 'collection methods' do
    let(:enumerable_call_counter) { double }

    def ping_for_each_item
      pstore_wrapper.each { |_k, _v| enumerable_call_counter.ping }
    end

    context 'when data present' do
      before do
        pstore_wrapper.push('/index', '127.0.0.1')
        pstore_wrapper.push('/index', '127.0.0.1')
        pstore_wrapper.push('/help', '192.168.0.0')
      end

      let(:hash_from_store) do
        { '/index' => { '127.0.0.1' => 2 }, '/help' => { '192.168.0.0' => 1 } }
      end

      it 'works for #each' do
        expect(enumerable_call_counter).to receive(:ping).twice

        ping_for_each_item
      end

      it('works for #to_h') { expect(pstore_wrapper.to_h).to eq(hash_from_store) }

      it('has #to_h alias #to_hash') { expect(pstore_wrapper.to_h).to eq(pstore_wrapper.to_hash) }
    end

    context 'when no data present' do
      it 'does not work for #each' do
        expect(enumerable_call_counter).to receive(:ping).never

        ping_for_each_item
      end

      it('returns empty hash for #to_h') { expect(pstore_wrapper.to_h).to eq({}) }
    end
  end
end
