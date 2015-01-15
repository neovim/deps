#! /usr/bin/lua

require 'Test.More'

local mp = require 'MessagePack'

local data = {
    '1',
    '12',
    '123',
    '1234',
    '12345',
    '123456',
    '1234567',
    '12345678',
    '123456789',
    '12345678',
    '1234567',
    '123456',
    '12345',
    '1234',
    '123',
    '12',
    '1',
}

plan(#data)

local f = io.open('data.mpac', 'w')
for i = 1, #data do
    local mpac = mp.pack(data[i])
    f:write(mpac)
end
f:close()

local ltn12 = { source = {} }
function ltn12.source.file (handle)
    if handle then
        return function ()
            local chunk = handle:read(16)
            if not chunk then
                handle:close()
            end
            return chunk
        end
    else return function ()
            return nil, "unable to open file"
        end
    end
end

f = io.open('data.mpac', 'r')
local s = ltn12.source.file(f)
local i = 1
for _, val in mp.unpacker(s) do
    is(val, data[i])
    i = i + 1
end
os.remove 'data.mpac'  -- clean up
