module BBC
  module Radio1
    class Song

      NOW_PLAYING_API = "http://www.bbc.co.uk/radio1/nowplaying/latest.json"

      attr_reader :artist_gid, :artist, :title

      def self.playing_now
        RestClient.get(NOW_PLAYING_API) do |response|
          new(JSON.parse(response)['nowplaying'].first)
        end
      end

      def self.played_recently
        RestClient.get(NOW_PLAYING_API) do |response|
          JSON.parse(response)['nowplaying'].slice(1, 6).map { |song| new(song) }
        end
      end

      def initialize(params)
        @artist_gid = params['artist_gid']
        @artist = params['artist']
        @title = params['title']
      end

    end
  end
end