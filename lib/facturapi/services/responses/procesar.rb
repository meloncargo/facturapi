module Facturapi
  module Services
    module Responses
      class Procesar
        attr_reader :response
        def initialize(response)
          @response = Nokogiri::XML(response)
        end

        def valid?
          response.css('WSPLANO>Resultado').text == 'True'
        end

        def error
          response.css('Documento>Error').text
        end

        def folio
          response.css('Documento>Folio').text.to_i
        end

        def tipo_dte
          response.css('Documento>TipoDte').text.to_i
        end

        def fecha
          Time.strptime(response.css('Documento>Fecha').text, '%FT%T')
        end
      end
    end
  end
end
