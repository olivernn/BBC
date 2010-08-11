module BBC
  module Radio1
    class Link

      attr_reader :name, :url, :type

      def initialize(params)
        @name = params['name']
        @url = params['url']
        @type = params['type']
      end
    end
  end
end