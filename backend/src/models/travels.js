const {Schema, model} = require('mongoose');

const travelSchema = new Schema({
    origin: {
        name: String,
        coordinates: {
            latitude: Number,
            longitude: Number
        }
    },
    destination: {
        name: String,
        coordinates: {
            latitude: Number,
            longitude: Number
        }
    }
});

module.exports = model('Travel', travelSchema);