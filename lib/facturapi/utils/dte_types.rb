require 'i18n'

module Facturapi
  module Utils
    module DteTypes
      DOCUMENTS = {
        30 => :factura,
        32 => :factura_ex,
        33 => :factura_elec,
        34 => :factura_ex_elec,
        35 => :boleta,
        38 => :boleta_ex,
        39 => :boleta_elec,
        40 => :liq_factura,
        41 => :boleta_ex_elec,
        43 => :liq_factura_elec,
        45 => :factura_compra,
        46 => :factura_compra_elec,
        50 => :guia_despacho,
        52 => :guia_despacho_elec,
        55 => :nota_deb,
        56 => :nota_deb_elec,
        60 => :nota_cred,
        61 => :nota_cred_elec
      }.freeze

      def self.sym(dte_type)
        DOCUMENTS[dte_type]
      end

      def self.humanized(dte_type)
        I18n.t "facturapi.dte_type.#{sym(dte_type)}"
      end
    end
  end
end
