--[[
	HMAC implementation
	http://tools.ietf.org/html/rfc2104
	http://en.wikipedia.org/wiki/HMAC

	hmac.compute(key, message, hash_function, blocksize, [opad], [ipad]) -> HMAC string, opad, ipad

	hmac.new(hash_function, block_size) -> function(message, key) -> HMAC string

]]

local string = string
local sha2 = require 'sha2'

module(...)

--any hash function works, md5, sha256, etc.
--blocksize is that of the underlying hash function (64 for MD5 and SHA-256, 128 for SHA-384 and SHA-512)
function compute(key, message, hash, blocksize, opad, ipad)
    if #key > blocksize then
        key = hash(key) --keys longer than blocksize are shortened
    end
    key = key .. string.rep('\0', blocksize - #key) --keys shorter than blocksize are zero-padded
    opad = opad or sha2.exor(key, string.rep(string.char(0x5c), blocksize))
    ipad = ipad or sha2.exor(key, string.rep(string.char(0x36), blocksize))
	return hash(opad .. hash(ipad .. message)), opad, ipad --opad and ipad can be cached for the same key
end

function new(hash, blocksize)
	return function(message, key)
		return (compute(key, message, hash, blocksize))
	end
end

