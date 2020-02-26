const jwt = require('jsonwebtoken')

const jwtKey = 'fdslkjsZsfdSDFLKJdfskljDSFKLJvcx3439sfdljkfasdffsdflkjeiwoeruSDFKJWERQWEdsflkjqpeioreoiwuvxnmeqiouewfkdsfjdsklfoewireuroewrdxcjn'
const jwtExpirySeconds = 3000

exports.check_authorization = function(req) {
	let token = req.header("Authorization")
	if (token === undefined || token.startsWith("Bearer ") === false) {
		return false
	}

	// Extract actual token
	token = token.substring(7)

	try {
		let payload = jwt.verify(token, jwtKey)
	} catch (e) {
		return false
	}

	return true
};

exports.create_jwt_token = function(email_addr) {
	return jwt.sign({ email: email_addr }, jwtKey, {
	    		algorithm: 'HS256',
	  		})
};


