
require 'luarocks.require'
require 'sha2'
require 'lfs'

print(sha2._VERSION)

sha = {
	SHA256 = sha2.sha256,
	SHA384 = sha2.sha384,
	SHA512 = sha2.sha512,
}

shahex = {
	SHA256 = sha2.sha256hex,
	SHA384 = sha2.sha384hex,
	SHA512 = sha2.sha512hex,
}

local function bintohex(s)
	return (s:gsub('(.)', function(c)
		return string.format('%02x', string.byte(c))
	end))
end

for file in lfs.dir('testvectors') do
	local name, ext = file:match('^(.-)%.(.*)$')
	if ext == 'dat' then
		local s
		do
			local f = assert(io.open('testvectors/'..file, 'rb'))
			s = f:read('*a')
			f:close()
		end

		local hashes = {}
		do
			local f = assert(io.open('testvectors/'..name..'.info'))
			do
				local name, hash
				for line in f:lines() do
					if line:find'^SHA' then
						name = line:match'^(SHA.?.?.?)'
						hash = ''
					elseif hash then
						if #line == 0 then
							hashes[name] = hash
							hash = nil
						elseif hash then
							hash = hash .. line:match'^%s*(.-)%s*$'
						end
					end
				end
			end
			f:close()
		end

		for k,v in pairs(hashes) do
			local h = bintohex(sha[k](s))
			print(file, k, #s, h == v and 'ok' or h .. ' ~= ' .. v)
			local h = shahex[k](s)
			print(file, k..'x', #s, h == v and 'ok' or h .. ' ~= ' .. v)
		end
	end
end

