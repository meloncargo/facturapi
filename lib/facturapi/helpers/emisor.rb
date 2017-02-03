module Facturapi
  module Helpers
    class Emisor
      attr_accessor :rut_emisor, :rzn_soc_emisor, :giro_emisor, :dir_origen,
                    :cmna_origen, :ciudad_origen

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
