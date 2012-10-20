require_relative '../keyvalidatable'

class Hash

  include KeyValidatable

end

class Struct

  include KeyValidatable

end