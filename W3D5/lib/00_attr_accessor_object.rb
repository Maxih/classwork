class AttrAccessorObject
  def self.my_attr_accessor(*names)

    names.each do |ivar|
      define_method("#{ivar}") { instance_variable_get("@#{ivar}") }
      define_method("#{ivar}=") { |val| instance_variable_set("@#{ivar}", val) }
    end
  end
end
