# frozen_string_literal: true

module PStoreSpec
  def self.included(base)
    base.class_eval do
      let(:default_pstore_path) { './spec/files/tmp_store.pstore' }

      before { PStore.new(default_pstore_path) }

      after { File.delete(default_pstore_path) if File.exist?(default_pstore_path) }
    end
  end
end
