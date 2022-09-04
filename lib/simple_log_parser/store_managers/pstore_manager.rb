# frozen_string_literal: true

require_relative '../mixins/ip_utils'
require_relative '../mixins/callable'
require_relative '../mixins/simple_line_parser'
require_relative '../data_readers'
require_relative '../stores/pstore_wrapper'

module SimpleLogParser
  module StoreManagers
    class PStoreManager
      include Mixins::IPUtils
      include Mixins::Callable
      include Mixins::SimpleLineParser

      STORE_EXT = 'pstore'

      def initialize(path:, loader: DataReaders::FileReader, save_to: nil)
        @loader = loader.new(path: path)
        @file_name = save_to || "#{TMP_PATH}/#{new_pstore_file_name}"
        @store = Stores::PStoreWrapper.new(store_path: file_name)
      end

      def call
        loader.read do |buffer|
          route, ip = parse(buffer)

          store.push(route, ip)
        end

        store
      end

      private

      attr_reader :loader, :file_name, :store

      def utc_epoch_now
        Time.now.utc.to_i
      end

      def new_pstore_file_name
        "logs-#{utc_epoch_now}.#{STORE_EXT}"
      end
    end
  end
end
