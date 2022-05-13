const express = require('express');
const router = express.Router();
const {User, validateUserRegister, validateUserLogging} = require('../models/user_model');
const _ = require('lodash');
const config = require('config');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const authenticate = require('../middleware/authentication');


router.get('/', (req, res)=>{
    res.send('Hello world');
});
router.post('/register', async (req, res)=>{
    const {error} = validateUserRegister(req.body);
    if (error) return res.status(400).send(error.details[0].message);

    let user = await User.findOne({email: req.body.email});
    if (user) {
        var message = {
            message: "User already registered."
        }
        return res.status(400).send(message);
    };

    user = new User(_.pick(req.body, ['name', 'email', 'password']));
   
    const salt = await bcrypt.genSalt(10);
    user.password = await bcrypt.hash(user.password, salt);
    await user.save();
    
    const token = user.generateAuthToken();
    res.header('x-auth-token', token).send(_.pick(user, ['_id', 'name', 'email']));
    
});

router.post('/login', async (req, res)=>{
    const {error} = validateUserLogging(req.body);
    if (error) return res.status(400).send(error.details[0].message);

    let user = await User.findOne({email: req.body.email});
    if (!user){
        var message = {
            message: "Invalid email or password"
        }
        return res.status(400).send(message);
    } 

    const validPassword = await bcrypt.compare(req.body.password, user.password);
    if (!validPassword) {
        var message = {
            message: "Invalid email or password"
        }
        return res.status(400).send(message);
    } 
    const tokenAuth = {
        token: user.generateAuthToken()
    };
    res.send(tokenAuth);

});

router.get('/profile', authenticate, async(req, res)=>{
    const user = await User.findById(req.user._id).select('-_id name email password');
    res.send(user);
});

router.put('/editProfile',authenticate, async(req, res)=>{

    const {error} = validateUserRegister(req.body);
    if (error) return res.status(400).send(error.details[0].message);

    let user = await User.findOne({email: req.body.email});

    if (user && user._id != req.user._id){
        var message = {
            message: "Another user already registered with the given email"
        }
        return res.status(400).send(message);
    } 


    user = await User.findByIdAndUpdate(req.user._id,
        {
            name: req.body.name,
            email: req.body.email,
            password: req.body.password
        }
        , { new: true }
    );

    if (!user) return res.status(404).send('The user with the given ID was not found.');

    res.send(user);

    


});

module.exports = router;
