require 'spec_helper'

describe Facturapi::Helpers::Totales do
  let(:totales) { Facturapi::Helpers::Totales.new }
  let(:id_doc) { Facturapi::Helpers::IdDoc.new(ind_mnt_neto: ind_mnt_neto, tipo_dte: 39) }
  let(:ind_mnt_neto) { 2 }

  describe '.autocomplete!' do
    before { totales.autocomplete!(id_doc: id_doc, mnt_neto: 100) }

    context 'with net prices' do
      it 'returns the assigned net price' do
        expect(totales.mnt_neto).to eq(100)
      end

      it 'returns the IVA (VAT) of the net price' do
        expect(totales.iva).to eq(19)
      end

      it 'returns the total price' do
        expect(totales.mnt_total).to eq(119)
      end
    end

    context 'with final prices' do
      let(:ind_mnt_neto) { 0 }

      it 'returns the assigned net price' do
        expect(totales.mnt_neto).to be_nil
      end

      it 'returns the IVA (VAT) of the net price' do
        expect(totales.iva).to be_nil
      end

      it 'returns the total price' do
        expect(totales.mnt_total).to eq(100)
      end
    end
  end
end
