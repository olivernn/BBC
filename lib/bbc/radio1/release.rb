module BBC
  module Radio1
    class Release

      attr_reader :name, :year, :type, :status

      def initialize(params)
        @name = params['name']
        @year = params['release_year']
        @type = params['release_type']
        @status = params['official']
      end
    end
  end
end