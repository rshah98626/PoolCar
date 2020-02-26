const Ride = require('../models/ride.model');
const utilities = require('../utilities/utilities')
const User = require('../models/user.model');
const stripe = require("stripe")("sk_test_Xbay8VGjIEVV4L2ygnGtq1Lt00ztVINAtz")
const randomstring = require("randomstring");


//Simple version, without validation or sanitation
exports.test = function (req, res) {
	res.send('Greetings from the Ride Controller\'s test method!');
};

exports.ride_create = function (req, res, next) {
	if(!utilities.check_authorization(req)) {
		return res.status(401).end()
	}

	let ride = new Ride(
		{
			id: req.body.id,
			driverName: req.body.driverName,
			origin: req.body.origin,
			destination: req.body.destination,
			latitudeOrigin: req.body.latitudeOrigin,
			longitudeOrigin: req.body.longitudeOrigin,
			latitudeDestination: req.body.latitudeDestination,
			longitudeDestination: req.body.longitudeDestination,
			rideStartTime: req.body.rideStartTime,
			price: req.body.price,
			space: req.body.space,
			riders: req.body.riders,
			rideTime: req.body.rideTime
			//DriverIndicator: req.body.di,
			//email: req.body.email
		}
	);

	ride.save(function (err, saved_ride) {
		if (err) {
			next(err)
		}
		res.send(saved_ride);
	});
};

exports.ride_details = function (req, res, next) {
	if(!utilities.check_authorization(req)) {
		return res.status(401).end()
	}

	Ride.findById(req.params.id, function (err, ride) {
		if (err) return next(err);
		res.send(ride);
	});
};

exports.ride_update = function (req, res, next) {
	if(!utilities.check_authorization(req)) {
		return res.status(401).end()
	}

	Ride.findByIdAndUpdate(req.params.id, {$set: req.body}, function (err, ride) {
		if (err) return next(err);
		res.send('Ride Info udpated.');
	});
};

exports.ride_delete = function (req, res, next) {
	if(!utilities.check_authorization(req)) {
		return res.status(401).end()
	}

	Ride.findByIdAndRemove(req.params.id, function (err) {
		if (err) return next(err);
		res.send('Deleted!');
	});
};

exports.ride_getAll = function (req, res, next) {
	if(!utilities.check_authorization(req)) {
		return res.status(401).end()
	}

	Ride.find({}, function(err, rides) {
		res.send(rides);
	});
};

exports.ride_get = function (req, res, next) {
	if(!utilities.check_authorization(req)) {
		return res.status(401).end()
	}

	destinationLocationInput = req.query.destinationLocation
	filterByDestinationLocation = !(destinationLocationInput.length === 0)

	originLocationInput = req.query.originLocation
	filterByOriginLocation = !(originLocationInput.length === 0)

	startDateInput = parseFloat(req.query.startDate)

	filterObject = {}
	filterObject["rideStartTime"] = {$gte: startDateInput, $lt: (startDateInput+86400)}

	if(filterByDestinationLocation) {
		filterObject["destination"] = destinationLocationInput
	}

	if(filterByOriginLocation) {
		filterObject["origin"] = originLocationInput
	}


	Ride.find(filterObject, function(err, rides) {
		res.send(rides);
	});
}

exports.ride_purchase = async function (req, res, next) {
	Ride.findOne({"id": req.params.id}, async function(err, ride){
		const price = ride["price"] * 100
		User.findById(req.body.user_id, async function(err, user){
			// get user's customer token and create payment intent
			const customer_token = user["stripe_customer_token"]
			const paymentIntent = await stripe.paymentIntents.create({
				amount: price,
				currency: 'usd',
				customer: customer_token,
				//payment_method_types: ['card'],
    			capture_method: 'manual',
			})
			.catch(function(err){
				return next(err)
			})

			// TODO can only create payment intent if ride will happen within a week
			// Have to save payment intent id with ride request
			// test capturing of funds from card
			// const paymentCapture = await stripe.paymentIntents.capture(paymentIntent.id)
			// .catch(err => {
			// 	return next(err)
			// })

			const clientSecret = paymentIntent.client_secret
			res.send({"secret": clientSecret})
		})
		.catch(function(err){
			return next(err)
		})
	})
	.catch(function(err){
		return next(err)
	})
}

//Endpoint that is responsible for creating passwords to indicate that a ride
//has been completed
exports.password_create = function (req, res, next) {
	if(!utilities.check_authorization(req)){
		return res.status(401).end()
	}
	//the starting and ending passwords
	var passStart = randomstring.generate(5);
	var passEnd = randomstring.generate(5);
	//later consider limiting passwords generated to one
	Ride.findOneAndUpdate({id: req.body.id}, {pass_Start: passStart,pass_End: passEnd}, function (err, ride) {
		if (err) return next(err);
		res.send({passStart,passEnd});
	});

};
