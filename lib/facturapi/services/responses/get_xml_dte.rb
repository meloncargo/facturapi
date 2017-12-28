module Facturapi
  module Services
    module Responses
      class GetXmlDte
        attr_reader :response

        def initialize(response = nil)
          @response = Nokogiri::XML(response)
        end
      end
    end
  end
end
