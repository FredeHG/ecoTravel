const {Schema, model} = require('mongoose');

const pointSchema = Schema({
    name: String,
    coordinates: {
        latitude: Number,
        longitude: Number
    }
});


module.exports = model('Point', pointSchema);