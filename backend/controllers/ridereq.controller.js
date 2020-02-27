const RideReq = require('../models/ridereq.model');
const utilities = require('../utilities/utilities')

exports.ridereq_create = function (req, res, next) {
    if(!utilities.check_authorization(req)) {
        return res.status(401).end()
    }

    let ridereq = new RideReq(
        {
            rideID: req.body.rideID,
            riderID: req.body.riderID,
            driverID: req.body.driverID,
            driverName: req.body.driverName
            //DriverIndicator: req.body.di,
            //email: req.body.email
        }
    );
ridereq.save(function (err) {
      if (err) {
          next(err)
            }
        res.send('Ride Request Created successfully')
      })
    };

exports.ridereq_details = function (req, res, next) {
    if(!utilities.check_authorization(req)) {
        return res.status(401).end()
    }

    RideReq.findById(req.params.id, function (err, ridereq) {
        if (err) return next(err);
            res.send(ridereq);
        })
  };

exports.ridereq_update = function (req, res, next) {
    if(!utilities.check_authorization(req)) {
        return res.status(401).end()
    }

   RideReq.findByIdAndUpdate(req.params.id, {$set: req.body}, function (err, ridereq) {
      if (err) return next(err);
        res.send('Ride Request Info udpated.');
        });
    };

exports.ridereq_delete = function (req, res, next) {
    if(!utilities.check_authorization(req)) {
        return res.status(401).end()
    }
    
        RideReq.findByIdAndRemove(req.params.id, function (err) {
            if (err) return next(err);
            res.send('Deleted!');
        })
    };
