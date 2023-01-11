# Rest Routing Test
# Album Resource
## List all albums
```
Request:
GET /albums

Response (200 ok)
A list of albums

Doolittle
Surfer Rosa
Waterloo
Super Trouper
Bossanova
Lover
Folklore
I Put a Spell on You
Baltimore
Here Comes the Sun
Fodder on My Wings
Ring Ring
```
## Find specific album
Request:
GET /albums/:id

Find a specific album
Response (200 ok):
A specific albums

## Create a new album
Request
POST /albums/

with body parameters: 
      title = "OK Computer"
      release_year = "1997"
      artist_id = "5"

Response(200 ok):
No response, it just creates the album


