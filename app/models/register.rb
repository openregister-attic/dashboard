class Register

  include Mongoid::Document
  include Mongoid::Timestamps

  PHASES = %w[proposed prospect discovery alpha beta live].freeze unless defined? PHASE

  field :register, type: String
  field :registry, type: String
  field :text, type: String
  field :phase, type: String, default: PHASES.first

  index({ register: 1 }, unique: true, name: 'register_index')

  validates :register, presence: true
  validates_uniqueness_of :register
  validates_inclusion_of :phase, in: PHASES, allow_blank: false

  before_validation :parameterize_register_name

  private

  def parameterize_register_name
    self.register = register.parameterize if register.present?
  end

end
