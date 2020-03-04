const mongoose = require('mongoose')
const dbHandler = require('./db-handler')
const Ride = require('../routes/ride.route')
const user_controller = require('../controllers/ride.controller')
const request = require('supertest')
const app = require('../app')

/**
* Connect to a new in-memory database before running any tests.
*/
beforeAll(async () => await dbHandler.connect())

var token = null;
/**
* Create a user to get the JWT token to store in the global variable token
* to use in all the ride requests
*/
beforeAll(async() => {
    const pretendUserCreate = {
      name: 'Ray',
      email: 'hi@gmail.com',
      password: 'testtest'
    }
    const response = await request(app).post('/users/signup').send(pretendUserCreate)

    token = response.body.token
})

/**
* Clear the database after each test to keep each test isolated
*/
afterEach(async () => await dbHandler.clearDatabase());

/**
* Remove and close the db and server.
*/
afterAll(async () => await dbHandler.closeDatabase())

/**
* User test suite.
*/
describe('Ride CRUD Tests', () => {
    const fakeRide = {
            id: "asdfsdkjwer139824",
            driverName: "Test User",
            origin: "Naperville",
            destination: "Champaign",
            latitudeOrigin: 41.7508391,
            longitudeOrigin: -88.1535352,
            latitudeDestination: 40.1164204,
            longitudeDestination: -88.2433829,
            rideStartTime: 1583424000,
            price: 25,
            space: 4,
            riders: [],
    }

    async function createRide() {
        const response = await request(app).
            post('/rides/create').
            set("Authorization", "Bearer " + token).
            send(fakeRide)

        return response
    }

    it('Can be created', async () => {
        const response = await createRide()

        expect(response.statusCode).toBe(200)
        expect(response.body.id).toBe(fakeRide.id)
        expect(response.body["_id"]).toEqual(expect.any(String))
    })

    it('Can get details', async () => {
        const response = await createRide()

        const detailsResponse = await request(app).
            get('/rides/' + response.body["_id"]).
            set("Authorization", "Bearer " + token)

        expect(detailsResponse.statusCode).toBe(200)
        expect(detailsResponse.body.id).toBe(fakeRide.id)
        expect(detailsResponse.body.origin).toBe(fakeRide.origin)
        expect(detailsResponse.body.latitudeDestination).toBe(fakeRide.latitudeDestination)
        expect(detailsResponse.body.rideStartTime).toBe(fakeRide.rideStartTime)
    })

    it('Can be updated', async () => {
        const response = await createRide()

        updateBody = {
            rideStartTime: 1591234556,
            space: 2
        }

        const updateResponse = await request(app).
            put('/rides/' + response.body["_id"] + "/update").
            set("Authorization", "Bearer " + token).
            send(updateBody)

        expect(updateResponse.statusCode).toBe(200)
        expect(updateResponse.text).toBe('Ride Info udpated.')

        // Check if details were updated by getting details of the ride
        const detailsResponse = await request(app).
            get('/rides/' + response.body["_id"]).
            set("Authorization", "Bearer " + token)

        expect(detailsResponse.statusCode).toBe(200)
        expect(detailsResponse.body.rideStartTime).toBe(updateBody.rideStartTime)
        expect(detailsResponse.body.space).toBe(updateBody.space)

        // Check other key fields are the same
        expect(detailsResponse.body.id).toBe(fakeRide.id)
        expect(detailsResponse.body.origin).toBe(fakeRide.origin)
        expect(detailsResponse.body.latitudeDestination).toBe(fakeRide.latitudeDestination)
    })

    it('Can get all', async() => {
        const rideResponse1= await createRide()
        const rideResponse2 = await createRide()

        const allRidesResponse = await request(app).
            get('/rides/' + "getAll").
            set("Authorization", "Bearer " + token)

        expect(allRidesResponse.statusCode).toBe(200)
        expect(allRidesResponse.body).toEqual(expect.any(Array))

        const firstRide = allRidesResponse.body[0]
        expect(firstRide.id).toBe(fakeRide.id)
        expect(firstRide["_id"]).toEqual(expect.any(String))

        const secondRide = allRidesResponse.body[1]
        expect(secondRide.id).toBe(fakeRide.id)
        expect(secondRide["_id"]).toEqual(expect.any(String))

        // Expect them to have different Mongo DB ID's
        expect(firstRide["_id"]).not.toEqual(secondRide["_id"])
    })

    it('Can be deleted', async() => {
        const response = await createRide()

        const deleteResponse = await request(app).
            delete('/rides/' + response.body["_id"] + "/delete").
            set("Authorization", "Bearer " + token)

        expect(deleteResponse.statusCode).toBe(200)
        expect(deleteResponse.text).toBe('Deleted!')

        // Expect all rides to be empty now that the ride has been deleted .
        const allRidesResponse = await request(app).
            get('/rides/' + "getAll").
            set("Authorization", "Bearer " + token)

        expect(allRidesResponse.statusCode).toBe(200)
        expect(allRidesResponse.body).toEqual([])
    })
})