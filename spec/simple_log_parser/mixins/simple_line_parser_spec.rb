# frozen_string_literal: true

RSpec.describe SimpleLogParser::Mixins::SimpleLineParser do
  subject(:line_parser) { Class.new { extend SimpleLogParser::Mixins::SimpleLineParser } }

  it_behaves_like 'not able to access', :empty_result

  describe '#parse' do
    context 'when valid line' do
      let(:line) { '/index 192.168.1.1' }

      it('works') { expect(line_parser.parse(line)).to eq(['/index', '192.168.1.1']) }

      it 'checks for IPv4' do
        expect(line_parser).to receive(:ip_v4?)

        line_parser.parse(line)
      end
    end

    context 'when invalid line' do
      context 'when nil' do
        let(:line) { nil }

        it('returns empty array') { expect(line_parser.parse(line)).to eq([]) }
      end

      context 'when empty string' do
        let(:line) { '' }

        it('returns empty array') { expect(line_parser.parse(line)).to eq([]) }
      end

      context 'when invalid string' do
        let(:line) { 'some junk' }

        it('returns empty array') { expect(line_parser.parse(line)).to eq([]) }
      end
    end
  end
end
