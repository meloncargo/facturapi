require 'facturapi/services/responses/obtener_link'

module Facturapi
  module Services
    # Obtiene el Link de descarga del Documento Tributario una vez que este ha
    # sido generado y enviado al SII.
    # Se puede utilizar directamente el indicador "IncluyeLink" al procesar, en
    # caso que se desee obtener los link de Impresion al emitir.
    class ObtenerLink
      # Corresponde al tipo de movimiento asociado al documento enviado:
      # C = Compra
      # V = Venta
      # B = Boleta
      attr_accessor :tpomov

      # Corresponde al numero de Folio del Documento.
      attr_accessor :folio

      # Corresponde al Tipo de Documento (Tipo DTE)
      attr_accessor :tipo

      # Indica si se obtendra la copia cedible del PDF.
      # True = Se obtiene copia Cedible.
      # False = Se obtiene la copia Original.
      attr_accessor :cedible

      def initialize(params)
        @tpomov = Base64.strict_encode64(params[:tpomov].to_s.upcase.presence || 'B')
        @folio = Base64.strict_encode64(params[:folio].to_s)
        @tipo = Base64.strict_encode64((params[:tipo] || '39').to_s)
        @cedible = Base64.strict_encode64(params[:cedible] ? 'True' : 'False')
      end

      def send
        response = Facturapi::Client.call(:obtener_link, params)
        Facturapi::Services::Responses::ObtenerLink.new(
          response.body[:obtener_link_response][:obtener_link_result]
        )
      end

      def params
        { tpomov: tpomov, folio: folio, tipo: tipo, cedible: cedible }
      end

      def to_s
        Facturapi::Client.xml(:obtener_link, params)
      end
    end
  end
end
