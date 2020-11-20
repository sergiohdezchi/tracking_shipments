require 'rails_helper'

RSpec.describe Carrier::TrackingInfoFactory do
  describe 'Resolve tracking info for carrier' do
    context 'when carrier exists' do
      let(:carrier) { 'FEDEX' }
      let(:tracking_number) { '449044304137821' }

      it 'Should return status_code' do
        VCR.use_cassette 'carrier/tracking_info_factory/fedex/success' do
          tracking_info = described_class.create(carrier, tracking_number)
          expect(tracking_info.status_code.present?).to eq(true)
        end
      end
    end

    context 'When carrier not exists' do
      let(:carrier) { 'FEDEXS' }
      let(:tracking_number) { '449044304137821' }

      it 'Should return ArgumentError' do
        expect { described_class.create(carrier, tracking_number) }.to raise_error { |error|
          expect(error).to be_a(ArgumentError)
        }
      end
    end

    context 'When tracking_number not exists' do
      let(:carrier) { 'FEDEX' }
      let(:tracking_number) { '555555555555555' }

      it 'Should return status_code' do
        VCR.use_cassette 'carrier/tracking_info_factory/fedex/not_found' do
          tracking_info = described_class.create(carrier, tracking_number)
          expect(tracking_info.status_code).to eq(nil)
        end
      end
    end
  end
end
