require 'spec_helper'

RSpec.describe 'Service::Agregator' do
    let(:records) do
        [
            {"birthdate"=>"4/30/1974", "city"=>"Los Angeles", "first_name"=>"Rhiannon", "last_name"=>"Nolan"},
            {"birthdate"=>"5/29/1986", "city"=>"Atlanta", "first_name"=>"Mckayla"},
            {"birthdate"=>"5/4/1947", "city"=>"New York City", "first_name"=>"Elliot"}
        ]
    end

    let(:agregator) { Agregator.new(records, :first_name) }

  describe '.call' do
    it 'returns an array of parsed data sorted by order parameter' do
        result = agregator.call

        expect(result).to eq([
            'Elliot, New York City, 5/4/1947',
            'Mckayla, Atlanta, 5/29/1986',
            'Rhiannon, Los Angeles, 4/30/1974'
        ])
    end
  end
end
