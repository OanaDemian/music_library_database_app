require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  before(:each) do 
    reset_albums_table
    reset_artists_table
  end

  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context "GET /albums" do
    xit "should return the list of albums" do
      response = get('/albums')
      expect(response.status).to eq (200)
      expect(response.body).to include('<a href="/albums/2"/Surfer Rosa</a>')
      expect(response.body).to include('<a href="/albums/3"/Waterloo</a>')
      expect(response.body).to include('<a href="/albums/4"/Super Trooper</a>')
      expect(response.body).to include('<a href="/albums/5"/Bossanova</a>')
    end
  end

  context "GET /albums/:id" do
    it "contains a h1 title" do
      response = get('/albums/1')
      first_response = "<h1>Doolittle</h1>"
      expect(response.status).to eq 200
      # expect(response.body).to include first_response
    end
    it "contains paragraph" do
      response = get('/albums/1')
      expected_response = "<p>
      Release year: 1989
      Artist: Pixies
    </p>"
    expect(response.status).to eq 200
    expect(response.body).to include('<h1>Doolittle</h1>')
    expect(response.body).to include (expected_response)
    end
  end

  context "GET /albums/2" do
    it "contains a h1 title" do
      response = get('/albums/2')
      expected_response = "<h1>Surfer Rosa</h1>"
      expect(response.status).to eq 200
      expect(response.body).to include expected_response
    end
    it "contains paragraph" do
      response = get('/albums/2')
      expected_response = "<p>
      Release year: 1988
      Artist: Pixies
    </p>"
    expect(response.status).to eq 200
    expect(response.body).to include expected_response
    end
  end

  context 'POST to /albums' do
    it 'returns 200 OK when it creates a new album' do
      response = post(
        '/albums', 
        title: 'Voyage', 
        release_year: '2022', 
        artist_id: '2'
      )
      expect(response.status).to eq(200)
      response = get '/albums'
      expect(response.body).to include("Voyage")
    end

    it 'returns 404 Not Found' do
      response = post('/album5')
      expect(response.status).to eq(404)
    end
  end

  context 'GET /artists' do
    it 'should return a list of artists' do
      response = get('artists')
      expected_response = 'Pixies, ABBA, Taylor Swift, Nina Simone'
      expect(response.status).to eq (200)
      expect(response.body).to eq expected_response
    end
  end

  context 'POST /artists' do
    it 'creates a new artist' do
      response = post('/artists', 
        name: 'Blink 182', 
        genre: 'Punk - Rock')
      expect(response.status).to eq (200)
      response = get('artists')
      expect(response.body).to include('Blink 182')
    end
  end
end