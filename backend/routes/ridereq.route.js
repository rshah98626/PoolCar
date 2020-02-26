const express = require('express');
const router = express.Router();

// Require the controllers WHICH WE DID NOT CREATE YET!!
const ridereq_controller = require('../controllers/ridereq.controller');


// a simple test url to check that all of our files are communicating correctly.
module.exports = router;
router.post('/create', ridereq_controller.ridereq_create);
router.get('/:id', ridereq_controller.ridereq_details);
router.put('/:id/update', ridereq_controller.ridereq_update);
router.delete('/:id/delete', ridereq_controller.ridereq_delete);
