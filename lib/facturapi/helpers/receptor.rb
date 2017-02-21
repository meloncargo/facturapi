module Facturapi
  module Helpers
    # Corresponde a los datos del Receptor de una Boleta Electronica.
    class Receptor
      RUT_AUXILIAR = '66666666-6'.freeze

      # Corresponde al RUT del Cliente con valor desde 100.000 hasta 99
      # millones, guion y digito verificador (sin separador de miles).
      # En el caso que para una Boleta Electronica se desconozcan los datos del
      # cliente, el SII ha proporcionado un RUT de Cliente Auxiliar para emitir
      # en estas circunstancias.
      attr_accessor :rut_recep

      # Corresponde a la razon social o nombre del Cliente.
      attr_accessor :rzn_soc_recep

      # Corresponde a la direccion de correo electronico del Cliente a la que
      # sera enviado el documento electronico tras su generacion. En el caso que
      # no se desee enviar por correo electronico el documento, no debe venir
      # informacion en este campo.
      attr_accessor :contacto

      # Corresponde a la direccion legal del Cliente (registrada en el SII), no
      # se especifica la comuna ni la ciudad.
      attr_accessor :dir_recep

      # Corresponde a la comuna legal del Cliente (registrada en el SII)
      attr_accessor :cmna_recep

      # Corresponde a la ciudad legal del Cliente (registrada en el SII)
      attr_accessor :ciudad_recep

      # Este campo es utilizado para identificar de manera adicional al cliente,
      # basado en una codificacion interna.
      attr_accessor :cdg_int_recep

      # Corresponde al giro del negocio del Cliente antes identificado, con un
      # maximo de 40 caracteres
      attr_accessor :giro_recep

      def initialize(params = {})
        @rut_recep = params[:rut_recep] || RUT_AUXILIAR
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
          receptor << create_node('RznSocRecep') { |n| n << rzn_soc_recep }
          receptor << create_node('Contacto') { |n| n << contacto }
          receptor << create_node('DirRecep') { |n| n << dir_recep }
          receptor << create_node('CmnaRecep') { |n| n << cmna_recep }
          receptor << create_node('CiudadRecep') { |n| n << ciudad_recep }
          receptor << create_node('CdgIntRecep') { |n| n << cdg_int_recep } if cdg_int_recep
          receptor << create_node('GiroRecep') { |n| n << giro_recep } if giro_recep
        end
      end
    end
  end
end
