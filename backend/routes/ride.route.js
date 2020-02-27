const express = require('express');
const router = express.Router();

// Require the controllers WHICH WE DID NOT CREATE YET!!
const ride_controller = require('../controllers/ride.controller');


// a simple test url to check that all of our files are communicating correctly.
router.get('/test', ride_controller.test);
module.exports = router;
router.post('/create', ride_controller.ride_create);
router.get('/getAll',ride_controller.ride_getAll);
router.get('/get',ride_controller.ride_get);
router.get('/:id', ride_controller.ride_details);
router.put('/:id/update', ride_controller.ride_update);
router.delete('/:id/delete', ride_controller.ride_delete);
router.post('/purchase/:id', ride_controller.ride_purchase);
router.post('/passcode', ride_controller.password_create);
router.post('/passcodeGet', ride_controller.password_get);
router.post('/passcodeMatch', ride_controller.password_check);
//router.post('/getPass', ride_controller.get_pass);
