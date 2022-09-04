# frozen_string_literal: true

RSpec.shared_examples 'not able to access' do |method|
  it { expect { subject.public_send(method) }.to raise_error(NoMethodError) }
end
