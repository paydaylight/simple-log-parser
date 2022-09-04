# frozen_string_literal: true

require_relative './data_readers/file_reader'

module SimpleLogParser
  module DataReaders
    class FileNotFound < Errno::ENOENT; end
  end
end
