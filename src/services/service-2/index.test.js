const { service } = require('./index');

describe('service-2', () => {
    it('should return service name', () => {
        expect(service()).toEqual('service-2');
    });
})