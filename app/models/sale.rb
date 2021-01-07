class Sale < ActiveRecord::Base
  
  def finished?
    self.ends_on < Date.current
  end

  def upcoming?
    self.starts_on > Date.current
  end

  def active?
    !self.upcoming? && !self.finished?
  end

end
