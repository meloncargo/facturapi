module Facturapi
  module Helpers
    # Corresponde a las lineas de referencia de una Boleta Electronica,
    # etiqueta e informacion opcional con un maximo de 40
    class Referencia
      # Indica el numero secuencial de linea de referencia de la Boleta
      # Electronica, el cual puede ser desde la linea 1 hasta la linea 40.
      attr_accessor :nro_lin_ref

      # Corresponde a un codigo que identifique el tipo de referencia que se
      # presentara en el formato impreso de la Boleta Electronica, ya sea para
      # control interno o para indicar algun dato al cliente que reciba el
      # documento. El codigo es establecido por la empresa.
      attr_accessor :cod_ref

      # Corresponde al dato alfanumerico de un codigo de referencia.
      attr_accessor :razon_ref

      # Es el codigo de tipo de documento al que se hace referencia, con un
      # maximo de 3 caracteres. Si corresponde a un documento tributario,
      # corresponde a un valor numerico, el cual esta codificado por el
      # Servicio de Impuestos Internos.
      #
      # - 29: FACTURA
      # - 31: FACTURA EXENTA
      # - 32: FACTURA ELECTRONICA
      # - 33: FACTURA EXENTA ELECTRONICA
      # - 34: BOLETA
      # - 37: BOLETA EXENTA
      # - 38: BOLETA ELECTRONICA
      # - 39: LIQUIDACION FACTURA
      # - 44: FACTURA DE COMPRA
      # - 45: FACTURA DE COMPRA ELECTRONICA
      # - 49: GUIA DE DESPACHO
      # - 51: GUIA DE DESPACHO ELECTRONICA
      # - 54: NOTA DE DEBITO
      # - 55: NOTA DE DEBITO ELECTRONICA
      # - 59: NOTA DE CREDITO
      # - 60: NOTA DE CREDITO ELECTRONICA
      # - 800: ORDEN DE COMPRA
      # - 801: NOTA DE PEDIDO
      # - 802: CONTRATO
      # - 813: CERTIFICADO DE DEPOSITO BOLSA PROD. CHILE
      # - 814: VALE DE PRENDA BOLSA PROD. CHILE
      #
      # Si es alfabetico, corresponde a documentos no tributarios, normalmente
      # definidos por requerimiento de su cliente.
      # - HES: HOJA DE ESTADO DE SERVICIO
      # - HAS: HOJA DE ACEPTACION DE SERVICIO
      # - HEM: RECEPCION DE MATERIAL
      attr_accessor :tpo_doc_ref

      # Es el folio del documento referenciado, indica el numero del documento
      # que se alterara.
      attr_accessor :folio_ref

      # Es la fecha de emision del documento al que se hace referencia, el
      # formato de la fecha es "AAAA-MM-DD" (anio, mes, dia)
      attr_accessor :fecha_ref

      def initialize(params = {})
        @nro_lin_ref = params[:nro_lin_ref]
        @cod_ref = params[:cod_ref]
        @razon_ref = params[:razon_ref]
        @tpo_doc_ref = params[:tpo_doc_ref]
        @folio_ref = params[:folio_ref]
        @fecha_ref = params[:fecha_ref]
      end

      def as_node
        create_node('Referencia') do |referencia|
          referencia << create_node('NroLinRef') { |n| n << nro_lin_ref }
          referencia << create_node('CodRef') { |n| n << cod_ref }
          referencia << create_node('RazonRef') { |n| n << razon_ref }
          referencia << create_node('TpoDocRef') { |n| n << tpo_doc_ref } if tpo_doc_ref
          referencia << create_node('FolioRef') { |n| n << folio_ref } if folio_ref
          referencia << create_node('FechaRef') { |n| n << fecha_ref } if fecha_ref
        end
      end
    end
  end
end
