# frozen_string_literal: true

RSpec.shared_examples 'able to access' do |method|
  it { expect { subject.public_send(method) }.to_not raise_error }
end
