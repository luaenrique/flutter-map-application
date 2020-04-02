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


//DB connection
mongoose.connect(process.env.DB_CONNECTION,   
    { useNewUrlParser: true, useUnifiedTopology: true }, () => {
})

//
app.listen(3000);