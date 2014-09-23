class Contact
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :email
  attr_accessor :feedback
  def persisted?
    false
  end
end