const { something } = require('./utils');

describe('utils', () => {
    it('should return service name', () => {
        expect(something()).toEqual(true);
    });
})