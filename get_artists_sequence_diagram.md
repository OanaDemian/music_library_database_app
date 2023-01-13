```mermaid
sequenceDiagram
sequenceDiagram
participant C as Client
participant A as Sinatra Application(app.rb)
participant R as ArtistRepository class
participant V as View
participant D as Database music_library
Note left of C: Flow of time <br />⬇ <br /> ⬇ <br /> ⬇ 

C->>A: The client sends a HTTP request to the web server over the Internet: GET /artists
  HTTP Request method is GET, address is http://localhost:9292, path is /artists, body parameters are name and genre. Forwards request GET /artists to the Sinatra Applicating (app.rb) 
A->>R: handles request, #get /artists/id which calls ArtistRepository #find(id)
R->>D: #find(id) runs SQL query 
D->>R: returns set result, an Artist object to ArtistRepository class
R->>A: returns an Artist object to the program (app.rb)
A->>V: get #artists/id returns erb(:artist) which calls artists.erb
V->>A: shows attributes name and genre of the Artist object
A->>C: the route block sends HTTP response to the client containing the data  response status 200 ok, response body Artist name, Artist genre
```




