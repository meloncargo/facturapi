module Facturapi
  module Helpers
    # Corresponde a la o las lineas de descuento / recargo global de una
    # Boleta Electronica, etiqueta e informacion opcional, con un maximo
    # de 20
    class DscRcgGlobal
      # Indica el numero secuencial de linea de descuento /
      # recargo de la Boleta Electronica, el cual puede ser desde la linea 1
      # hasta la linea 20
      attr_accessor :nro_lin_dr

      # Indica el tipo de movimiento de la linea de descuento /
      # recargo, informando que tipo de aplicacion tendran los posteriores
      # valores en la linea, los tipos son:
      # - D: Corresponde a una DESCUENTO
      # - R: Corresponde a una RECARGO
      attr_accessor :tpo_mov

      # Corresponde a una breve descripcion del descuento / recargo
      attr_accessor :glosa_dr

      # Indica el tipo de valor de la linea de descuento / recargo. El valor
      # sera indicado en el campo ValorDR, los tipos son:
      # - % : Corresponde a un porcentaje
      # - $ : Corresponde a un valor en moneda nacional
      attr_accessor :tpo_valor

      # Es el valor de descuento / recargo. Su valor debe ser hasta 16 digitos y
      # 2 decimales. Al ser un campo de monto, se debe indicar sin decimales y
      # sin separadores de miles.
      attr_accessor :valor_dr

      # Indicador de exencion de un descuento / recargo, para la Boleta
      # Electronica. Los indicadores son:
      # - 0: Descuento / Recargo se aplica a items afectos a IVA
      # - 1: Descuento / Recargo se aplica a items exentos
      # - 2: Descuento / Recargo se aplica a items facturables
      attr_accessor :ind_exe_dr

      def initialize(params = {})
        @nro_lin_dr = params[:nro_lin_dr]
        @tpo_mov = params[:tpo_mov].to_s.upcase
        @glosa_dr = params[:glosa_dr]
        @tpo_valor = /^[\$\%]$/ =~ params[:tpo_valor].to_s ? params[:tpo_valor] : '$'
        @valor_dr = params[:valor_dr].to_i if params[:valor_dr]
        @ind_exe_dr = /^[0-2]$/ =~ params[:ind_exe_dr].to_s ? params[:ind_exe_dr] : 0
      end

      def as_node
        create_node('DscRcgGlobal') do |dsc_rcg_global|
          dsc_rcg_global << create_node('NroLinDR') { |n| n << nro_lin_dr }
          dsc_rcg_global << create_node('TpoMov') { |n| n << tpo_mov }
          dsc_rcg_global << create_node('GlosaDR') { |n| n << glosa_dr }
          dsc_rcg_global << create_node('TpoValor') { |n| n << tpo_valor }
          dsc_rcg_global << create_node('ValorDR') { |n| n << valor_dr }
          dsc_rcg_global << create_node('IndExeDR') { |n| n << ind_exe_dr }
        end
      end

      def descuento?
        tpo_mov == 'D'
      end

      def recargo?
        tpo_mov == 'R'
      end
    end
  end
end
