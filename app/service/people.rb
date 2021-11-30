class People < ApplicationService
    def initialize(dollar_format, percent_format, order)
        @dollar_format = dollar_format
        @percent_format = percent_format
        @order = order
    end

    def call
        records = Parser.call(dollar_format, percent_format)
        Agregator.call(records, order)
    end

    attr_reader :dollar_format, :percent_format, :order
end
