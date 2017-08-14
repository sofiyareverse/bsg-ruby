require 'json'
require 'uri'
require 'rest-client'
require_relative 'response/hlr'
require_relative 'response/message'
require_relative 'response/im-viber'
require_relative 'response/balance'

module BSG
  ENDPOINT = 'http://api.bsg.hk'

  class Client
      attr_reader :access_key

      def initialize(access_key = nil)
        @access_key = access_key || ENV['BSG_ACCESS_KEY']
      end

      def request(method, path, params={})
        url = URI.join(ENDPOINT, '/v1.0/', path).to_s

        # Set up the HTTP object.
        headers = {:content_type => 'application/json', 'X-API-KEY' => "#{@access_key}"}
        playload = params.to_json if method == :post && !params.empty?

        # Construct the HTTP GET or POST request.
        response = RestClient.get(url, headers)  if method == :get
        response = RestClient.post(url, "#{playload}", headers) if method == :post

        # Parse the HTTP response.
        case response.code.to_i
        when 200, 201, 204, 401, 404, 405, 422
          json = JSON.parse(response.body.to_s)
        else
          raise Net::HTTPServerError.new response.http_version, 'Unknown response from server', response
        end

        json
      end

      # =============================
      #         BSG HLR API
      # =============================

      # Retrieve the information of specific HLR.
      def hlr(id)
        HLR.new(request(:get, "hlr/#{id.to_s}"))
      end

      # Retrieve the information of specific HLR by Reference.
      def hlr_reference(reference)
        HLR.new(request(:get, "hlr/reference/#{reference.to_s}"))
      end

      # Create a new HLR.
      def hlr_create(params={})
          HLR.new(request(
            :post,
            "hlr/create/",
            if params.kind_of? Array
              params
            else
              [] << params.merge({})
            end
          ))

      end

      # Retrieve the prices of specific HLR tariff.
      def hlr_prices(tariff=nil)
        HLR.new(request(:get, "hlr/prices/#{tariff.nil? ? '' : tariff.to_s}"))
      end


      # =============================
      #         BSG SMS API
      # =============================

      # Retrieve the prices of specific SMS tariff.
      def message_prices(tariff=nil)
        MESSAGE.new(request(:get, "sms/prices/#{tariff.nil? ? '' : tariff.to_s}"))
      end
      # Retrieve the information of specific SMS.
      def message(id)
        MESSAGE.new(request(:get, "sms/#{id.to_s}"))
      end
      def message_reference(reference)
        MESSAGE.new(request(:get, "sms/reference/#{reference.to_s}"))
      end
      # Retrieve the information of specific SMS task.
      def message_task(task_id)
        MESSAGE.new(request(:get, "sms/task/#{task_id.to_s}"))
      end
      # Create a new SMS.
      def message_create(params={})
        MESSAGE.new(request(:post, "sms/create/", params.merge({})))
      end

      # =============================
      #         BSG IM VIBER API
      # =============================

      # Retrieve the prices of specific Viber message tariff.
      def viber_prices(tariff=nil)
        VIBER.new(request(:get, "viber/prices/#{tariff.nil? ? '' : tariff.to_s}"))
      end
      # Retrieve the information of specific Viber message.
      def viber(id)
        VIBER.new(request(:get, "viber/#{id.to_s}"))
      end
       # Retrieve the information of specific Viber message.
      def viber_reference(reference)
        VIBER.new(request(:get, "viber/reference/#{reference.to_s}"))
      end
      # Retrieve the information of specific Viber message task.
      def viber_task(task_id)
        VIBER.new(request(:get, "viber/task/#{task_id.to_s}"))
      end
      # Create a new Viber message.
      def viber_create(params={})
        VIBER.new(request(:post, "viber/create/", params.merge({})))
      end

      # =============================
      #         BSG BALANCE API
      # =============================

      # Retrieve balance amount
      def balance()
        BALANCE.new(request(:get, "common/balance"))
      end

  end
end
