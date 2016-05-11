class Register

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Enum

  field :register, type: String
  field :registry, type: String
  field :text, type: String

  enum :phase, %i[proposed prospect discovery alpha beta live]

  index({ register: 1 }, unique: true, name: 'register_index')

  validates :register, presence: true
  validates :phase, presence: true

end
