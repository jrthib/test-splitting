const { service } = require('./index');

describe('service-1', () => {
    it('should return service name', () => {
        expect(service()).toEqual('service-1');
    });
})