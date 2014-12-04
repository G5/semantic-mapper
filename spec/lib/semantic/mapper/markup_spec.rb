require 'spec_helper'

describe Semantic::Mapper::Markup do
  let(:markup) { Semantic::Mapper::Markup.new(html) }
  let(:html) { fixture('reservation.html') }

  describe :map do
    subject { markup.map }

    its([:first_name]) { is_expected.to eq('p-first-name') }
    its([:last_name]) { is_expected.to eq('p-last-name') }
    its([:credit_card_type]) { is_expected.to eq('p-card-type') }
    its([:credit_card_exp_month]) { is_expected.to eq('p-card-exp-month') }
    its([:message]) { is_expected.to eq('e-content') }
    its([:storage_unit_external_id]) { is_expected.to eq('p-storage-unit-external-id') }
    its([:rental_rate]) { is_expected.to eq('p-rental-rate') }
    its([:reservation_date]) { is_expected.to eq('p-reservation-date') }
    its([:time_zone]) { is_expected.to eq('p-time-zone') }
  end
end