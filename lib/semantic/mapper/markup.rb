module Semantic
  module Mapper
    class Markup
      SELECTOR = '[data-mapping]'

      def initialize(html)
        @html = html
      end

      def map
        document.css(SELECTOR).each_with_object(HashWithIndifferentAccess.new) do |element,hash|
          fields(element).each { |key| hash[key] = attribute_value(element, 'name') }
        end
      end

      private
      def fields(element)
        attribute_value(element, 'data-mapping').split(" ")
      end  

      def document
        @document ||= Nokogiri::HTML(@html)
      end

      def attribute_value(element, attribute_name)
        element.attributes[attribute_name].try(:value)
      end
    end
  end
end

