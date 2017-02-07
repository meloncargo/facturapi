module Facturapi
  module Helpers
    # Corresponde a la Identificacion del Documento en el encabezado de una
    # Boleta Electronica
    class IdDoc
      # Corresponde al numero de Tipo de Documento codificado por el Servicio de
      # Impuestos Internos (SII).
      # - 39: BOLETA ELECTRONICA
      # - 41: BOLETA EXENTA ELECTRONICA
      attr_accessor :tipo_dte

      # Es el folio del documento de acuerdo con los correlativos
      # autorizados por el SII y disponibles para el tipo de documento antes
      # mencionado. En el caso que se requiera auto-asignacion de folio,
      # entonces se debe indicar el valor 0 (cero) en este campo.
      attr_accessor :folio

      # Es la fecha de emision del documento en cuestion, el formato de la fecha
      # es "AAAA-MM-DD' (anio, mes, dia).
      attr_accessor :fch_emis

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

      # Corresponde a la Fecha de vencimiento y es obligatoria en
      # el caso de una facturacion de servicios periodicos domiciliarios, el
      # formato de la fecha es "AAAA-MM-DD' (anio, mes, dia)
      attr_accessor :fch_venc

      def initialize(params = {})
        @tipo_dte = /^39|41$/ =~ params[:tipo_dte].to_s ? params[:tipo_dte].to_s : '39'
        @folio = params[:folio] || 0
        @fch_emis = format_date(params[:fch_emis])
        @ind_servicio = params[:ind_servicio].to_s if /^[1-4]$/ =~ params[:ind_servicio].to_s
        @ind_mnt_neto = /^[02]$/ =~ params[:ind_mnt_neto].to_s ? params[:ind_mnt_neto].to_s : '0'
        @periodo_desde = format_date(params[:periodo_desde])
        @periodo_hasta = format_date(params[:periodo_hasta])
        @fch_venc = format_date(params[:fch_venc])
      end

      def as_node
        create_node('IdDoc') do |id_doc|
          id_doc << create_node('TipoDTE') { |n| n << tipo_dte }
          id_doc << create_node('Folio') { |n| n << folio }
          id_doc << create_node('FchEmis') { |n| n << fch_emis }
          id_doc << create_node('IndServicio') { |n| n << ind_servicio }
          id_doc << create_node('IndMntNeto') { |n| n << ind_mnt_neto }
          id_doc << create_node('PeriodoDesde') { |n| n << periodo_desde }
          id_doc << create_node('PeriodoHasta') { |n| n << periodo_hasta }
          id_doc << create_node('FchVenc') { |n| n << fch_venc }
        end
      end

      def format_date(date)
        date.strftime('%Y-%m-%d') if date
      end

      def monto_bruto?
        ind_mnt_neto == '0'
      end

      def monto_neto?
        ind_mnt_neto == '2'
      end
    end
  end
end
