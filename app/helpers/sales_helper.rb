module SalesHelper

  def active_sale
    @sale = Sale.active
    if @sale.length > 0 
      @sale = @sale.first
      return true
    end
    return false
  end

end