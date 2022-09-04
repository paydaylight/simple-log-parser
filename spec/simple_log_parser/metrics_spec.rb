# frozen_string_literal: true

RSpec.describe SimpleLogParser::Metrics do
  subject(:metrics) { described_class.new(store: store) }

  let(:store) { { '/index' => { '127.0.0.1' => 3 }, '/about' => { '192.168.0.1' => 3, '192.168.0.0' => 1 } } }

  it_behaves_like 'not able to access', :store
  it_behaves_like 'not able to access', :presenter

  describe '#present_max_views' do
    context 'when store is not empty' do
      let(:expected_output) { "#{'/about 4'.blue}\n#{'/index 3'.blue}\n" }

      it('sorts and outputs') { expect { subject.present_max_views }.to output(expected_output).to_stdout }
    end

    context 'when store is empty' do
      let(:store) { {} }

      it('does not output') { expect { subject.present_max_views }.to_not output.to_stdout }
    end
  end

  describe '#present_unique_views' do
    context 'when store is not empty' do
      let(:expected_output) { "#{'/about 2 unique views'.blue}\n#{'/index 1 unique views'.blue}\n" }

      it('sorts and outputs') { expect { subject.present_unique_views }.to output(expected_output).to_stdout }
    end

    context 'when store is empty' do
      let(:store) { {} }

      it('does not output') { expect { subject.present_unique_views }.to_not output.to_stdout }
    end
  end
end
