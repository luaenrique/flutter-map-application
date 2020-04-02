const express = require('express');
const mongoose = require('mongoose');
const app = express();
const bodyParser = require('body-parser');
require('dotenv/config')

app.use(bodyParser.json());

//Routes
app.get('/', (req, res) => {
    res.send('hello world');
});


//
app.listen(3000);