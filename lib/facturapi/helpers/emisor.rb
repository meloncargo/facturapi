module Facturapi
  module Helpers
    # Corresponde a los datos del Emisor de una Boleta Electronica
    class Emisor
      # Corresponde al RUT del Emisor, con valor desde 100.000
      # hasta 99 millones, guion y digito verificador (sin separador de miles).
      attr_accessor :rut_emisor

      # Corresponde a la razon social o nombre del contribuyente Emisor.
      attr_accessor :rzn_soc_emisor

      # Corresponde al giro del negocio del Emisor antes identificado.
      attr_accessor :giro_emisor

      # Corresponde a la direccion legal del Emisor (registrada en el SII), no
      # se especifica la comuna ni la ciudad.
      attr_accessor :dir_origen

      # Corresponde a la comuna legal del Emisor (registrada en el SII).
      attr_accessor :cmna_origen

      # Corresponde a la ciudad legal del Emisor (registrada en el SII)
      attr_accessor :ciudad_origen

      def initialize(params = {})
        @rut_emisor = params[:rut_emisor]
        @rzn_soc_emisor = params[:rzn_soc_emisor]
        @giro_emisor = params[:giro_emisor]
        @dir_origen = params[:dir_origen]
        @cmna_origen = params[:cmna_origen]
        @ciudad_origen = params[:ciudad_origen]
      end

      def as_node
        create_node('Emisor') do |emisor|
          emisor << create_node('RUTEmisor') { |n| n << rut_emisor }
          emisor << create_node('RznSocEmisor') { |n| n << rzn_soc_emisor }
          emisor << create_node('GiroEmisor') { |n| n << giro_emisor }
          emisor << create_node('DirOrigen') { |n| n << dir_origen }
          emisor << create_node('CmnaOrigen') { |n| n << cmna_origen }
          emisor << create_node('CiudadOrigen') { |n| n << ciudad_origen }
        end
      end
    end
  end
end
