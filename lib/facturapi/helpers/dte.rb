module Facturapi
  module Helpers
    class Dte
      attr_accessor :encabezado, :detalle, :dsc_rcg_global, :referencia, :id

      def initialize(params = {})
        @encabezado = params[:encabezado]
        self.detalle = params[:detalle]
        self.dsc_rcg_global = params[:dsc_rcg_global]
        self.referencia = params[:referencia]
      end

      def detalle=(detalle)
        @detalle = @detalle.nil? ? [] : @detalle
        @detalle =
          if detalle.is_a?(Array)
            @detalle.push(*detalle)
          else
            @detalle.push(detalle)
          end
      end

      def dsc_rcg_global=(dsc_rcg_global)
        @dsc_rcg_global = @dsc_rcg_global.nil? ? [] : @dsc_rcg_global
        @dsc_rcg_global =
          if dsc_rcg_global.is_a?(Array)
            @dsc_rcg_global.push(*dsc_rcg_global)
          else
            @dsc_rcg_global.push(dsc_rcg_global)
          end
      end

      def referencia=(referencia)
        @referencia = @referencia.nil? ? [] : @referencia
        @referencia =
          if referencia.is_a?(Array)
            @referencia.push(*referencia)
          else
            @referencia.push(referencia)
          end
      end

      def totales
        encabezado.totales
      end

      def as_node
        doc = XML::Document.new
        param = { 'ID' => id } unless id.blank?
        doc.root = create_node('DTE', version: '1.0') do |dte|
          dte << create_node('Documento', param) do |documento|
            documento << encabezado.as_node
            detalle.each { |d| documento << d.as_node }
            dsc_rcg_global.each { |d| documento << d.as_node } if dsc_rcg_global && dsc_rcg_global.any?
            referencia.each { |r| documento << r.as_node } if referencia && referencia.any?
          end
        end
        doc
      end

      def autocomplete!
        mnt_neto = 0
        mnt_exe = 0
        monto_nf = 0
        detalle.each_with_index do |det, idx|
          det.nro_lin_det = idx + 1 if det.nro_lin_det.blank?
          det.autocomplete!
          mnt_neto += det.monto_item if det.afecto_iva?
          mnt_exe += det.monto_item if det.exento_iva?
          monto_nf += det.monto_item if det.no_fact? || det.no_fact_neg?
        end
        if dsc_rcg_global && dsc_rcg_global.any?
          dsc_rcg_global.each_with_index do |drg, idx|
            drg.nro_lin_dr = idx + 1 if drg.nro_lin_dr.blank?
            if drg.descuento?
              mnt_neto -= drg.valor_dr
            else
              mnt_neto += drg.valor_dr
            end
          end
        end
        if referencia && referencia.any?
          referencia.each_with_index do |ref, idx|
            ref.nro_lin_ref = idx + 1 if ref.nro_lin_ref.blank?
          end
        end
        totales.autocomplete!(
          is_monto_neto: encabezado.id_doc.monto_neto?,
          mnt_neto: mnt_neto,
          mnt_exe: mnt_exe,
          monto_nf: monto_nf
        )
        self
      end
    end
  end
end
