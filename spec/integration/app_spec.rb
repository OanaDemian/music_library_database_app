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
    it "should return the list of albums" do
      response = get('/albums')
      expected_response = "Doolittle, Surfer Rosa, Waterloo, Super Trouper, Bossanova, Lover, Folklore, I Put a Spell on You, Baltimore, Here Comes the Sun, Fodder on My Wings, Ring Ring"
      expect(response.status).to eq (200)
      expect(response.body).to eq (expected_response)
    end
  end

  context 'POST to /album' do
    it 'returns 200 OK when it creates a new album' do
      # Assuming the post with id 1 exists.
      response = post(
        '/album', 
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