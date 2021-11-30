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

    let(:people) { People.new(dollar_format, percent_format, :first_name) }

  describe '.call' do
    it 'calls Parser and  the merged array of hash of parsed dollar and percent format' do
        parsed_result = double
        expect(Parser).to receive(:call).with(dollar_format, percent_format).and_return(parsed_result)
        expect(Agregator).to receive(:call).with(parsed_result, :first_name)

        people.call
    end
  end
end