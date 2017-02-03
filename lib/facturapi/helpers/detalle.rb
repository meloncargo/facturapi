module Facturapi
  module Helpers
    class Detalle
      attr_accessor :nro_lin_det, :tpo_codigo, :vlr_codigo, :ind_exe,
                    :rut_mandante, :nmb_item, :dsc_item, :qty_item, :unmd_item,
                    :prc_item, :monto_item

      def initialize(params = {})
        @nro_lin_det = params[:nro_lin_det]
        @tpo_codigo = params[:tpo_codigo]
        @vlr_codigo = params[:vlr_codigo]
        @ind_exe = params[:ind_exe]
        @rut_mandante = params[:rut_mandante]
        @nmb_item = params[:nmb_item]
        @dsc_item = params[:dsc_item]
        @qty_item = params[:qty_item]
        @unmd_item = params[:unmd_item]
        @prc_item = params[:prc_item]
        @monto_item = params[:monto_item]
      end

      def as_node
        create_node('Detalle') do |detalle|
          detalle << create_node('NroLinDet') { |n| n << nro_lin_det }
          detalle << create_node('TpoCodigo') { |n| n << tpo_codigo }
          detalle << create_node('VlrCodigo') { |n| n << vlr_codigo }
          detalle << create_node('IndExe') { |n| n << ind_exe }
          detalle << create_node('RUTMandante') { |n| n << rut_mandante }
          detalle << create_node('NmbItem') { |n| n << nmb_item }
          detalle << create_node('DscItem') { |n| n << dsc_item }
          detalle << create_node('QtyItem') { |n| n << qty_item }
          detalle << create_node('UnmdItem') { |n| n << unmd_item }
          detalle << create_node('PrcItem') { |n| n << prc_item }
          detalle << create_node('MontoItem') { |n| n << monto_item }
        end
      end
    end
  end
end
