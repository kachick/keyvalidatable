require_relative 'loader'

class Hash

  include KeyValidatable

end

class Struct

  include KeyValidatable

end