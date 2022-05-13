const express = require('express');
const router = express.Router();
const {Question, validateQuestion} = require('../models/question_model');
const {User} = require('../models/user_model');
const authenticate = require('../middleware/authentication');

const _ = require('lodash');
const config = require('config');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

router.get('/', async(req, res) =>{
    const questions = await Question.find();
    var users = [];
    for (let i= 0; i< questions.length; i++){
        const user = await User.findById(questions[i].user);
        users.push(user);
    }
    res.send(users);
});

router.post('/addQuestion',authenticate, async (req, res)=>{
    const {error} = validateQuestion(req.body);
    if (error) return res.status(400).send(error.details[0].message);

    const user = await User.findById(req.user._id).select('-password');

    const question = new Question({
        user: user._id,
        title: req.body.title,
        description: req.body.description,
    });

    const result = await question.save();

    res.send(result);
        
});

// router.post('/login', async (req, res)=>{
//     const {error} = validateUserLogging(req.body);
//     if (error) return res.status(400).send(error.details[0].message);

//     let user = await User.findOne({email: req.body.email});
//     if (!user) return res.status(400).send("Invalid email or password");

//     const validPassword = await bcrypt.compare(req.body.password, user.password);
//     if (!validPassword) return res.status(400).send('Invalid email or password.');
    
//     const token = user.generateAuthToken();
//     res.send(token);
    
// });




module.exports = router;
