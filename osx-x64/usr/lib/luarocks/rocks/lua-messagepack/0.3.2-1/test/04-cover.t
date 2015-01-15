#! /usr/bin/lua

require 'Test.More'

plan(40)

local mp = require 'MessagePack'

mp.set_number'float'
local nan = mp.unpack(mp.pack(0/0))
type_ok( nan, 'number', "nan" )
ok( nan ~= nan )
is( mp.unpack(mp.pack(3.140625)), 3.140625, "3.140625" )
mp.set_number'double'
is( mp.unpack(mp.pack(math.pi)), math.pi, "pi" )

mp.set_integer'signed'
is( mp.unpack(mp.pack(2^5)), 2^5, "2^5" )
is( mp.unpack(mp.pack(-2^5)), -2^5, "-2^5" )
is( mp.unpack(mp.pack(2^11)), 2^11, "2^11" )
is( mp.unpack(mp.pack(-2^11)), -2^11, "-2^11" )
is( mp.unpack(mp.pack(2^21)), 2^21, "2^21" )
is( mp.unpack(mp.pack(-2^21)), -2^21, "-2^21" )
if mp.small_lua then
    skip("Small Lua (32 bits)", 2)
else
    is( mp.unpack(mp.pack(2^51)), 2^51, "2^51" )
    is( mp.unpack(mp.pack(-2^51)), -2^51, "-2^51" )
end
if mp.full64bits then
    is( mp.unpack(mp.pack(2^61)), 2^61, "2^61" )
    is( mp.unpack(mp.pack(-2^61)), -2^61, "-2^61" )
else
    skip("only 53 bits", 2)
end

mp.set_integer'unsigned'
is( mp.unpack(mp.pack(2^5)), 2^5, "2^5" )
is( mp.unpack(mp.pack(-2^5)), -2^5, "-2^5" )
is( mp.unpack(mp.pack(2^11)), 2^11, "2^11" )
is( mp.unpack(mp.pack(-2^11)), -2^11, "-2^11" )
is( mp.unpack(mp.pack(2^21)), 2^21, "2^21" )
is( mp.unpack(mp.pack(-2^21)), -2^21, "-2^21" )
if mp.small_lua then
    skip("Small Lua (32 bits)", 2)
else
    is( mp.unpack(mp.pack(2^51)), 2^51, "2^51" )
    is( mp.unpack(mp.pack(-2^51)), -2^51, "-2^51" )
end
if mp.full64bits then
    is( mp.unpack(mp.pack(2^61)), 2^61, "2^61" )
    is( mp.unpack(mp.pack(-2^61)), -2^61, "-2^61" )
else
    skip("only 53 bits", 2)
end

mp.set_string'string'
local s = string.rep('x', 2^3)
is( mp.unpack(mp.pack(s)), s, "#s 2^3" )        -- fixstr
s = string.rep('x', 2^7)
is( mp.unpack(mp.pack(s)), s, "#s 2^7" )        -- str 8
s = string.rep('x', 2^11)
is( mp.unpack(mp.pack(s)), s, "#s 2^11" )       -- str 16
s = string.rep('x', 2^19)
is( mp.unpack(mp.pack(s)), s, "#s 2^19" )       -- str 32

mp.set_string'string_compat'
s = string.rep('x', 2^3)
is( mp.unpack(mp.pack(s)), s, "#s 2^3" )        -- fixstr
s = string.rep('x', 2^11)
is( mp.unpack(mp.pack(s)), s, "#s 2^11" )       -- str 16
s = string.rep('x', 2^19)
is( mp.unpack(mp.pack(s)), s, "#s 2^19" )       -- str 32

mp.set_string'binary'
s = string.rep('x', 2^5)
is( mp.unpack(mp.pack(s)), s, "#s 2^5" )        -- bin 8
s = string.rep('x', 2^11)
is( mp.unpack(mp.pack(s)), s, "#s 2^11" )       -- bin 16
s = string.rep('x', 2^19)
is( mp.unpack(mp.pack(s)), s, "#s 2^19" )       -- bin 32

local t = { string.rep('x', 2^3):byte(1, -1) }
is_deeply( mp.unpack(mp.pack(t)), t, "#t 2^3" )
t = { string.rep('x', 2^9):byte(1, -1) }
is_deeply( mp.unpack(mp.pack(t)), t, "#t 2^9" )
while #t < 2^17 do t[#t+1] = 'x' end
is_deeply( mp.unpack(mp.pack(t)), t, "#t 2^17" )

local h = {}
for i = 1, 2^3 do h[10*i] = 'x' end
is_deeply( mp.unpack(mp.pack(h)), h, "#h 2^3" )
h = {}
for i = 1, 2^9 do h[10*i] = 'x' end
is_deeply( mp.unpack(mp.pack(h)), h, "#h 2^9" )
for i = 1, 2^17 do h[10*i] = 'x' end
is_deeply( mp.unpack(mp.pack(h)), h, "#h 2^17" )

