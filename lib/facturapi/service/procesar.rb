module Facturapi
  module Service
    class Procesar
      attr_accessor :dte
      attr_reader :client

      def initialize(dte)
        @dte = dte
        @client = Facturapi::Client.new
      end

      def send
        file = Base64.strict_encode64(dte.as_node.to_s)
        params = { file: file, formato: 2 }
        response = client.call(:procesar, params)
        Nokogiri::XML(response)
        # doc = Nokogiri::XML(response)
        # ok = doc.css('WSPLANO>Resultado').text
        # mensaje = doc.css('WSPLANO>Mensaje').text
        # error = doc.css('Documento>Error').text
      end
    end
  end
end
