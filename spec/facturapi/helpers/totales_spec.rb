require 'spec_helper'

describe Facturapi::Helpers::Totales do
  let(:totales) { Facturapi::Helpers::Totales.new }

  describe '.autocomplete!' do
    context 'with net prices' do
      before { totales.autocomplete!(is_monto_neto: true, mnt_neto: 100) }

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
      before { totales.autocomplete!(is_monto_neto: false, mnt_neto: 100) }

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
