local random = math.random

-- generation indexed by number and name
local generators = {}

-- Gen 1
do
    -- 1 byte, increments from 0 to 255, once every 256 processor cycles
	local divider_register = 0

	-- this would likely be a good idea to call on every server tick? Maybe using the server tick as a substitute would be even better
	local function increment_divider_register()
		divider_register = divider_register + 1
	end

	-- zero or one
	local carry_bit = 0

	local add_byte = 0

	local subtract_byte = 0

	-- called once on every frame, and once whenever a random number is needed
	local function generate_random_number()
		-- cheapout and using random() for now
		divider_register = random(0,255) + divider_register % 256
		
		add_byte = ( add_byte + divider_register + carry_bit )
		carry_bit = add_byte > 255 and 1 or 0
		add_byte = add_byte % 256
		subtract_byte = ( subtract_byte - divider_register - carry_bit )
		subtract_byte = subtract_byte % 256

		return add_byte, subtract_byte
	end

	generators[1] = {
		rng = generate_random_number
	}
	generators.generation_one = generators[1]
end

do

end

for i = 1, 10 do
	print(generators[2].rng())
end

