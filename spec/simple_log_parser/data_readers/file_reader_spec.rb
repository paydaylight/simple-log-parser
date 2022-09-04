# frozen_string_literal: true

RSpec.describe SimpleLogParser::DataReaders::FileReader do
  subject { described_class.new(path: path) }

  let(:path) { './spec/files/empty_file' }

  it_behaves_like 'not able to access', :path

  describe '#read' do
    context 'when valid file path' do
      it('does not raise') { expect(subject.read).to be_nil }

      context 'when file has content' do
        let(:path) { './spec/files/file_with_blank_line' }

        context 'when block was passed' do
          let(:block_call_counter) { double('call') }

          before { expect(block_call_counter).to receive(:ping).once }

          it('works') { subject.read { |_line| block_call_counter.ping } }
        end

        context 'when block was not passed' do
          it('raises') { expect { subject.read }.to raise_error(LocalJumpError) }
        end
      end
    end

    context 'when invalid file path' do
      let(:path) { './spec/files/does_not_exist' }

      it('raises an error') { expect { subject.read }.to raise_error(SimpleLogParser::DataReaders::FileNotFound) }
    end
  end

  describe 'accessing attributes' do
    context 'when private' do
      it('raises') { expect { subject.path }.to raise_error(NoMethodError) }
    end
  end
end
