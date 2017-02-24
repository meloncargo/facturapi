require 'spec_helper'

describe Facturapi::Helpers::Detalle do
  let(:detalle) { Facturapi::Helpers::Detalle.new(qty_item: 2, prc_item: 100) }

  describe '.autocomplete!' do
    before { detalle.autocomplete! }

    it 'returns the quantity multiplied by the price' do
      expect(detalle.monto_item).to eq(200)
    end
  end
end
