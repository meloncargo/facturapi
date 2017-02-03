module Facturapi
  module Helpers
    class Dte
      attr_accessor :encabezado, :detalle, :dsc_rcg_global, :referencia

      def initialize(params = {})
        @encabezado = params[:encabezado]
        self.detalle = params[:detalle]
        self.dsc_rcg_global = params[:dsc_rcg_global]
        self.referencia = params[:referencia]
      end

      def detalle=(detalle)
        @detalle = @detalle.nil? ? [] : @detalle
        @detalle =
          if @detalle.is_a?(Array)
            @detalle.push(*detalle)
          else
            @detalle.push(detalle)
          end
      end

      def dsc_rcg_global=(dsc_rcg_global)
        @dsc_rcg_global = @dsc_rcg_global.nil? ? [] : @dsc_rcg_global
        @dsc_rcg_global =
          if @dsc_rcg_global.is_a?(Array)
            @dsc_rcg_global.push(*dsc_rcg_global)
          else
            @dsc_rcg_global.push(dsc_rcg_global)
          end
      end

      def referencia=(referencia)
        @referencia = @referencia.nil? ? [] : @referencia
        @referencia =
          if @referencia.is_a?(Array)
            @referencia.push(*referencia)
          else
            @referencia.push(referencia)
          end
      end

      def as_node
        doc = XML::Document.new
        doc.root = create_node('DTE', version: '1.0') do |dte|
          dte << create_node('Documento', 'ID' => 'F100T39') do |documento|
            documento << encabezado.as_node
            detalle.each { |d| documento << d.as_node }
            dsc_rcg_global.each { |d| documento << d.as_node }
            referencia.each { |r| documento << r.as_node }
          end
        end
        doc
      end
    end
  end
end
