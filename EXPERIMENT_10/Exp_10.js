// 1. Show all databases
show dbs

// 2. Create or switch to your database
use db_ravi_prince

// 3. Check current database
db

// 4. Create a collection (optional)
db.createCollection("movies")

// 5. Insert Operations
db.movies.insertOne({
  title: "Dream Code",
  director: "Ravi",
  year: 2010,
  rating: 8.8,
  genre: "Sci-Fi",
  features: ["Mind-bending", "Action"],
  added_by: "Ravi"
})

db.movies.insertMany([
  {
    title: "Galaxy Journey",
    director: "Prince",
    year: 2014,
    rating: 8.6,
    genre: "Sci-Fi",
    features: ["Space", "Drama"],
    added_by: "Prince"
  },
  {
    title: "Ocean World",
    director: "Prince",
    year: 2009,
    rating: 7.8,
    genre: "Adventure",
    features: ["3D", "Action"],
    added_by: "Prince"
  },
  {
    title: "The Shadow Hero",
    director: "Ravi",
    year: 2008,
    rating: 9.0,
    genre: "Action",
    features: ["Hero", "Crime"],
    added_by: "Ravi"
  }
])

// 6. Show all collections
show collections

// 7. Read Operations
db.movies.find().pretty()
db.movies.findOne()
db.movies.find({}, { title: 1, year: 1, _id: 0 })
db.movies.find({ genre: "Action" })
db.movies.find({ "details.language": "English" })

// 8. Update Operations
db.movies.updateOne(
  { title: "Ocean World" },
  { $set: { rating: 8.1, genre: "Sci-Fi Adventure" } }
)

db.movies.updateOne(
  { title: "Dream Code" },
  { $push: { features: "Thriller" } }
)

db.movies.updateOne(
  { title: "Dream Code" },
  { $pull: { features: "Action" } }
)

db.movies.updateMany(
  { director: { $in: ["Ravi", "Prince"] } },
  { $set: { language: "English" } }
)

db.movies.updateMany({}, { $unset: { added_by: "" } })
db.movies.updateMany({}, { $set: { quality: "Full HD" } })

db.movies.updateOne(
  { title: "Time Reversal" },
  { $set: { director: "Ravi", year: 2020, rating: 7.5 } },
  { upsert: true }
)

// 9. Delete Operations
db.movies.deleteOne({ title: "Ocean World" })
db.movies.deleteMany({ director: "Ravi" })
db.movies.deleteMany({})

// 10. Grouping (Aggregation)
db.movies.aggregate([
  { $group: { _id: "$director", total_movies: { $sum: 1 } } }
])

db.movies.aggregate([
  { $group: { _id: "$genre", total_movies: { $sum: 1 } } }
])

// 11. Drop collection
db.movies.drop()

// 12. Drop database
db.dropDatabase()
