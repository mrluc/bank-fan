
moduleKeywords = ['extended', 'included']

class Module
  @extend: (obj) ->
    for key, value of obj when key not in moduleKeywords
      @[key] = value

    obj.extended?.apply(@)
    this

  @include: (obj) ->
    for key, value of obj when key not in moduleKeywords
      # Assign properties to the prototype
      @::[key] = value

    obj.included?.apply(@)
    this
exports.Module = Module

exports.ModuleTests = ->

  Ham =
    describe: ->
      "#{ @attributes.join ', ' } ham."
  Tasty =
    attributes: ["tasty"]

  class TastyHam extends Module
    @include Tasty
    @include Ham

  th = new TastyHam

  console.log th.describe()