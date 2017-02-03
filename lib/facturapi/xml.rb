require 'xml'

module Facturapi
  module Xml
    def create_node(name, attributes = nil)
      node = XML::Node.new(name)

      if attributes
        attributes.each do |k, v|
          XML::Attr.new(node, k.to_s, v)
        end
      end
      yield(node) if block_given?
      node
    end
  end
end
