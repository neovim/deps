Luassert
========

[![Build Status](https://secure.travis-ci.org/Olivine-Labs/luassert.png)](http://secure.travis-ci.org/Olivine-Labs/luassert)

luassert extends Lua's built-in assertions to provide additional tests and the ability to create your own. You can modify chains of assertions with `not`.

Check out [busted](http://www.olivinelabs.com/busted#asserts) for extended examples.

```lua
assert = require("luassert")

assert.True(true)
assert.is.True(true)
assert.is_true(true)
assert.is_not.True(false)
assert.is.Not.True(false)
assert.is_not_true(false)
assert.are.equal(1, 1)
assert.has.errors(function() error("this should fail") end)
```

Extend your own:

```lua
local assert = require("luassert")
local say    = require("say") --our i18n lib, installed through luarocks, included as a luassert dependency

local function has_property(state, arguments)
  local property = arguments[1]
  local table = arguments[2]
  for key, value in pairs(table) do
    if key == property then
      return true
    end
  end
  return false
end

say:set_namespace("en")
say:set("assertion.has_property.positive", "Expected property %s in:\n%s")
say:set("assertion.has_property.negative", "Expected property %s to not be in:\n%s")
assert:register("assertion", "has_property", has_property, "assertion.has_property.positive", "assertion.has_property.negative")

assert.has_property("name", { name = "jack" })

```

##Implementation notes:

* assertion/modifiers that are Lua keywords (`true`, `false`, `nil`, `function`, and `not`) cannot be used using '.' chaining because that results in compilation errors. Instead chain using '_' (underscore) or use one or more capitals in the reserved word (see code examples above), whatever your coding style prefers
* assertions `same` and `equal` will compare all arguments provided, the other assertions will only take 1 or 2 parameters and ignore all additional arguments

##Snapshots
To be able to revert changes created by tests, inserting spies and stubs for example, luassert supports 'snapshots'. A snapshot includes the following;

1. spies and stubs
1. parameters
1. formatters

Example:
```lua
describe("Showing use of snapshots", function()
  local snapshot
  
  before_each(function()
    snapshot = assert:snapshot()
  end)
  
  after_each(function()
    snapshot:revert()
  end)
  
  it("does some test", function()
    -- spies or stubs registered here, parameters changed, or formatters added
    -- will be undone in the after_each() handler.
  end)
  
end)
```

##Parameters
To register state information 'parameters' can be used. The parameter is included in a snapshot and can hence be restored in between tests. For an example see `Configuring table depth display` below.

Example:
```lua
assert:set_parameter("my_param_name", 1)
local s = assert:snapshot()
assert:set_parameter("my_param_name", 2)
s:revert()
assert.are.equal(1, assert:get_parameter("my_param_name"))
```

##Customizing argument formatting
luassert comes preloaded with argument formatters for common Lua types, but it is easy to roll your own. Customizing them is especially useful for limiting table depth and for userdata types.

###Configuring table depth display
The default table formatter allows you to customize the levels displayed by setting the `TableFormatLevel` parameter (setting it to -1 displays all levels). 

Example:
```lua
describe("Tests different levels of table display", function()

  local testtable = {
      hello = "hola",
      world = "mundo",
      liqour = {
          "beer", "wine", "water"
        },
      fruit = {
          native = { "apple", "strawberry", "grape" },
          tropical = { "banana", "orange", "mango" },
        },
    }
    
  it("tests display of 0 levels", function()
    assert:set_parameter("TableFormatLevel", 0)
    assert.are.same(testtable, {})
  end)

  it("tests display of 2 levels", function()
    assert:set_parameter("TableFormatLevel", 2)
    assert.are.same(testtable, {})
  end)
  
end)
```

Will display the following output with the table pretty-printed to the requested depth:
```
Failure: ...ua projects\busted\formatter\spec\formatter_spec.lua @ 45
tests display of 0 levels
...ua projects\busted\formatter\spec\formatter_spec.lua:47: Expected objects to be the same. Passed in:
(table): { }
Expected:
(table): { ... more }

Failure: ...ua projects\busted\formatter\spec\formatter_spec.lua @ 50
tests display of 2 levels
...ua projects\busted\formatter\spec\formatter_spec.lua:52: Expected objects to be the same. Passed in:
(table): { }
Expected:
(table): {
  [hello] = 'hola'
  [fruit] = {
    [tropical] = { ... more }
    [native] = { ... more } }
  [liqour] = {
    [1] = 'beer'
    [2] = 'wine'
    [3] = 'water' }
  [world] = 'mundo' }
```
###Customized formatters
The formatters are functions taking a single argument that needs to be converted to a string representation. The formatter should examine the value provided, if it can format the value, it should return the formatted string, otherwise it should return `nil`.
Formatters can be added through `assert:add_formatter(formatter_func)`, and removed by calling `assert:remove_formatter(formatter_func)`.

Example using the included binary string formatter:
```lua
local binstring = require("luassert.formatters.binarystring")

describe("Tests using a binary string formatter", function()
    
  setup(function()
    assert:add_formatter(binstring)
  end)

  teardown(function()
    assert:remove_formatter(binstring)
  end)
  
  it("tests a string comparison with binary formatting", function()
    local s1, s2 = "", ""
    for n = 65,88 do
      s1 = s1 .. string.char(n)
      s2 = string.char(n) .. s2
    end
    assert.are.same(s1, s2)
    
  end)
     
end)
```

Because this formatter formats string values, and is added last, it will take precedence over the regular string formatter. The results will be:
```
Failure: ...ua projects\busted\formatter\spec\formatter_spec.lua @ 13
tests a string comparison with binary formatting
...ua projects\busted\formatter\spec\formatter_spec.lua:19: Expected objects to be the same. Passed in:
Binary string length; 24 bytes
58 57 56 55 54 53 52 51   50 4f 4e 4d 4c 4b 4a 49  XWVUTSRQ PONMLKJI
48 47 46 45 44 43 42 41                            HGFEDCBA

Expected:
Binary string length; 24 bytes
41 42 43 44 45 46 47 48   49 4a 4b 4c 4d 4e 4f 50  ABCDEFGH IJKLMNOP
51 52 53 54 55 56 57 58                            QRSTUVWX
```
