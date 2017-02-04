module Facturapi
  module Helpers
    class Totales
      IVA = 0.19
      attr_accessor :mnt_neto, :mnt_exe, :iva, :mnt_total, :monto_nf,
                    :total_periodo, :saldo_anterior, :vlr_pagar

      def initialize(params = {})
        @mnt_neto = params[:mnt_neto].to_i if params[:mnt_neto]
        @mnt_exe = params[:mnt_exe].to_i if params[:mnt_exe]
        @iva = params[:iva].to_i if params[:iva]
        @mnt_total = params[:mnt_total].to_i if params[:mnt_total]
        @monto_nf = params[:monto_nf].to_i if params[:monto_nf]
        @total_periodo = params[:total_periodo].to_i if params[:total_periodo]
        @saldo_anterior = params[:saldo_anterior].to_i
        @vlr_pagar = params[:vlr_pagar].to_i if params[:vlr_pagar]
        autocomplete! if params[:auto]
      end

      def as_node
        create_node('Totales') do |totales|
          totales << create_node('MntNeto') { |n| n << mnt_neto }
          totales << create_node('MntExe') { |n| n << mnt_exe }
          totales << create_node('IVA') { |n| n << iva }
          totales << create_node('MntTotal') { |n| n << mnt_total }
          totales << create_node('MontoNF') { |n| n << monto_nf }
          totales << create_node('TotalPeriodo') { |n| n << total_periodo }
          totales << create_node('SaldoAnterior') { |n| n << saldo_anterior }
          totales << create_node('VlrPagar') { |n| n << vlr_pagar }
        end
      end

      def autocomplete!
        self.iva = (mnt_neto * IVA).to_i if iva.blank?
        yield
        self.total_periodo = mnt_total + monto_nf if total_periodo.blank?
        self.vlr_pagar = mnt_total + saldo_anterior if vlr_pagar.blank?
      end

      def auto_mnt_total
        mnt_neto + iva + mnt_exe
      end
    end
  end
end
