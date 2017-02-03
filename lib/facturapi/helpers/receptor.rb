module Facturapi
  module Helpers
    class Receptor
      attr_accessor :rut_recep, :cdg_int_recep, :rzn_soc_recep, :contacto,
                    :dir_recep, :cmna_recep, :ciudad_recep

      def initialize(params = {})
        @rut_recep = params[:rut_recep]
        @cdg_int_recep = params[:cdg_int_recep]
        @rzn_soc_recep = params[:rzn_soc_recep]
        @contacto = params[:contacto]
        @dir_recep = params[:dir_recep]
        @cmna_recep = params[:cmna_recep]
        @ciudad_recep = params[:ciudad_recep]
      end

      def as_node
        create_node('Receptor') do |receptor|
          receptor << create_node('RUTRecep') { |n| n << rut_recep }
          receptor << create_node('CdgIntRecep') { |n| n << cdg_int_recep }
          receptor << create_node('RznSocRecep') { |n| n << rzn_soc_recep }
          receptor << create_node('Contacto') { |n| n << contacto }
          receptor << create_node('DirRecep') { |n| n << dir_recep }
          receptor << create_node('CmnaRecep') { |n| n << cmna_recep }
          receptor << create_node('CiudadRecep') { |n| n << ciudad_recep }
        end
      end
    end
  end
end
