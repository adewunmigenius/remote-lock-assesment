class PeopleController
  def initialize(params)
    @params = params
  end

  def normalize
    People.call(
      params[:dollar_format], 
      params[:percent_format], 
      params[:order]
      )
  end

  private

  attr_reader :params
end
