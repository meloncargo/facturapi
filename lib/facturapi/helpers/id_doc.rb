module Facturapi
  module Helpers
    class IdDoc
      attr_accessor :tipo_dte, :folio, :fch_emis, :ind_servicio, :ind_mnt_neto,
                    :periodo_desde, :periodo_hasta, :fch_venc

      def initialize(params = {})
        @tipo_dte = params[:tipo_dte]
        @folio = params[:folio]
        @fch_emis = params[:fch_emis]
        @ind_servicio = params[:ind_servicio]
        @ind_mnt_neto = params[:ind_mnt_neto]
        @periodo_desde = params[:periodo_desde]
        @periodo_hasta = params[:periodo_hasta]
        @fch_venc = params[:fch_venc]
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
    end
  end
end
