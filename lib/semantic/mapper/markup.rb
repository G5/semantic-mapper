module Semantic
  module Mapper
    class Markup
      SELECTOR = '[data-mapping]'

      def initialize(html)
        @html = html
        @mapped_hash = HashWithIndifferentAccess.new
      end

      def map
        document.css(SELECTOR).each do |element|
          fields(element).each do |key| 
            final_attribute_value = attribute_value(element, 'name')
            keys = key.scan(/([\w-]+)|\[([\w-]+?)\]/).flatten.compact
            map_hash(final_attribute_value, keys)
          end 
        end
        @mapped_hash
      end

      private

      def map_hash(value, keys)
        merge_or_set(keys[0], value) and return if keys.length == 1 
        current_key = keys.pop
        value = HashWithIndifferentAccess.new(current_key => value)
        map_hash(value, keys)
      end  

      def merge_or_set(key, value)
        if @mapped_hash.has_key?(key)
          @mapped_hash[key].deep_merge!(value)
        else  
          @mapped_hash[key] = value
        end
      end    

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

