require 'facturapi/helpers/detalle'
require 'facturapi/helpers/dsc_rcg_global'
require 'facturapi/helpers/descuento_global'
require 'facturapi/helpers/recargo_global'
require 'facturapi/helpers/dte'
require 'facturapi/helpers/emisor'
require 'facturapi/helpers/encabezado'
require 'facturapi/helpers/id_doc'
require 'facturapi/helpers/receptor'
require 'facturapi/helpers/referencia'
require 'facturapi/helpers/totales'

module Facturapi
  module Helpers
    def format_date(date)
      return unless date && date.is_a?(ActiveSupport::TimeWithZone) ||
                    date.is_a?(Date)
      date.strftime('%Y-%m-%d')
    end
  end
end
