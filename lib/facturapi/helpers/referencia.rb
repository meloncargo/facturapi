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

      def initialize(params = {})
        @nro_lin_ref = params[:nro_lin_ref]
        @cod_ref = params[:cod_ref]
        @razon_ref = params[:razon_ref]
      end

      def as_node
        create_node('Referencia') do |referencia|
          referencia << create_node('NroLinRef') { |n| n << nro_lin_ref }
          referencia << create_node('CodRef') { |n| n << cod_ref }
          referencia << create_node('RazonRef') { |n| n << razon_ref }
        end
      end
    end
  end
end
