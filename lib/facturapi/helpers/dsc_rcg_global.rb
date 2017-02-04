module Facturapi
  module Helpers
    class DscRcgGlobal
      attr_accessor :nro_lin_dr, :tpo_mov, :glosa_dr, :tpo_valor, :valor_dr,
                    :ind_exe_dr

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
