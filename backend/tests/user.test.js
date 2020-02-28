// adapted from https://dev.to/paulasantamaria/testing-node-js-mongoose-with-an-in-memory-database-32np

const mongoose = require('mongoose')
const dbHandler = require('./db-handler')
const User = require('../routes/user.route')
const user_controller = require('../controllers/user.controller')

/**
* Connect to a new in-memory database before running any tests.
*/
beforeAll(async () => await dbHandler.connect())

/**
* Clear all test data after every test.
*/
afterEach(async () => await dbHandler.clearDatabase())

/**
* Remove and close the db and server.
*/
afterAll(async () => await dbHandler.closeDatabase())

/**
* Matcher to verify sign up and sign in responses
*/
expect.extend({
  async tokenJWTResponse(received) {
    const externalValue = await getExternalValueFromRemoteSource();
    const pass = received % externalValue == 0;
    if (pass) {
      return {
        message: () =>
        `expected ${received} not to be divisible by ${externalValue}`,
        pass: true,
      };
    } else {
      return {
        message: () =>
        `expected ${received} to be divisible by ${externalValue}`,
        pass: false,
      };
    }
  },
});


/**
* User test suite.
*/
describe('user_create', () => {
  /**
  * Verify that user can be created
  */
  it('can be created correctly', async () => {

    expect(async () => await user_controller.user_create(pretendUser))
    .tokenJWTResponse()
    // .not
    // .toThrow();
  });
});

/**
* Complete product example.
*/
const pretendUser = {
  body: {
    name: 'Ray',
    email: 'hi@gmail.com',
    password: 'test'
  }
}
