class Contact
  include ActiveModel::Conversion
  include ActiveModel::Validations
  extend ActiveModel::Naming
  extend ActiveModel::Translation

  def persisted?
    false
  end

  @@attributes = []

  def initialize(attributes = {})
    @attributes = attributes
    @attributes.each do |key, value|
      method_name = "#{key}="
      send(method_name, value) if self.class.method_defined?(method_name)
    end
  end

  ATTRIBUTES = [
    :name,
    :email,
    :content
  ]

  ATTRIBUTES.each {|attr| attr_accessor attr }
  @@attributes += ATTRIBUTES

  validates :name, presence: true
  validates :email, presence: true, email_format: {if: ->(this) { this.email.present? }}
end
