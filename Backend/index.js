const mongoose = require('mongoose');
const express = require('express');
const app = express();
const users = require('./routes/user_route');
const questions = require('./routes/question_route');
const cors = require('cors');
const bodyParser = require('body-parser');



mongoose.connect('mongodb://localhost/mydb')
    .then(()=> console.log('Connected'))
    .catch(err => console.log(err));

app.use(cors());
app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());

app.use('/api/users', users);
app.use('/api/questions', questions);


const port = process.env.PORT || 3000;

app.listen(port, ()=> console.log(`Listening to port: ${port}`));