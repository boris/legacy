## Motivation
I save a lot of liks _to read later_, and I don't have a place to organize them
all. Also, I wanted to practise my ruby skills adding some MongoDB (or any other
DB) to it.

## Usage
```bash
./app.rb help
```

## MongoDB Version
If you want to store the links in a mongo db collection, add the following lines
to `add` method:

```ruby
Mongo::Logger.logger.level = Logger::WARN
client = Mongo::Client.new('mongodb://127.0.0.1:32770/test')
collection = client[:links]
doc = {url: "#{url}", name: "#{name}"}
collection.insert_one(doc)
```

And the following to the `show` method:

```ruby
Mongo::Logger.logger.level = Logger::WARN
client = Mongo::Client.new('mongodb://127.0.0.1:32770/test')
collection = client[:links]
n = 0
rows = []
collection.find.each do |doc|
```

### How I run this?
I run it using mongodb in docker:
```
docker run -dP mongo
mongo --port <port>
db.createCollection("links")
```
Keep in mind that you need to backup (or persist) the data in your DB.

## To do
- [X] fix DB connection
- [ ] add an option to select "local" storage or DB storage
- [ ] add feature to search (`collections.find`)
- [ ] add feature to update (`collection.update_one`)
