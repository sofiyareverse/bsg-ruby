require 'time'
require_relative 'base'

module BSG
  class VIBER < BSG::Base
    attr_accessor :to, :msisdn, :reference, :text, :alpha_name, :is_promotional,
                  :options, :viber, :img, :caption, :action,
                  :result, :currency, :total_price,
                  :error, :errorDescription

    def createdDatetime=(value)
      @createdDatetime = value_to_time(value)
    end

    def statusDatetime=(value)
      @statusDatetime = value_to_time(value)
    end
  end
end
