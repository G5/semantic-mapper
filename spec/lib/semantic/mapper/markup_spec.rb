require 'spec_helper'

describe Semantic::Mapper::Markup do
  let(:markup) { Semantic::Mapper::Markup.new(html) }
  let(:html) { fixture('reservation.html') }

  describe :map do
    subject { markup.map }
    it "maps attributes" do
      expect(subject[:customer][:first_name]).to eq('p-first-name')
      expect(subject[:customer][:last_name]).to eq('p-last-name')
      expect(subject[:address1]).to eq('p-address1')
      expect(subject[:billing_address]).to eq('p-address1')
      expect(subject[:customer][:street_address][:city]).to eq('p-city')
      expect(subject[:customer][:street_address][:region]).to eq('p-state')
      expect(subject[:credit_card_type]).to eq('p-card-type')
      expect(subject[:credit_card_exp_month]).to eq('p-card-exp-month')
      expect(subject[:message]).to eq('e-content')
      expect(subject[:storage_unit_external_id]).to eq('p-storage-unit-external-id')
      expect(subject[:rental_rate]).to eq('p-rental-rate')
      expect(subject[:reservation_date]).to eq('p-reservation-date')
      expect(subject[:time_zone]).to eq('p-time-zone')
    end
  end
end