module BBC
  module Radio1
    class Artist

      attr_reader :name, :id, :releases, :links, :reviews, :image_url, :related_artists

      def self.find(id)
        RestClient.get("http://www.bbc.co.uk/music/artists/#{id}.json") do |r|
          response = JSON.parse(r)
          new(response['artist'])
        end
      end

      def initialize(params)
        populate_from params
      end

      def get_details
        unless @details_retreived
          RestClient.get("http://www.bbc.co.uk/music/artists/#{id}.json") do |r|
            response = JSON.parse(r)
            populate_from response['artist']
            @details_retreived = true
          end
        end
      end

      private

      def populate_from(params)
        @name = params['name']
        @id = params['gid']
        @releases = Array.wrap(params['releases']).map { |release| BBC::Radio1::Release.new(release) }
        @links = Array.wrap(params['links']).map { |link| BBC::Radio1::Link.new(link) }
        @related_artists = Array.wrap(params['related_artists']).map { |artist| BBC::Radio1::Artist.new(artist['artist'])}
        @image_url = params['image'] ? params['image']['src'] : nil
      end
    end
  end
end