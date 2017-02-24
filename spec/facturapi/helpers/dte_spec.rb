require 'spec_helper'

describe Facturapi::Helpers::Dte do
  let(:id_doc) { Facturapi::Helpers::IdDoc.new(tipo_dte: 39, ind_mnt_neto: 0) }
  let(:encabezado) { Facturapi::Helpers::Encabezado.new(id_doc: id_doc) }
  let(:detalle1) { Facturapi::Helpers::Detalle.new(qty_item: 1, prc_item: 300) }
  let(:detalle2) { Facturapi::Helpers::Detalle.new(qty_item: 2, prc_item: 100) }
  let(:dte) do
    Facturapi::Helpers::Dte.new(
      encabezado: encabezado, detalle: [detalle1, detalle2]
    )
  end

  describe '.autocomplete!' do
    before { dte.autocomplete! }

    it 'returns the sum of detail quantity multiplied by the price' do
      expect(encabezado.totales.mnt_neto).to eq(500)
    end

    it 'returns the IVA (VAT) of the net price' do
      expect(encabezado.totales.iva).to eq(95)
    end

    it 'returns the total price' do
      expect(encabezado.totales.mnt_total).to eq(595)
    end

    it 'returns the assigned line number for details' do
      expect(detalle1.nro_lin_det).to eq(1)
      expect(detalle2.nro_lin_det).to eq(2)
    end
  end
end
