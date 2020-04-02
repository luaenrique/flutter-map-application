const express = require('express');
const router = express.Router();
const Place = require('../models/Places');


router.post('/register', (req, res) => {
    const place = new Place({
        latitude: req.body.latitude,
        longitude: req.body.longitude,
        name: req.body.name,
    });
    
    place.save().then(data => {
        res.json(data);
    }).catch(error => {
        res.json({ message: error });
    });
});

router.get('/list', async (req, res)=> {
    const places = await Place.find();
    return res.json(places);
})

module.exports = router;