const express = require('express');
const router = express.Router();

const user_controller = require('../controllers/user.controller');


// a simple test url to check that all of our files are communicating correctly.
router.get('/test', user_controller.test);

module.exports = router;

// depreceated
// router.post('/login', user_controller.user_login);

router.post('/signup', user_controller.user_create);

router.post('/verify', user_controller.verify);

router.get('/:id', user_controller.user_details);

router.put('/:id/update', user_controller.user_update);

router.delete('/:id/delete', user_controller.user_delete);

router.get('/ephemeralKey/:id', user_controller.user_ephemeral_key);

router.post('/addRide', user_controller.add_ride);

router.get('/getRides', user_controller.get_rides);

function isLoggedIn(req, res, next) {
    if (req.isAuthenticated())
        return next();
    res.end('Not logged in');
}
