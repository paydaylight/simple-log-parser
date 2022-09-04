# frozen_string_literal: true

require 'timecop'

RSpec.describe SimpleLogParser::CLI::Commands::Parse do
  include PStoreSpec

  before { Timecop.freeze(Time.now.utc) }
  after { Timecop.return }

  let(:default_pstore_path) { "./tmp/logs-#{Time.now.utc.to_i}.pstore" }

  describe './bin/parser parse' do
    context 'when valid file path provided' do
      let(:path) { './spec/files/malformed_log_file' }

      it('works') { expect { system %(./bin/parser parse #{path}) }.to output.to_stdout_from_any_process }
    end

    context 'when invalid path provided' do
      let(:path) { './spec/files/file_not_exists' }

      it 'outputs error' do
        expect { system %(./bin/parser parse #{path}) }
          .to output(a_string_matching('File not found'.red)).to_stdout_from_any_process
      end
    end

    context 'when file is empty' do
      let(:path) { './spec/files/file_with_blank_line' }

      it('does not output') { expect { system %(./bin/parser parse #{path}) }.to_not output.to_stdout_from_any_process }
    end
  end
end
