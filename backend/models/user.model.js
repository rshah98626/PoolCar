const mongoose = require('mongoose');
const Schema = mongoose.Schema;

let UserSchema = new Schema({
    email: {type: String, required: true, max: 100},
    name: {type: String, required: true},
    password: {type: String, required: true},
    salt: {type: String, required: true},
    stripe_customer_token: {type: String, required: true},
    DriverIndicator: {type:Boolean, required: true},
    activeRides: {type:Array, required: false},
    //Email: {type:String, required: true},

});

// Export the model
module.exports = mongoose.model('user', UserSchema);
