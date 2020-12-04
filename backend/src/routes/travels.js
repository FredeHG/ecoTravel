const {Router, json} = require('express');
const router = Router();

const Travel = require('../models/travels');
const Points = require('../models/points');
const Schedule = require('../models/schedule');

var estacionEzeiza = {name: "Estacion Ezeiza", coordinates: {latitude: -34.85460767970535, longitude: -58.5227744469394}};
var utnLugano = {name: "UTN Lugano", coordinates: {latitude: -34.65988508053708, longitude: -58.46830165054172}};
var utnMedrano = {name: "UTN Medrano", coordinates: {latitude: -34.59852777876844, longitude: -58.42025184128433}};
var obelisco = {name: "obelisco", coordinates: {latitude: -34.60521127746405, longitude: -58.381242413429696}};
var aeropuertoEzeiza = {name: "Aeropuerto Ezeiza", coordinates: {latitude: -34.81304462362043, longitude: -58.543118375225546}};

function travel(origen, destino) {
    return {
        origin: origen,
        destination: destino
    };
}

router.get('/api/travels', async (req, res) => {
    const travels = await Travel.find();
    res.json({travels});
});

router.get('/api/points', async (req, res) => {
    const points = await Points.find();
    res.json({points});
});

router.get('/api/schedule', async (req, res) => {
    const schedule = await Schedule.find();
    res.json({schedule});
});

/*
router.get('/api/points/create', async (req, res) => {
    await Points.create(estacionEzeiza);
    await Points.create(utnLugano);
    await Points.create(utnMedrano);
    await Points.create(obelisco);
    await Points.create(aeropuertoEzeiza);
    res.json({message: 'Points created'});
});

router.get('/api/travels/create', async (req, res) => {
    await Travel.create(
        travel(origen = estacionEzeiza, destino = utnLugano)
    );
    await Travel.create(
        travel(origen = estacionEzeiza, destino = utnMedrano)
    );
    await Travel.create(
        travel(origen = utnLugano, destino = utnMedrano)
    );
    await Travel.create(
        travel(origen = utnLugano, destino = obelisco)
    );
    await Travel.create(
        travel(origen = utnLugano, destino = estacionEzeiza)
    );
    await Travel.create(
        travel(origen = utnMedrano, destino = utnLugano)
    );
    await Travel.create(
        travel(origen = utnMedrano, destino = aeropuertoEzeiza)
    );
    await Travel.create(
        travel(origen = obelisco, destino = utnMedrano)
    );
    await Travel.create(
        travel(origen = obelisco, destino = aeropuertoEzeiza)
    );
    await Travel.create(
        travel(origen = obelisco, destino = estacionEzeiza)
    );
    res.json({message: 'Travels created'});
});

router.get('/api/delete/travels', async (req, res) => {
    await Travel.remove({});
    res.json({message: 'Travels removed'});
});

router.get('/api/schedule/create', async (req, res) => {
    await Schedule.create({origin: 'Estacion Ezeiza', destination: 'UTN Lugano', departure: '7:20:00AM', arrive: '8:10:00AM'});
    await Schedule.create({origin: 'UTN Lugano', destination: 'Obelisco', departure: '8:10:00AM', arrive: '8:50:00AM'});
    await Schedule.create({origin: 'Obelisco', destination: 'UTN Medrano', departure: '8:55:00AM', arrive: '9:20:00AM'});
    await Schedule.create({origin: 'UTN Medrano', destination: 'Aeropuerto', departure: '9:20:00AM', arrive: '10:00:00AM'});
    await Schedule.create({origin: 'Aeropuerto', destination: 'Obelisco', departure: '10:10:00AM', arrive: '10:45:00AM'});
    await Schedule.create({origin: 'Obelisco', destination: 'Estacion Ezeiza', departure: '10:50:00AM', arrive: '11:40:00AM'});
    await Schedule.create({origin: 'Estacion Ezeiza', destination: 'UTN Lugano', departure: '12:00:00PM', arrive: '12:25:00PM'});
    await Schedule.create({origin: 'UTN Lugano', destination: 'UTN Medrano', departure: '12:30:00PM', arrive: '12:55:00PM'});
    await Schedule.create({origin: 'UTN Medrano', destination: 'UTN Lugano', departure: '1:00:00PM', arrive: '1:25:00PM'});
    await Schedule.create({origin: 'UTN Lugano', destination: 'Estacion Ezeiza', departure: '1:30:00PM', arrive: '1:55:00PM'});
    await Schedule.create({origin: 'Estacion Ezeiza', destination: 'UTN Medrano', departure: '4:30:00PM', arrive: '5:20:00PM'});
    await Schedule.create({origin: 'UTN Medrano', destination: 'UTN Lugano', departure: '5:25:00PM', arrive: '5:50:00PM'});
    await Schedule.create({origin: 'UTN Lugano', destination: 'Estacion Ezeiza', departure: '6:10:00PM', arrive: '7:00:00PM'});
    await Schedule.create({origin: 'Estacion Ezeiza', destination: 'Aeropuerto', departure: '7:05:00PM', arrive: '7:45:00PM'});
    await Schedule.create({origin: 'Aeropuerto', destination: 'Obelisco', departure: '7:45:00PM', arrive: '8:55:00PM'});
    await Schedule.create({origin: 'Obelisco', destination: 'Aeropuerto', departure: '9:05:00PM', arrive: '9:40:00PM'});
    await Schedule.create({origin: 'Aeropuerto', destination: 'Obelisco', departure: '9:50:00PM', arrive: '10:15:00PM'});
    await Schedule.create({origin: 'Obelisco', destination: 'UTN Medrano', departure: '10:20:00PM', arrive: '10:35:00PM'});
    await Schedule.create({origin: 'UTN Medrano', destination: 'UTN Lugano', departure: '10:35:00PM', arrive: '11:00:00PM'});
    await Schedule.create({origin: 'UTN Lugano', destination: 'Estacion Ezeiza', departure: '11:10:00PM', arrive: '11:35:00PM'});

    res.json({message: 'Schedule created'});
});
*/

module.exports = router;