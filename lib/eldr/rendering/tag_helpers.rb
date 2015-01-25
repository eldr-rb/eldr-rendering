require 'active_support/core_ext/string/output_safety'
require 'active_support/core_ext/string/inflections'

module Eldr
  module Rendering
    module Tags
      ESCAPE_VALUES = {
        '&' => '&amp;',
        '<' => '&lt;',
        '>' => '&gt;',
        '"' => '&quot;'
      }.freeze

      ESCAPE_REGEXP = Regexp.union(*ESCAPE_VALUES.keys).freeze

      BOOLEAN_ATTRIBUTES = [
        :autoplay,
        :autofocus,
        :formnovalidate,
        :checked,
        :disabled,
        :hidden,
        :loop,
        :multiple,
        :muted,
        :readonly,
        :required,
        :selected,
        :declare,
        :defer,
        :ismap,
        :itemscope,
        :noresize,
        :novalidate
      ].freeze

      DATA_ATTRIBUTES = [
        :method,
        :remote,
        :confirm
      ].freeze

      NEWLINE = "\n".html_safe.freeze

      def tag(name, options = nil, open = false)
        options = parse_data_options(name, options)
        attributes = tag_attributes(options)
        "<#{name}#{attributes}#{open ? '>' : ' />'}".html_safe
      end

      def content_tag(name, content = nil, options = nil, &block)
        if block_given?
          options = content if content.is_a?(Hash)
          content = capture_html(&block)
        end

        options    = parse_data_options(name, options)
        attributes = tag_attributes(options)
        output = ActiveSupport::SafeBuffer.new
        output.safe_concat "<#{name}#{attributes}>"
        if content.respond_to?(:each) && !content.is_a?(String)
          content.each { |item| output.concat item; output.safe_concat NEWLINE }
        else
          output.concat content.to_s
        end
        output.safe_concat "</#{name}>"

        output
      end

      private

      def tag_attributes(options)
        return '' unless options
        options.inject('') do |all, (key, value)|
          next all unless value
          all << ' ' if all.empty?
          all << if value.is_a?(Hash)
            nested_values(key, value)
          elsif BOOLEAN_ATTRIBUTES.include?(key)
            %(#{key}="#{key}" )
          else
            %(#{key}="#{escape_value(value)}" )
          end
        end.chomp!(' ')
      end

      def escape_value(string)
        string.to_s.gsub(ESCAPE_REGEXP) { |char| ESCAPE_VALUES[char] }
      end

      def nested_values(attribute, hash)
        hash.inject('') do |all, (key, value)|
          attribute_with_name = "#{attribute}-#{key.to_s.dasherize}"
          all << if value.is_a?(Hash)
            nested_values(attribute_with_name, value)
          else
            %(#{attribute_with_name}="#{escape_value(value)}" )
          end
        end
      end

      def parse_data_options(tag, options)
        return unless options
        parsed_options = options.dup
        options.each do |key, value|
          next if !DATA_ATTRIBUTES.include?(key) || (tag.to_s == 'form' && key == :method)
          parsed_options["data-#{key}"] = parsed_options.delete(key)
          parsed_options[:rel] = 'nofollow' if key == :method
        end
        parsed_options
      end
    end
  end
end
