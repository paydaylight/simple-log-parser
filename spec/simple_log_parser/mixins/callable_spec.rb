# frozen_string_literal: true

RSpec.describe SimpleLogParser::Mixins::Callable do
  subject do
    Struct.new(:attr, keyword_init: keyword_init) do
      include SimpleLogParser::Mixins::Callable

      def call; end
    end
  end

  describe '.call' do
    context 'when keyword arguments' do
      let(:keyword_init) { true }

      it 'works' do
        expect(subject).to receive(:new).with(attr: 'test').and_call_original

        subject.call(attr: 'test')
      end
    end

    context 'when positional arguments' do
      let(:keyword_init) { false }

      it 'works' do
        expect(subject).to receive(:new).with('test').and_call_original

        subject.call('test')
      end
    end
  end
end
