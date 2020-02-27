const mongoose = require('mongoose');
const Schema = mongoose.Schema;

let RideSchema = new Schema({
  //need to expand this Schema
    id: {type:String, required: true },
    driverName: {type: String, required: true, max: 100},
    origin: {type: String, required: true},
    destination: {type: String, required: true},
    latitudeOrigin: {type: Number, required: true},
    longitudeOrigin: {type: Number, required: true},
    latitudeDestination: {type: Number, required:true},
    longitudeDestination: {type:Number, required:true},
    rideStartTime: {type:Number, required: true},
    price: {type:Number, required: true},
    space: {type:Number, required: true},
    //might need to make this required: true
    riders: {type:Array, required: false},
    pass_Start: {type: String, required: false},
    pass_End: {type: String, required: false},
});
// Export the model
module.exports = mongoose.model('ride', RideSchema);
