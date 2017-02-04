module Facturapi
  module Helpers
    class IdDoc
      attr_accessor :tipo_dte, :folio, :fch_emis, :ind_servicio, :ind_mnt_neto,
                    :periodo_desde, :periodo_hasta, :fch_venc

      def initialize(params = {})
        @tipo_dte = /^39|41$/ =~ params[:tipo_dte].to_s ? params[:tipo_dte].to_s : '39'
        @folio = params[:folio] || 0
        @fch_emis = format_date(params[:fch_emis])
        @ind_servicio = params[:ind_servicio].to_s if /^[1-4]$/ =~ params[:ind_servicio].to_s
        @ind_mnt_neto = params[:ind_mnt_neto].to_s if /^[02]$/ =~ params[:ind_mnt_neto].to_s
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
