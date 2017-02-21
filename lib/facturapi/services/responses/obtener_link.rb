module Facturapi
  module Services
    module Responses
      class ObtenerLink
        attr_reader :response

        def initialize(response)
          @response = Nokogiri::XML(response)
        end

        def url
          Base64.strict_decode64 response.css('WSPLANO>Mensaje').text
        end
      end
    end
  end
end
