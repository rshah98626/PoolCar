const express = require('express');
const bodyParser = require('body-parser');
const passport = require('passport');
const session = require('express-session');
const flash = require('connect-flash')


//http
//const http = require('http');
// Set up mongoose connection
const mongoose = require('mongoose');

const mongoDB = 'mongodb+srv://bhabhavish:CI3FZ4HwZP8YSsdz@poolcomdb-uhfsa.mongodb.net/CarpoolApp?retryWrites=true&w=majority';

mongoose.connect(mongoDB, {
  useNewUrlParser: true
});
mongoose.Promise = global.Promise;
const db = mongoose.connection;
db.on('error', console.error.bind(console, 'MongoDB connection error:'));


//initializePassport(passport);


// initialize our express app
const user = require('./routes/user.route'); // Imports routes for the users
const ride = require('./routes/ride.route'); // Imports routes for the rides
const ridereq = require('./routes/ridereq.route'); // Imports routes for the ride request
const app = express();



app.use(session({ secret: 'your secret key' , resave: false, saveUninitialized: false}));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: false}));
app.use(passport.initialize());
app.use(passport.session());
app.use(flash());

const initializePassport = require('./passport-config')(passport);


app.use('/users',user);
app.use('/rides', ride);
app.use('/ridereqs',ridereq);

let port = process.env.PORT;
if (port == null || port == "") {
  port = 8000;
}
app.listen(port);

// export app
module.exports = app
/*

const MongoClient = require('mongodb').MongoClient;
const uri = "mongodb+srv://bhabhavish:<password>@poolcomdb-uhfsa.mongodb.net/test?retryWrites=true&w=majority";
const client = new MongoClient(uri, { useNewUrlParser: true });
client.connect(err => {
  const collection = client.db("test").collection("devices");
  // perform actions on the collection object
  client.close();
});
*/
