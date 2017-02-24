require 'spec_helper'

describe Facturapi::Utils::DteTypes do
  let(:dte_types) { Facturapi::Utils::DteTypes }
  let(:dte_type) { 30 }

  describe '#sym' do
    subject { dte_types.sym(dte_type) }

    it { is_expected.to eq(:factura) }
  end

  describe '#humanized' do
    subject { dte_types.humanized(dte_type) }

    it { is_expected.to eq('Factura') }
  end
end
