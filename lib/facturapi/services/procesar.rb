require 'facturapi/services/responses/procesar'

module Facturapi
  module Services
    # Permite procesar el archivo de Integracion y generar el DTE (Documento
    # Tributario Electronico).
    class Procesar
      attr_accessor :dte

      def initialize(dte = nil)
        @dte = dte
      end

      def send
        response = Facturapi::Client.call(:procesar, params)
        Facturapi::Services::Responses::Procesar.new(
          response.body[:procesar_response][:procesar_result]
        )
      end

      def params
        { file: Base64.strict_encode64(dte.as_node.to_s), formato: 2 }
      end

      def to_s
        Facturapi::Client.xml(:procesar, params)
      end
    end
  end
end
