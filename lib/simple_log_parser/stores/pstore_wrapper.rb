# frozen_string_literal: true

require 'pstore'

module SimpleLogParser
  module Stores
    class PStoreWrapper
      attr_reader :store_path

      def initialize(store_path:)
        @store = PStore.new(store_path)
        @store_path = store_path
      end

      def push(route, ip)
        store.transaction do
          store.abort unless value_present(route, ip)

          store[route] ||= {}
          store[route][ip] ||= 0
          store[route][ip] += 1
        end
      end

      def each
        iterate do |root_key|
          yield root_key, store[root_key]
        end
      end

      def to_hash
        out = {}
        iterate do |root_key|
          out[root_key] = store[root_key]
        end

        out
      end
      alias to_h to_hash

      def empty?
        to_h.empty?
      end

      private

      attr_reader :store

      def iterate(&block)
        store.transaction(true) do
          store.roots.each(&block)
        end
      rescue TypeError
        STDLogger.error('Invalid PStore file provided')
      end

      def value_present(route, ip)
        route.is_a?(String) && ip.is_a?(String) && !route.empty? && !ip.empty?
      end
    end
  end
end
