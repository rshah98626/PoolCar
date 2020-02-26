const User = require('./models/user.model');
const LocalStrategy = require('passport-local').Strategy;
const bcrypt = require('bcrypt');

module.exports = function(passport) {

    passport.serializeUser(function(user, done) {
        done(null, user.id);
    });

    passport.deserializeUser(function(id, done) {
        User.findById(id, function(err, user) {
            done(err, user);
        });
    });


    passport.use(new LocalStrategy({
    usernameField: 'email'
  }, function(username, password, done) {
        User.findOne({ email: username }, async function (err, user) {
            if (err) { return done(err); }
            if (!user) {
                return done(null, false, { message: 'Incorrect username.' });
            }
            try{ if(await bcrypt.compare(password, user.password))
                  return done(null, user)
              else{
                return done(null,false,{message: "password incorrect"});
              }
            }catch(e){
                return done(e)
            }
            return done(null, user);
        });
    }
));
};
