require 'facturapi/services/responses/get_xml_dte'

module Facturapi
  module Services
    # Este es un metodo adicional que permite obtener al archivo XML del
    # documento generado previo envio al Servicio de Impuestos Internos SII
    class GetXmlDte
      # Corresponde al tipo de movimiento asociado al documento enviado:
      # C = Compra
      # V = Venta
      # B = Boleta
      attr_accessor :tpomov

      # Corresponde al numero de Folio del Documento.
      attr_accessor :folio

      # Corresponde al Tipo de Documento (Tipo DTE)
      attr_accessor :tipo

      def initialize(params)
        @tpomov = Base64.strict_encode64(params[:tpomov] || 'B')
        @folio = Base64.strict_encode64(params[:folio].to_s)
        @tipo = Base64.strict_encode64((params[:tipo] || '39').to_s)
      end

      def send
        response = Facturapi::Client.call(:get_xml_dte, params)
        Facturapi::Services::Responses::GetXmlDte.new(
          response.body[:procesar_response][:procesar_result]
        )
      end

      def params
        { tpomov: tpomov, folio: folio, tipo: tipo }
      end

      def to_s
        Facturapi::Client.xml(:get_xml_dte, params)
      end
    end
  end
end
