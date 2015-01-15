#! /usr/bin/lua

require 'Test.More'

if not pcall(require, 'Coat') then
    skip_all 'no Coat'
end

plan(8)

local Meta = require 'Coat.Meta.Class'
local mp = require 'MessagePack'
local EXT_COAT = 4

mp.packers['table'] = function (buffer, obj)
    local classname = obj._CLASS
    if classname then
        local buf = {}
        mp.packers['string'](buf, classname)
        mp.packers['table'](buf, obj._VALUES)
        mp.packers['ext'](buffer, EXT_COAT, table.concat(buf))
    else
        mp.packers['_table'](buffer, obj)
    end
end

mp.build_ext = function (tag, data)
    if tag == EXT_COAT then
        local f = mp.unpacker(data)
        local _, classname = f()
        local _, values = f()
        local class = assert(Meta.class(classname))
        return class.new(values)
    end
end

class 'Point'

has.x = { is = 'ro', isa = 'number', default = 0 }
has.y = { is = 'ro', isa = 'number', default = 0 }
has.desc = { is = 'rw', isa = 'string' }

function overload:__tostring ()
    return '(' .. tostring(self.x) .. ', ' .. tostring(self.y) .. ')'
end

function method:draw ()
    return "drawing " .. self._CLASS .. tostring(self)
end

local a = Point{x = 1, y = 2}
ok( a:isa 'Point' )
is( a:draw(), "drawing Point(1, 2)" )

local b = mp.unpack(mp.pack(a))
ok( b:isa 'Point' )
is( b:draw(), "drawing Point(1, 2)" )

a.desc = string.rep('x', 2^9)
local c = mp.unpack(mp.pack(a))
ok( c:isa 'Point' )
is( #c.desc, 2^9 )

a.desc = string.rep('x', 2^17)
local d = mp.unpack(mp.pack(a))
ok( d:isa 'Point' )
is( #d.desc, 2^17 )
