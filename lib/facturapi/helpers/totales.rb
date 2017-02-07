module Facturapi
  module Helpers
    # Corresponde a los valores totales de una Boleta Electronica.
    class Totales
      IVA = 0.19

      # Corresponde al valor Neto de la boleta electronica, solamente se indica
      # en el caso que el sea una boleta afecta y que IndMntNeto tenga el
      # valor 2. Al ser un campo de monto, se debe indicar sin decimales y sin
      # separadores de miles. Se calcula de la siguiente forma:
      #
      #   MntNeto = Suma de MontoItem por linea de detalle - Descuentos + Recargos
      #   # Solamente MontoItem de los items que tienen IndExe = 0
      #   # Descuentos y Recargos basados en etiqueta <DscRcgGlobal>
      attr_accessor :mnt_neto

      # Corresponde al valor Exento de la boleta electronica. Al ser un campo de
      # monto, se debe indicar sin decimales y sin separadores de miles.
      # Se calcula de la siguiente forma:
      #
      #   MntExe = Suma de ValorExento por linea de detalle
      #   # Solamente MontoItem de los items que tienen IndExe = 1
      attr_accessor :mnt_exe

      # Corresponde al valor IVA (Impuesto al Valor Agregado) de la boleta
      # electronica, solamente se indica en el caso que el sea una boleta afecta
      # y que IndMntNeto tenga el valor 2. Al ser un campo de monto, se debe
      # indicar sin decimales y sin separadores de miles.
      # Se calcula de la siguiente forma:
      #
      #   IVA = MntNeto * 19%
      attr_accessor :iva

      # Corresponde al valor total de la boleta electronica y se puede calcular
      # de dos maneras diferentes. Al ser un campo de monto, se debe indicar sin
      # decimales y sin separadores de miles.
      # Se calcula de la siguiente forma:
      #
      #   # Para el caso que se indique una boleta afecta y que IndMntNeto tenga
      #   # el valor 2, se calcula:
      #   MntTotal = MntNeto + IVA + MntExe
      #   # Para el caso que no se indique IndMntNeto, o tenga el valor 0, se
      #   # calcula:
      #   MntTotal = Suma de MontoItem por linea de detalle - Descuentos + Recargos
      #   # Solamente MontoItem de los items que tienen IndExe = 0
      #   # Descuentos y Recargos basados en etiqueta <DscRcgGlobal>
      attr_accessor :mnt_total

      # Corresponde a la suma de los montos de bienes o servicios no facturables
      # de la boleta electronica. Los montos no facturables pueden ser
      # negativos. Al ser un campo de monto, se debe indicar sin decimales y sin
      # separadores de miles. Se calcula de la siguiente forma:
      #
      #   MontoNF = Suma de MontoItem por linea de detalle
      #   # Solamente MontoItem de los items que tienen IndExe igual a 2 y 6.
      attr_accessor :monto_nf

      # Corresponde a la suma final del documento, tomando el total y el monto
      # no facturable en la boleta electronica. Al ser un campo de monto, se
      # debe indicar sin decimales y sin separadores de miles.
      # Se calcula de la siguiente forma:
      #
      #   TotalPeriodo = MntTotal + MontoNF
      attr_accessor :total_periodo

      # Corresponde al saldo anterior de un periodo, esta es informacion
      # ilustrativa en la boleta electronica, es decir, que se utiliza para el
      # formato impreso del documento. Si no se desea usar, se debe asignar
      # 0 (cero). Al ser un campo de monto, se debe indicar sin decimales y sin
      # separadores de miles.
      attr_accessor :saldo_anterior

      # Es el valor cobrado de la transaccion realizada. Al ser un campo de
      # monto, se debe indicar sin decimales y sin separadores de miles.
      # Se calcula de la siguiente forma:
      #
      #   VlrPagar = MntTotal + SaldoAnterior
      attr_accessor :vlr_pagar

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
