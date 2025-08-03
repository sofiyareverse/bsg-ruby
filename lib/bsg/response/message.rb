require 'time'
require_relative 'base'

module BSG
  class MESSAGE < BSG::Base
    attr_accessor :task_id, :total_price, :result, :currency, :reference, :id, :price,
                  :error, :errorDescription

    def createdDatetime=(value)
      @createdDatetime = value_to_time(value)
    end

    def statusDatetime=(value)
      @statusDatetime = value_to_time(value)
    end
  end
end
