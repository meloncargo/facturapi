module Facturapi
  module Helpers
    # Corresponde a las lineas de detalle de una Boleta Electronica, con un
    # minimo de 1 linea de detalle y un maximo de 1.000 lineas
    class Detalle
      # Indica el numero secuencial de linea de detalle de la Boleta
      # Electronica, el cual puede ser desde la linea 1 hasta la linea 1.000.
      attr_accessor :nro_lin_det

      # Es el tipo de codigo que la empresa utiliza en el producto que se esta
      # indicando en la linea de detalle; si no se tiene un tipo de codigo
      # definido, se puede utilizar por defecto el tipo INT1.
      attr_accessor :tpo_codigo

      # Es el codigo del producto, con un maximo de 35 caracteres.
      attr_accessor :vlr_codigo

      # Indica si el producto o servicio del item es afecto, exento o es no
      # facturable, los indicadores son:
      #
      # - 0: afecto a IVA
      # - 1: exento de IVA
      # - 2: no facturable
      # - 6: no facturable (negativo)
      attr_accessor :ind_exe

      # Corresponde al RUT del Mandante si la venta o servicio es por cuenta
      # de otro, el cual es responsable del IVA devengado en el periodo.
      # Debe contener valor desde 100.000 hasta 99 millones, guion y digito
      # verificador (sin separador de miles).
      attr_accessor :rut_mandante

      # Es la descripcion del producto o servicio, es decir, corresponde al
      # nombre del producto o descripcion del servicio.
      attr_accessor :nmb_item

      # Es la descripcion adicional del producto o servicio antes indicado,
      # con un maximo de 1.000 caracteres, en este campo se puede indicar mas
      # informacion del producto o incluso una observacion en la linea de
      # detalle.
      attr_accessor :dsc_item

      # Es la cantidad del item, su valor debe ser hasta 12 digitos y 6
      # decimales.
      attr_accessor :qty_item

      # Es la unidad de medida que se utiliza en el producto que se esta
      # indicando en la linea de detalle; si no se tiene una unidad de medida
      # definida, se puede utilizar por defecto la unidad de medida UN
      attr_accessor :unmd_item

      # Es el precio unitario del item, su valor debe ser hasta 16 digitos y
      # 2 decimales.
      attr_accessor :prc_item

      # Indica el valor del item, es decir, el valor final de la linea de
      # detalle. Este valor es bruto (con IVA), excepto cuando el campo
      # IndMntNeto tenga el valor 2. Al ser un campo de monto, se debe
      # indicar sin decimales y sin separadores de miles.
      # Se calcula de la siguiente forma:
      #   MontoItem = PrcItem * QtyItem
      attr_accessor :monto_item

      def initialize(params = {})
        @nro_lin_det = params[:nro_lin_det]
        @tpo_codigo = params[:tpo_codigo] || 'INT1'
        @vlr_codigo = params[:vlr_codigo]
        @ind_exe = /^[0126]$/ =~ params[:ind_exe].to_s ? params[:ind_exe].to_s : '0'
        @rut_mandante = params[:rut_mandante]
        @nmb_item = params[:nmb_item]
        @dsc_item = params[:dsc_item]
        @qty_item = params[:qty_item].to_f.round(6)
        @unmd_item = params[:unmd_item] || 'UN'
        @prc_item = params[:prc_item].to_f.round(2)
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

      def autocomplete!
        self.monto_item = (prc_item * qty_item).to_i if monto_item.blank?
      end

      def afecto_iva?
        ind_exe == '0'
      end

      def exento_iva?
        ind_exe == '1'
      end

      def no_fact?
        ind_exe == '2'
      end

      def no_fact_neg?
        ind_exe == '6'
      end
    end
  end
end
