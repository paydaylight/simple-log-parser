# frozen_string_literal: true

RSpec.describe SimpleLogParser::Metrics do
  subject(:metrics) { described_class.new(store: store) }

  let(:store) { { '/index' => { '127.0.0.1' => 3 }, '/about' => { '192.168.0.1' => 3, '192.168.0.0' => 1 } } }

  it_behaves_like 'not able to access', :store
  it_behaves_like 'not able to access', :presenter

  describe '#present_max_views' do
    context 'when store is not empty' do
      it 'sorts and outputs' do
        expect { subject.present_max_views }.to output(blue('/about 4') + blue('/index 3')).to_stdout
      end
    end

    context 'when store is empty' do
      let(:store) { {} }

      it('does not output') { expect { subject.present_max_views }.to_not output.to_stdout }
    end
  end

  describe '#present_unique_views' do
    context 'when store is not empty' do
      it 'sorts and outputs' do
        expect { subject.present_unique_views }
          .to output(blue('/about 2 unique views') + blue('/index 1 unique views')).to_stdout
      end
    end

    context 'when store is empty' do
      let(:store) { {} }

      it('does not output') { expect { subject.present_unique_views }.to_not output.to_stdout }
    end
  end

  def blue(text)
    "#{text.blue}\n"
  end
end
