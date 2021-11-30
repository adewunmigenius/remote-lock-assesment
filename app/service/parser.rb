class Parser < ApplicationService
    def initialize(dollar, percentage)
        @dollar = dollar
        @percentage = percentage
    end

    def call
        dollar_array = parse_data(dollar, "$")
        percentage_array = parse_data(percentage, "%")
        dollar_array.concat(percentage_array)
    end

    private

    def parse_data(people_data, format)
        data = people_data.split("\n")
        header = data.first.split(format)
        
        data[1...].map do |x|
            result = {}
            k = x.split(format)
            k.each_with_index.map do |y, i|
                key = header[i].strip
                value = k[i].strip!
                
                value = case key
                when "birthdate" then parse_date(value)
                when "city" then parse_city(value)
                else value
                end

                result.merge!({key => value})
            end
            result
        end
    end

    def parse_date(data)
        Date.parse(data).strftime("%-m/%-d/%Y")
    end


    def parse_city(abv)
        cities = {"LA" => "Los Angeles", "NYC" => "New York City"} #include more cities
        return abv unless cities.keys.include?(abv)
        cities[abv]
    end

    attr_reader :dollar, :percentage
end
