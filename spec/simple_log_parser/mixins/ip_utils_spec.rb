# frozen_string_literal: true

RSpec.describe SimpleLogParser::Mixins::IPUtils do
  subject { Class.new { extend SimpleLogParser::Mixins::IPUtils } }

  describe '#ip_v4?' do
    context 'when IPv4' do
      let(:string) { '126.318.035.038' }

      it('is true') { expect(subject.ip_v4?(string)).to be_truthy }
    end

    context 'when broken IPv4' do
      let(:string) { '126.318.035.a38' }

      it('is false') { expect(subject.ip_v4?(string)).to be_falsey }
    end

    context 'when IPv6' do
      let(:string) { '2001:db8:3333:4444:5555:6666:7777:8888' }

      it('is false') { expect(subject.ip_v4?(string)).to be_falsey }
    end

    context 'when gibberish' do
      let(:string) { 'random string' }

      it('is false') { expect(subject.ip_v4?(string)).to be_falsey }
    end
  end
end
