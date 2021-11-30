require 'spec_helper'

RSpec.describe 'Service::Parser' do
    let(:dollar_format) do
        "city $ birthdate $ last_name $ first_name
        LA $ 30-4-1974 $ Nolan $ Rhiannon
        NYC $ 5-1-1962 $ Bruen $ Rigoberto"
    end

    let(:percent_format) do
        "first_name % city % birthdate
        Mckayla % Atlanta % 1986-05-29
        Elliot % New York City % 1947-05-04"
    end

    let(:parser) { Parser.new(dollar_format, percent_format) }

  describe '.call' do
    it 'returns the merged array of hash of parsed dollar and percent format' do
        result = parser.call
        expect(result).to eq(
            [
                {"birthdate"=>"4/30/1974", "city"=>"Los Angeles", "first_name"=>"Rhiannon", "last_name"=>"Nolan"},
                {"birthdate"=>"1/5/1962", "city"=>"New York City", "first_name"=>"Rigoberto", "last_name"=>"Bruen"},
                {"birthdate"=>"5/29/1986", "city"=>"Atlanta", "first_name"=>"Mckayla"},
                {"birthdate"=>"5/4/1947", "city"=>"New York City", "first_name"=>"Elliot"}
              ])
    end
  end

  describe '.parse_data' do
    it 'parses input data, split with the format and return an array of hash' do
      result = parser.send(:parse_data, dollar_format, "$")

      expect(result).to eq(
            [
                {"birthdate"=>"4/30/1974", "city"=>"Los Angeles", "first_name"=>"Rhiannon", "last_name"=>"Nolan"},
                {"birthdate"=>"1/5/1962","city"=>"New York City", "first_name"=>"Rigoberto","last_name"=>"Bruen"}
            ])
    end
  end

  describe '.parse_date' do
    it 'format date to m/d/Y' do
        result = parser.send(:parse_date, "2021-05-23")

        expect(result).to eq("5/23/2021")
    end
  end

  describe '.parse_city' do
    context 'when the abrevated is included in cities hash' do
        it 'parse city' do
            result = parser.send(:parse_city, "LA")

            expect(result).to eq("Los Angeles")
        end
    end
    context 'when the abrevated is not included in cities hash' do
        it 'does nothing' do
            result = parser.send(:parse_city, "Atlanta")

            expect(result).to eq("Atlanta")
        end
    end
  end
end
