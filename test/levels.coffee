should = require('chai').should()
Levels = require('../lib/levels')
describe '#The levels should exists', ()->
  it 'Should not be null', ()->
    levels = new Levels()
    levels.should.have.property('fatal').that.deep.equals({name: "Fatal", value:0})
    levels.should.have.property('error').that.deep.equals({name: "Error", value:1})
    levels.should.have.property('warn').that.deep.equals({name: "Warn", value:2})
    levels.should.have.property('info').that.deep.equals({name: "Info", value:3})
    levels.should.have.property('debug').that.deep.equals({name: "Debug", value:4})
    levels.should.have.property('trace').that.deep.equals({name: "Trace", value:5})
