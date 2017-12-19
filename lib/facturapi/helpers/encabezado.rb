module Facturapi
  module Helpers
    class Encabezado
      include Facturapi::Xml

      attr_accessor :id_doc, :emisor, :receptor, :totales

      def initialize(params = {})
        @id_doc = params[:id_doc]
        @emisor = params[:emisor]
        @receptor = params[:receptor]
        @totales = params[:totales] || Totales.new
      end

      def as_node
        create_node('Encabezado') do |encabezado|
          encabezado << id_doc.as_node
          encabezado << emisor.as_node
          encabezado << receptor.as_node
          encabezado << totales.as_node
        end
      end
    end
  end
end
