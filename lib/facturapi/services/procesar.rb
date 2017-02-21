require 'facturapi/services/responses/procesar'

module Facturapi
  module Services
    # Permite procesar el archivo de Integracion y generar el DTE (Documento
    # Tributario Electronico).
    class Procesar
      attr_accessor :dte

      def initialize(dte)
        @dte = dte
      end

      def send
        file = Base64.strict_encode64(dte.as_node.to_s)
        params = { file: file, formato: 2 }
        response = Facturapi::Client.call(:procesar, params)
        Facturapi::Services::Responses::Procesar.new(
          response.body[:procesar_response][:procesar_result]
        )
      end
    end
  end
end
