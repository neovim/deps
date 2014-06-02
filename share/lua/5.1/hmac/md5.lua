--[[
	HMAC-MD5 implementation

	hmac.md5(message, key) -> HMAC-MD5 binary string
]]

local hmac = require 'hmac'
local md5 = require 'md5'

hmac.md5 = hmac.new(md5.sum, 64)

