const mongoose = require('mongoose');
const Schema = mongoose.Schema;

let RideReqSchema = new Schema({
  //need to expand this Schema
    rideID: {type:String,required: true},
    riderID: {type:String,required: true},
    driverID: {type:String,required: true},
    //idk if this is necessary - judge based on whether you need this
    driverName: {type: String, required: true, max: 100},

});

module.exports = mongoose.model('ridereq', RideReqSchema);
