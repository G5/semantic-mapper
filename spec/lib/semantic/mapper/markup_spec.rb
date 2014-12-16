require 'spec_helper'

describe Semantic::Mapper::Markup do
  let(:markup) { Semantic::Mapper::Markup.new(html) }
  let(:html) { fixture('reservation.html') }

  describe :map do
    context 'nested mapping' do
      subject { markup.map[:customer] }
      its([:first_name]) { is_expected.to eq('p-first-name') }
      its([:last_name]) { is_expected.to eq('p-last-name') }
      its([:address1]) { is_expected.to eq('p-address1') }
      its([:billing_address]) { is_expected.to eq('p-address1') }

      it 'maps 3 levels deeps' do
        expect(subject[:street_address][:city]).to eq('p-city')
        expect(subject[:street_address][:region]).to eq('p-state')
      end
    end
    context 'top level attributes' do
      subject { markup.map }
      its([:message]) { is_expected.to eq('e-content') }
      its([:storage_unit_external_id]) { is_expected.to eq('p-storage-unit-external-id') }
      its([:rental_rate]) { is_expected.to eq('p-rental-rate') }
      its([:reservation_date]) { is_expected.to eq('p-reservation-date') }
      its([:time_zone]) { is_expected.to eq('p-time-zone') }
    end
  end

  describe :map_hash do
    [{value: 3, keys: %w(whatever foo), expected: {"whatever" => {"foo" => 3}}},
     {value: 'semantic', keys: %w(customer address street1), expected: {"customer" => {"address" => {"street1" => "semantic"}}}},
     {value: 'mapper', keys: ['jimmy'], expected: {"jimmy" => "mapper"}}
    ].each do |test_hash|
      it "should map hash with value #{test_hash[:value]} and keys #{test_hash[:keys]} to #{test_hash[:expected]}" do
        markup.send(:map_hash, test_hash[:value], test_hash[:keys])
        expect(markup.mapped_hash).to eq(test_hash[:expected])
      end
    end
  end

  describe :build_keys do
    [{data_mapping: 'jimmy[walker]', expected: %w(jimmy walker)},
     {data_mapping: 'jimmy[walker][foo]', expected: %w(jimmy walker foo)},
     {data_mapping: 'jimmy', expected: %w(jimmy)}
    ].each do |test_hash|
      it "should build #{test_hash[:expected]} from #{test_hash[:data_mapping]}" do
        expect(markup.send(:build_keys, test_hash[:data_mapping])).to eq(test_hash[:expected])
      end
    end
  end
end