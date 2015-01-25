module Eldr
  module Rendering
    module Output
      def capture_html(*args, &block)
        yield(*args)
      end
      alias :capture :capture_html
    end
  end
end
