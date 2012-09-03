require_relative 'requirements'

class Hash

  include KeyValidatable

end

class Struct

  include KeyValidatable

end