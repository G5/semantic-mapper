module Semantic
  module Mapper
    class Markup
      SELECTOR = '[data-mapping]'

      def initialize(html)
        @html = html
      end

      def map
        document.css(SELECTOR).inject({}) do |hash, element|
          hash[attribute_value(element, 'data-mapping')] = attribute_value(element, 'name')
          hash
        end.with_indifferent_access
      end

      private
      def document
        @document ||= Nokogiri::HTML(@html)
      end

      def attribute_value(element, attribute_name)
        element.attributes[attribute_name].try(:value)
      end
    end
  end
end

