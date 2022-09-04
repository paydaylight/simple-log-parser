# frozen_string_literal: true

RSpec.describe SimpleLogParser::StoreManagers::PStoreManager do
  include PStoreSpec

  subject(:manager_call) { described_class.new(path: path) }

  let(:default_pstore_path) { './spec/files/pstore_manager_spec.pstore' }

  let(:path) { './spec/files/valid_log_file' }

  it_behaves_like 'not able to access', :loader
  it_behaves_like 'not able to access', :file_name
  it_behaves_like 'not able to access', :store

  describe '.call' do
    subject(:manager_call) { described_class.call(path: path, save_to: default_pstore_path) }

    context 'when everything is okay' do
      let(:valid_log_metrics) do
        {
          '/home' => { '192.168.0.1' => 1, '192.168.0.2' => 2 },
          '/about' => { '192.168.0.0' => 1, '192.168.0.2' => 1 },
          '/index' => { '192.168.0.0' => 3 },
          '/users/3' => { '192.168.0.1' => 1, '192.168.0.2' => 2, '192.168.0.3' => 1 },
          '/users/2' => { '192.168.0.0' => 1 }
        }
      end

      it('returns PStore wrapper') { is_expected.to be_a(SimpleLogParser::Stores::PStoreWrapper) }

      it('pushes log metrics to store') do
        expect(manager_call.to_h).to eq(valid_log_metrics)
      end
    end

    context 'when malformed file' do
      let(:path) { './spec/files/malformed_log_file' }
      let(:metrics_from_malformed_file) do
        {
          '/index' => { '192.168.1.1' => 1, '192.168.1.2' => 1 },
          '/home' => { '192.168.1.3' => 1 },
          '/about' => { '192.168.1.4' => 1 }
        }
      end

      it 'filters out junk' do
        expect(manager_call.to_h).to eq(metrics_from_malformed_file)
      end
    end

    context 'when empty file' do
      let(:path) { './spec/files/empty_file' }

      it 'does nothing' do
        expect(manager_call.to_h).to eq({})
      end
    end

    context 'when invalid file' do
      let(:path) { './spec/files/not_existing_file' }

      it 'raises FileNotFound' do
        expect { manager_call }.to raise_error(SimpleLogParser::DataReaders::FileNotFound)
      end
    end
  end
end
