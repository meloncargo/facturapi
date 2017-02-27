module Facturapi
  module Helpers
    # Corresponde a la Identificacion del Documento en el encabezado de una
    # Boleta Electronica
    class IdDoc
      # Corresponde al numero de Tipo de Documento codificado por el Servicio de
      # Impuestos Internos (SII).
      # - 30: FACTURA
      # - 32: FACTURA EXENTA
      # - 33: FACTURA ELECTRONICA
      # - 34: FACTURA EXENTA ELECTRONICA
      # - 35: BOLETA
      # - 38: BOLETA EXENTA
      # - 39: BOLETA ELECTRONICA
      # - 40: LIQUIDACION FACTURA
      # - 41: BOLETA EXENTA ELECTRONICA
      # - 43: LIQUIDACION FACTURA ELECTRONICA
      # - 45: FACTURA DE COMPRA
      # - 46: FACTURA DE COMPRA ELECTRONICA
      # - 50: GUIA DE DESPACHO
      # - 52: GUIA DE DESPACHO ELECTRONICA
      # - 55: NOTA DE DEBITO
      # - 56: NOTA DE DEBITO ELECTRONICA
      # - 60: NOTA DE CREDITO
      # - 61: NOTA DE CREDITO ELECTRONICA
      attr_accessor :tipo_dte

      # Es el folio del documento de acuerdo con los correlativos
      # autorizados por el SII y disponibles para el tipo de documento antes
      # mencionado. En el caso que se requiera auto-asignacion de folio,
      # entonces se debe indicar el valor 0 (cero) en este campo.
      attr_accessor :folio

      # Es la fecha de emision del documento en cuestion, el formato de la fecha
      # es "AAAA-MM-DD' (anio, mes, dia).
      attr_accessor :fch_emis

      # Corresponde a la Fecha de vencimiento y es obligatoria en
      # el caso de una facturacion de servicios periodicos domiciliarios, el
      # formato de la fecha es "AAAA-MM-DD' (anio, mes, dia)
      attr_accessor :fch_venc

      # Corresponde al indicador que identifica el tipo de transaccion que se
      # realiza con el documento de acuerdo a lo codificado por el SII.
      # - 1: Servicios Periodicos.
      # - 2: Servicios Periodicos Domiciliarios.
      # - 3: Ventas y Servicios.
      # - 4: Espectaculos emitida por cuenta de terceros.
      attr_accessor :ind_servicio

      # Este indicador se utiliza para expresar que el precio unitario y el
      # valor de todas las lineas de detalles corresponden a Montos Netos, es
      # decir, no incluyen el IVA. Solo se aplica para empresas que tienen
      # autorizacion para emitir las boletas desglosando el IVA. No aplica en
      # Boleta Exenta.
      # - 0: Lineas de Detalle indicadas en Montos Brutos.
      # - 2: Lineas de Detalle indicadas en Montos Netos.
      attr_accessor :ind_mnt_neto

      # Es el periodo desde de una facturacion de servicios
      # periodicos y aplica solamente para estos casos, el formato de la fecha
      # es "AAAA-MM-DD' (anio, mes, dia).
      attr_accessor :periodo_desde

      # Es el periodo hasta de una facturacion de servicios
      # periodicos y aplica solamente para estos casos, el formato de la fecha
      # es "AAAA-MM-DD' (anio, mes, dia)
      attr_accessor :periodo_hasta

      # Indica si las lineas de detalle, descuentos y recargos se expresan
      # en montos brutos. (Solo para documentos sin impuestos adicionales).
      # Solamente se acepta el valor 1 ( <MntBruto>1</MntBruto> ).
      # Si no se indica, se asume los valores en montos Netos.
      attr_accessor :mnt_bruto

      # (Solo para Guias de despacho) Indica si el documento acompania bienes y
      # el despacho es por cuenta del vendedor o del comprador.
      # No se incluye si el documento no acompania bienes o se trata de una
      # Factura o Nota correspondiente a la prestacion de servicios.
      # Sus valores pueden ser:
      #
      # - 0: Sin Despacho.
      # - 1: Despacho por cuenta del receptor del documento (cliente o vendedor
      #      en caso de Facturas de compra).
      # - 2: Despacho por cuenta del emisor a instalaciones del cliente.
      # - 3: Despacho por cuenta del emisor a otras instalaciones
      #      (Ejemplo: entrega en Obra).
      attr_accessor :tipo_despacho

      # (Solo para Guias de despacho) Indica si el traslado de mercaderia es por
      # Venta (valor 1) o por otros motivos que no corresponden a venta
      # (valores mayores a 1). Sus valores pueden ser:
      #
      # - 1: Operacion constituye venta.
      # - 2: Ventas por efectuar.
      # - 3: Consignaciones.
      # - 4: Entrega gratuita.
      # - 5: Traslados internos.
      # - 6: Otros traslados no venta.
      # - 7: Guia de devolucion.
      attr_accessor :ind_traslado

      def initialize(params = {})
        @tipo_dte = params[:tipo_dte].to_s if Facturapi::Utils::DteTypes::VALID_REGEXP =~ params[:tipo_dte].to_s
        @folio = params[:folio] || 0
        @fch_emis = format_date(params[:fch_emis])
        @fch_venc = format_date(params[:fch_venc])

        if boleta?
          @ind_servicio = params[:ind_servicio].to_s if /^[1-4]$/ =~ params[:ind_servicio].to_s
          @ind_mnt_neto = /^[02]$/ =~ params[:ind_mnt_neto].to_s ? params[:ind_mnt_neto].to_s : '0'
          @periodo_desde = format_date(params[:periodo_desde])
          @periodo_hasta = format_date(params[:periodo_hasta])
        end

        if guia_de_despacho?
          @tipo_despacho = params[:tipo_despacho].to_s if /^[0-3]$/ =~ params[:tipo_despacho].to_s
          @ind_traslado = params[:ind_traslado].to_s if /^[1-7]$/ =~ params[:ind_traslado].to_s
        end

        @mnt_bruto = 1 if params[:mnt_bruto]
      end

      def as_node
        create_node('IdDoc') do |id_doc|
          id_doc << create_node('TipoDTE') { |n| n << tipo_dte }
          id_doc << create_node('Folio') { |n| n << folio }
          id_doc << create_node('FchEmis') { |n| n << fch_emis }
          id_doc << create_node('FchVenc') { |n| n << fch_venc }
          if boleta?
            id_doc << create_node('IndServicio') { |n| n << ind_servicio }
            id_doc << create_node('IndMntNeto') { |n| n << ind_mnt_neto }
            id_doc << create_node('PeriodoDesde') { |n| n << periodo_desde }
            id_doc << create_node('PeriodoHasta') { |n| n << periodo_hasta }
          end
          if guia_de_despacho?
            id_doc << create_node('TipoDespacho') { |n| n << tipo_despacho }
            id_doc << create_node('IndTraslado') { |n| n << ind_traslado }
          end
          id_doc << create_node('MntBruto') { |n| n << mnt_bruto } if mnt_bruto
        end
      end

      def format_date(date)
        date.strftime('%Y-%m-%d') if date
      end

      def monto_bruto?
        ind_mnt_neto == '0' || mnt_bruto == 1
      end

      def monto_neto?
        ind_mnt_neto == '2' || (mnt_bruto && mnt_bruto != 1)
      end

      def boleta?
        /^39|41$/ =~ tipo_dte
      end

      def guia_de_despacho?
        /^50|52$/ =~ tipo_dte
      end
    end
  end
end
