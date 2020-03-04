const app = require('./app')

// Set up mongoose connection for debug db
const mongoose = require('mongoose');

const mongoDB = 'mongodb+srv://bhabhavish:CI3FZ4HwZP8YSsdz@poolcomdb-uhfsa.mongodb.net/CarpoolApp?retryWrites=true&w=majority';

mongoose.connect(mongoDB, {
  useNewUrlParser: true
});
mongoose.Promise = global.Promise;
const db = mongoose.connection;
db.on('error', console.error.bind(console, 'MongoDB connection error:'));

let port = process.env.PORT;
if (port == null || port == "") {
  port = 8000;
}
app.listen(port);
