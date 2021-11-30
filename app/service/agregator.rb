class Agregator < ApplicationService
    def initialize(people, order)
        @people = people
        @order = order
    end

    def call
        order_and_aggregate_data(people)
    end

    private

    def order_and_aggregate_data(data)
        data.sort_by {|x| x[order.to_s] }
            .map do |data|
                "#{data["first_name"]}, #{data["city"]}, #{data["birthdate"]}"
            end
    end

    attr_reader :people, :order
end
