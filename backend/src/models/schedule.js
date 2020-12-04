const {Schema, model} = require('mongoose');

const scheduleSchema = new Schema({
    origin: String,
    destination: String,
    departure: String,
    arrive: String
});

module.exports = model('Schedule', scheduleSchema);