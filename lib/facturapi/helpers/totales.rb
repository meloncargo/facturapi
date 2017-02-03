module Facturapi
  module Helpers
    class Totales
      attr_accessor :mnt_neto, :mnt_exe, :iva, :mnt_total, :monto_nf,
                    :total_periodo, :saldo_anterior, :vlr_pagar

      def initialize(params = {})
        @mnt_neto = params[:mnt_neto]
        @mnt_exe = params[:mnt_exe]
        @iva = params[:iva]
        @mnt_total = params[:mnt_total]
        @monto_nf = params[:monto_nf]
        @total_periodo = params[:total_periodo]
        @saldo_anterior = params[:saldo_anterior]
        @vlr_pagar = params[:vlr_pagar]
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
    end
  end
end
