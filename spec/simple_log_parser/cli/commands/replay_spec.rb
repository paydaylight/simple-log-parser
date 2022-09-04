# frozen_string_literal: true

require 'timecop'

RSpec.describe SimpleLogParser::CLI::Commands::Replay do
  include PStoreSpec

  before { Timecop.freeze(Time.now.utc) }
  after { Timecop.return }

  let(:default_pstore_path) { "./tmp/logs-#{Time.now.utc.to_i}.pstore" }

  describe './bin/parser replay' do
    context 'when valid PStore file' do
      let(:path) { './spec/files/sample.pstore' }

      it('works') { expect { system %(./bin/parser replay #{path}) }.to output.to_stdout_from_any_process }
    end

    context 'when file does not exist' do
      let(:path) { './spec/files/file_not_exists' }

      it 'returns nothing' do
        expect { system %(./bin/parser replay #{path}) }.to_not output.to_stdout_from_any_process
      end
    end

    context 'when file is not a PStore file' do
      let(:path) { './spec/files/valid_log_file' }

      it 'returns error' do
        expect { system %(./bin/parser replay #{path}) }
          .to output(a_string_matching('Invalid PStore file provided'.red)).to_stdout_from_any_process
      end
    end
  end
end
