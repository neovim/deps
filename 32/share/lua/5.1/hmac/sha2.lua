--[[
	HMAC-SHA2 implementation

	hmac.sha256(message, key) -> HMAC-SHA256 binary string
	hmac.sha384(message, key) -> HMAC-SHA384 binary string
	hmac.sha512(message, key) -> HMAC-SHA512 binary string

]]

local hmac = require 'hmac'
local sha2 = require 'sha2'

hmac.sha256 = hmac.new(sha2.sha256, 64)
hmac.sha384 = hmac.new(sha2.sha384, 128)
hmac.sha512 = hmac.new(sha2.sha512, 128)

