// adapted from https://dev.to/paulasantamaria/testing-node-js-mongoose-with-an-in-memory-database-32np
const mongoose = require('mongoose')
const dbHandler = require('./db-handler')
const User = require('../routes/user.route')
const user_controller = require('../controllers/user.controller')
const request = require('supertest')
const app = require('../app')

/**
* Connect to a new in-memory database before running any tests.
*/
beforeAll(async () => await dbHandler.connect())

/**
* Remove and close the db and server.
*/
afterAll(async () => await dbHandler.closeDatabase())

/**
* User test suite.
*/
describe('User Tests', () => {
  it('Can be created', async () => {
    const pretendUserCreate = {
      name: 'Ray',
      email: 'hi@gmail.com',
      password: 'testtest'
    }
    const response = await request(app).post('/users/signup').send(pretendUserCreate)

    expect(response.statusCode).toBe(200)
    expect(response.body.user_id).toEqual(expect.any(String))
    expect(response.body.token).toEqual(expect.any(String))
  })

  it('Can be logged in', async () => {
    const pretendUserLogin = {
      email: 'hi@gmail.com',
      password: 'testtest'
    }
    const response = await request(app).post('/users/verify').send(pretendUserLogin)

    expect(response.statusCode).toBe(200)
    expect(response.body.user_id).toEqual(expect.any(String))
    expect(response.body.token).toEqual(expect.any(String))
  })

  it('Can be rejected if wrong password', async () => {
    const pretendUserFailedLogin = {
      email: 'hi@gmail.com',
      password: 'wrongpass'
    }
    const response = await request(app).post('/users/verify').send(pretendUserFailedLogin)
    expect(response.statusCode).toBe(401)
  })

  it('Can be rejected if wrong email', async () => {
    const pretendUserWrongEmail = {
      email: 'hifake@gmail.com',
      password: 'testtest'
    }
    const response = await request(app).post('/users/verify').send(pretendUserWrongEmail)
    expect(response.statusCode).toBe(401)
  })
})
