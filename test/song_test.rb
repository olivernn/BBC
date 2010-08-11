require 'helper'

class SongTest < Test::Unit::TestCase
  include WebMock

  context "getting songs from the nowplaying api" do
    setup do
      stub_request(:any, /bbc.co.uk/).
        to_return(:body => %Q({"nowplaying":[{"artist":"Dam Mantle","title":"Broken Slumber (Live at Maida Vale)","artist_gid":"e8f3d655-52dd-44bb-a9d7-619b1d21ee15"},{"artist":"We're Only Afraid of NYC","title":"It's Tidal","artist_gid":"8e3482ad-c888-4cef-9d57-29ff881bdba6"},{"artist":"Brontide","title":"Huw not Q Menu into Bob Mundo","artist_gid":"2179fbd2-3c88-4b94-a778-eb3daf1e81a1"},{"artist":"Skream","title":"Listening to The Records on My Wall","artist_gid":"fb5ee67e-e31a-40cf-8b06-5f1a0f53529a"},{"artist":"Tensnake","title":"Coma Cat","artist_gid":"1310615d-0222-4e59-876d-e7d263f7e1ea"}]}))
    end

    context "getting the song currently playing" do
      should "make a request to the bbc api" do
        BBC::Radio1::Song.playing_now
        assert_requested :get, "http://www.bbc.co.uk/radio1/nowplaying/latest.json", :times => 1
      end

      should "return one BBC::Radio1::Song" do
        assert_instance_of BBC::Radio1::Song, BBC::Radio1::Song.playing_now
      end
    end

    context "getting the recently played songs" do
      should "make a request to the bbc api" do
        BBC::Radio1::Song.played_recently
        assert_requested :get, "http://www.bbc.co.uk/radio1/nowplaying/latest.json", :times => 1
      end

      should "return an array of BBC::Radio1::Songs" do
        songs = BBC::Radio1::Song.played_recently
        assert_instance_of Array, songs
        assert_instance_of BBC::Radio1::Song, songs.first
      end
    end

  end
end