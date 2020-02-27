const User = require('../models/user.model');
const crypto = require('crypto');
const bcrypt = require('bcrypt');
const passport = require('passport');
const initializePassport = require('../passport-config');
const flash = require("express-flash");
const utilities = require('../utilities/utilities')
const stripe = require("stripe")("sk_test_Xbay8VGjIEVV4L2ygnGtq1Lt00ztVINAtz")


const PASSWORD_LENGTH = 64;
const SALT_LENGTH = 128;
const ITERATIONS = 10000;
const DIGEST = 'sha256';
const BYTE_TO_STRING_ENCODING = 'base64';



//Simple version, without validation or sanitation
exports.test = function (req, res) {
	if(!utilities.check_authorization(req)) {
		return res.status(401).end()
	}

	res.send("Test works")
};


/*
exports.user_create = function (req, res, next) {
	const hashedPassword =  await bcrypt.hash(req.body.password, 10);
				let user = new User(
					{
						email: req.body.email,
						name: req.body.name,
						password: hashedPassword
						//salt: salt_value
						//DriverIndicator: req.body.di,
						//email: req.body.email
					}
				);;*/
exports.user_create = async function (req, res, next) {
	stripe.customers.create(
		{
			email: req.body.email,
			name: req.body.name,
		},
		function(error, customer){
			if(error) {
				return next(error)
			}
			//console.log(customer)
			var salt_value = crypto.randomBytes(SALT_LENGTH)
												.toString(BYTE_TO_STRING_ENCODING);
			crypto.pbkdf2(req.body.password, salt_value, ITERATIONS, PASSWORD_LENGTH,
										DIGEST,
				function(err, password_result) {
					var starting = [];
					let user = new User(
						{
							email: req.body.email,
							name: req.body.name,
							password: password_result.toString(),
							salt: salt_value,
							stripe_customer_token: customer["id"],
							DriverIndicator: false,
							activeRides: starting
						}
					);
					user.save(function (err, saved_user) {
						//console.log(customer)
						if (err) {
							next(err)
						}

						const token = utilities.create_jwt_token(req.body.email)
						const id = saved_user["id"]
						res.send({"user_id": id, "token": token});
					});
				}
			);
		}
	)
};

exports.user_login =  function(req, res, next){
		passport.authenticate('local', function(err,user, info){
			res.send(user);
			if (err)
              return next(err);
        if(!user){
				res.send("Wrong Credentials");}
				else{
        req.logIn(user, function(err) {
                if (err)
                    return next(err);
                if (!err)
                    res.send("Logged in!");
		});
	}
	})(req, res, next);
};

exports.verify = function(req, res, next) {
	User.findOne({email: req.body.email}, function (err, user) {
		crypto.pbkdf2(req.body.password, user.salt, ITERATIONS, PASSWORD_LENGTH, DIGEST, function (err, result) {
			if(result.toString() === user.password) {
				const token = utilities.create_jwt_token(req.body.email)
				const id = user["id"]

				res.send({"user_id": id, "token": token});
			} else {
				res.status(401).end();
			}
		});
	});
};

exports.user_details = function (req, res, next) {
	if(!utilities.check_authorization(req)) {
		return res.status(401).end()
	}

	User.findById(req.params.id, function (err, user) {
		if (err) return next(err);
		res.send(user);
	});
};

exports.user_update = function (req, res, next) {
	if(!utilities.check_authorization(req)) {
		return res.status(401).end()
	}

	User.findByIdAndUpdate(req.params.id, {$set: req.body}, function (err, user) {
		if (err) return next(err);
		res.send('User Info udpated.');
	});
};

exports.user_delete = function (req, res, next) {
	if(!utilities.check_authorization(req)) {
		return res.status(401).end()
	}

	User.findByIdAndRemove(req.params.id, function (err) {
		if (err) return next(err);
		res.send('Deleted!');
	});
};

exports.user_ephemeral_key = function (req, res, next) {
	User.findById(req.params.id, async function(err, user) {
		if(err) return next(err)
		let key = await stripe.ephemeralKeys.create(
			{customer: user.stripe_customer_token},
			{apiVersion: req.query["version"]} //req.query["version"]
		)
		.catch(function(err){
			return next(err)
		});

		//console.log(key)
		res.send(key);
	})
}

exports.add_ride = function (req, res, next) {
	if(!utilities.check_authorization(req)) {
		return res.status(401).end()
	}
	User.findOneAndUpdate({_id: req.body.id}, {$push :{"activeRides": req.body.rideID}}, function(err,user){
		if (err) return next(err);
		res.send(user["activeRides"]);
	});
};

exports.get_rides = function (req, res, next) {
	if(!utilities.check_authorization(req)) {
		return res.status(401).end()
	}
	User.findOne({id: req.body.id}, function(err,user){
		if (err) return next(err);
		res.send(user["activeRides"]);
	})
}
