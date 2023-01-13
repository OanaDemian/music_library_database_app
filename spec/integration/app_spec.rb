require "spec_helper"
require "rack/test"
require_relative '../../app'

def reset_tables
  albums_seed_sql = File.read('spec/seeds/albums_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(albums_seed_sql)

  artists_seed_sql = File.read('spec/seeds/artists_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(artists_seed_sql)
end
describe Application do
  before(:each) do
    reset_tables
  end

  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context "GET /artists/1" do
    it "contains a h1 title" do
      response = get('artists/1')
      expect(response.status).to eq 200
      expect(response.body).to include("<h1>Pixies</h1>")
    end

    it "contains a p tag" do
      response = get('/artists/1')
      expect(response.body).to include('<p>Rock</p>')
    end
  end

  context "GET /album/1" do
    it "contains a h1 title" do
      response = get('/albums/1')
      expect(response.status).to eq 200
      first_response = "<h1>Doolittle</h1>"
      expect(response.body).to include first_response
    end
    it "checks p tag" do
      response = get('/albums/1')
      expect(response.status).to eq 200
      expect(response.body).to include('<p>')
      expect(response.body).to include('</p>')
    end
    it "checks h1 tag" do
      response = get('/albums/1')
      expect(response.status).to eq 200
      expect(response.body).to include('<h1>')
      expect(response.body).to include('</h1>')
    end
    it "Checks content" do
      response = get('/albums/1')
      expect(response.status).to eq 200
      expect(response.body).to include('1989')
      expect(response.body).to include('Pixies')
      expect(response.body).to include('Doolittle')
    end
    end

  context "GET /album/2" do
    it "contains a h1 title" do
      response = get('/albums/2')
      expect(response.status).to eq 200
      first_response = "<h1>Surfer Rosa</h1>"
      expect(response.body).to include first_response
    end
    it "checks p tag" do
      response = get('/albums/2')
      expect(response.status).to eq 200
      expect(response.body).to include('<p>')
      expect(response.body).to include('</p>')
    end
    it "checks h1 tag" do
      response = get('/albums/2')
      expect(response.status).to eq 200
      expect(response.body).to include('<h1>')
      expect(response.body).to include('</h1>')
    end
    it "Checks content" do
      response = get('/albums/2')
      expect(response.status).to eq 200
      expect(response.body).to include('1988')
      expect(response.body).to include('Pixies')
      expect(response.body).to include('Surfer Rosa')
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
    it "should return a list of artists" do
      response = get('/artists')
      expect(response.status).to eq 200
      expect(response.body).to include('Pixies')
      expect(response.body).to include('Nina Simone')
      expect(response.body).to include('ABBA')
      expect(response.body).to include('Taylor Swift')
    end
    it "checks <a> tag" do
      response = get('/artists')
      expect(response.status).to eq 200
      expect(response.body).to include('<a href="/artists/')
      expect(response.body).to include('</a>')
      expect(response.body).to include('<br>')
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