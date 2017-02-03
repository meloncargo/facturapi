module Facturapi
  module Helpers
    class Referencia
      attr_accessor :nro_lin_ref, :cod_ref, :razon_ref

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
