# frozen_string_literal: true

require_relative './presenters'

module SimpleLogParser
  class Metrics
    NUMBER_OF_VIEWS_POS = 1

    def initialize(store:, presenter: Presenters::SimplePresenter)
      @store = store
      @presenter = presenter
    end

    def present_max_views
      sort_and_present(max_views)
    end

    def present_unique_views
      sort_and_present(unique_views)
    end

    def empty?
      store.to_h.empty?
    end

    private

    attr_reader :presenter, :store

    def max_views
      views_array = []
      store.each do |k, v|
        sum = v.sum { |_ip, views| views }

        views_array << [k, sum]
      end

      views_array
    end

    def unique_views
      views_array = []
      store.each do |k, v|
        views_array << [k, v.keys.size, 'unique views']
      end

      views_array
    end

    def sort_and_present(data)
      sorted_data = sort(data)

      presenter.present(sorted_data)
    end

    def sort(list_of_lists)
      list_of_lists.sort { |a, b| b[NUMBER_OF_VIEWS_POS] <=> a[NUMBER_OF_VIEWS_POS] }
    end
  end
end
