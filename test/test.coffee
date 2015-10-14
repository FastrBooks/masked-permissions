describe 'Masked permissions', ->
   mp = require '../'

   it 'should match the exact permission', ->
      mp.hasPermission 'test', ['test']
      .should.be.true

      mp.hasPermission 'test2', ['test']
      .should.be.false

      mp.hasPermission 'test3', ['test', 'test3', 'test2']
      .should.be.true

      mp.hasPermission 'test1', ['test', 'test3', 'test2']
      .should.be.false

   it 'should match the permission containing special symbols', ->
      mp.hasPermission 'test', ['te[s]+t']
      .should.be.false

      mp.hasPermission 'te[s]+t', ['te[s]+t']
      .should.be.true

   it 'should match wildcard permission', ->
       mp.hasPermission 'something::secret', ['something::*']
       .should.be.true

       mp.hasPermission 'something::secret', ['something::']
       .should.be.false

       mp.hasPermission 'something::secret', ['something::.*']
       .should.be.false

       mp.hasPermission 'something::secret', ['something::dd*', 'something::*aa', 'something::*::test']
       .should.be.false

       mp.hasPermission 'something::secret', ['something::dd*', 'something::*', 'something::*t']
       .should.be.true

       mp.hasPermission 'something::very::secret', ['something::*::secret']
       .should.be.true

       mp.hasPermission 'something::somewhat::secret', ['something::*::secret']
       .should.be.true

       mp.hasPermission 'something::somewhat::hidden', ['something::*::secret']
       .should.be.false

       mp.hasPermission 'something::somewhat::hidden', ['something::*']
       .should.be.false

       mp.hasPermission 'something::somewhat::hidden', ['something::**']
       .should.be.true

       mp.hasPermission 'something::somewhat', ['something::**']
       .should.be.true

       mp.hasPermission 'something::somew:hat::secret', ['something::*::secret']
       .should.be.true

       mp.hasPermission 'something::somew::hat::secret', ['something::*::secret']
       .should.be.false
