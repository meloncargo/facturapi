module Facturapi
  module Service
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
        Nokogiri::XML(response)
      end
    end
  end
end
