require 'helper'

class SongTest < Test::Unit::TestCase
  include WebMock

  context "find an artist by id" do
    setup do
      stub_request(:any, /bbc.co.uk/).
        to_return(:body => %Q({"artist":{"label_positions":[],"name":"Tame Impala","releases":[{"name":"Solitude Is Bliss","release_year":2010,"release_type":"EP","release_status":"Official"},{"name":"Innerspeaker","release_year":2010,"release_type":"Album","release_status":"Official"},{"name":"Sundown Syndrome","release_year":2009,"release_type":"Single","release_status":"Official"},{"name":"Tame Impala","release_year":2008,"release_type":"EP","release_status":"Official"}],"gid":"63aa26c3-d59b-4da4-84ac-716b54f1ef4d","sort_name":"Tame Impala","played_on":{"programmes":{"programme":{"plays":1,"pid":"b00slvl3","title":"Tom Ravenscroft","service_key":"6music"}},"services":{"service":{"plays":1,"title":"BBC Radio 2","key":"radio2"}}},"wikipedia_article":{"title":"Tame Impala","updated_at":"2010-08-05T23:01:22+01:00","word_count":13,"url":"http://en.wikipedia.org/wiki/Tame_Impala","content":"Tame Impala are a four piece psychedelic rock band from Perth, Western Australia."},"related_artists":[],"begin_date":null,"links":[{"name":"tameimpala.com","url":"http://www.tameimpala.com","type":"official homepage"},{"name":"Tame Impala","url":"http://en.wikipedia.org/wiki/Tame_Impala","type":"wikipedia"}],"reviews":[],"artist_type":"Group","news":[{"title":"Web shows hottest music on BBC","url":"http://musictrends.prototyping.bbc.co.uk/","description":"A new trending website shows off the most popular music across the BBC.","date_published":"2010-05-13T18:00:02+01:00","source":{"title":"Local music news from BBC Introducing in Shropshire","url":"http://newsrss.bbc.co.uk/rss/local/shropshire/people_and_places/music/rss.xml"}}],"credits":[],"image":{"src":null},"end_date":null,"disambiguation":null}}))
    end

    should "make a request to the bbc api" do
      BBC::Radio1::Artist.find(1)
      assert_requested :get, "http://www.bbc.co.uk/music/artists/1.json", :times => 1
    end

    should "return one BBC::Radio1::Artist" do
      assert_instance_of BBC::Radio1::Artist, BBC::Radio1::Artist.find(1)
    end
  end

  context "extra information related to this artist" do
    setup do
      stub_request(:any, /bbc.co.uk/).
        to_return(:body => %Q({"artist":{"label_positions":[],"name":"Tame Impala","releases":[{"name":"Solitude Is Bliss","release_year":2010,"release_type":"EP","release_status":"Official"},{"name":"Innerspeaker","release_year":2010,"release_type":"Album","release_status":"Official"},{"name":"Sundown Syndrome","release_year":2009,"release_type":"Single","release_status":"Official"},{"name":"Tame Impala","release_year":2008,"release_type":"EP","release_status":"Official"}],"gid":"63aa26c3-d59b-4da4-84ac-716b54f1ef4d","sort_name":"Tame Impala","played_on":{"programmes":{"programme":{"plays":1,"pid":"b00slvl3","title":"Tom Ravenscroft","service_key":"6music"}},"services":{"service":{"plays":1,"title":"BBC Radio 2","key":"radio2"}}},"wikipedia_article":{"title":"Tame Impala","updated_at":"2010-08-05T23:01:22+01:00","word_count":13,"url":"http://en.wikipedia.org/wiki/Tame_Impala","content":"Tame Impala are a four piece psychedelic rock band from Perth, Western Australia."},"related_artists":[],"begin_date":null,"links":[{"name":"tameimpala.com","url":"http://www.tameimpala.com","type":"official homepage"},{"name":"Tame Impala","url":"http://en.wikipedia.org/wiki/Tame_Impala","type":"wikipedia"}],"reviews":[],"artist_type":"Group","news":[{"title":"Web shows hottest music on BBC","url":"http://musictrends.prototyping.bbc.co.uk/","description":"A new trending website shows off the most popular music across the BBC.","date_published":"2010-05-13T18:00:02+01:00","source":{"title":"Local music news from BBC Introducing in Shropshire","url":"http://newsrss.bbc.co.uk/rss/local/shropshire/people_and_places/music/rss.xml"}}],"credits":[],"image":{"src":null},"end_date":null,"disambiguation":null}}))

      @artist = BBC::Radio1::Artist.find(1)
    end

    should "return releases by this artist" do
      releases = @artist.releases
      assert_instance_of Array, releases
      assert_instance_of BBC::Radio1::Release, releases.first
    end

    should "return relevant links for this artist" do
      links = @artist.links
      assert_instance_of Array, links
      assert_instance_of BBC::Radio1::Link, links.first
    end

    should "return artists related to this artist" do
      artists = @artist.related_artists
      assert_instance_of Array, artists
      # assert_instance_of BBC::Radio1::Artist, artists.first
    end
  end

  context "getting an artists details from the api" do
    setup do
      @artist = BBC::Radio1::Artist.new('name' => 'The Beatles', 'gid' => 1)
      stub_request(:any, /bbc.co.uk/).
        to_return(:body => %Q({"artist":{"label_positions":[],"name":"Tame Impala","releases":[{"name":"Solitude Is Bliss","release_year":2010,"release_type":"EP","release_status":"Official"},{"name":"Innerspeaker","release_year":2010,"release_type":"Album","release_status":"Official"},{"name":"Sundown Syndrome","release_year":2009,"release_type":"Single","release_status":"Official"},{"name":"Tame Impala","release_year":2008,"release_type":"EP","release_status":"Official"}],"gid":"63aa26c3-d59b-4da4-84ac-716b54f1ef4d","sort_name":"Tame Impala","played_on":{"programmes":{"programme":{"plays":1,"pid":"b00slvl3","title":"Tom Ravenscroft","service_key":"6music"}},"services":{"service":{"plays":1,"title":"BBC Radio 2","key":"radio2"}}},"wikipedia_article":{"title":"Tame Impala","updated_at":"2010-08-05T23:01:22+01:00","word_count":13,"url":"http://en.wikipedia.org/wiki/Tame_Impala","content":"Tame Impala are a four piece psychedelic rock band from Perth, Western Australia."},"related_artists":[],"begin_date":null,"links":[{"name":"tameimpala.com","url":"http://www.tameimpala.com","type":"official homepage"},{"name":"Tame Impala","url":"http://en.wikipedia.org/wiki/Tame_Impala","type":"wikipedia"}],"reviews":[],"artist_type":"Group","news":[{"title":"Web shows hottest music on BBC","url":"http://musictrends.prototyping.bbc.co.uk/","description":"A new trending website shows off the most popular music across the BBC.","date_published":"2010-05-13T18:00:02+01:00","source":{"title":"Local music news from BBC Introducing in Shropshire","url":"http://newsrss.bbc.co.uk/rss/local/shropshire/people_and_places/music/rss.xml"}}],"credits":[],"image":{"src":null},"end_date":null,"disambiguation":null}}))
    end

    should "populate all the relevant information for this artist" do
      assert @artist.releases.empty?
      @artist.get_details
      assert !@artist.releases.empty?
    end

    should "make a request to the bbc api" do
      @artist.get_details
      assert_requested :get, "http://www.bbc.co.uk/music/artists/1.json", :times => 1
    end

    should "only make a request to the bbc api once" do
      @artist.get_details
      @artist.get_details
      assert_requested :get, "http://www.bbc.co.uk/music/artists/1.json", :times => 1      
    end
  end
end