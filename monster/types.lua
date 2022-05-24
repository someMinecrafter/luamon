local __DEFAULTS_LOADED = false
local __TYPE = type
local types
local type = {
    name = "placeholder",
    offensive = {},
    defensive = {},
    trait = {},
}

-- defensive last because only custom types will want to specify it
function type:new( name, offensive, trait, defensive )
    local new_type = {}
    setmetatable(new_type, self)
    self.__index = self
    new_type.name = tostring(name) or "No Type Name Provided"
    new_type.offensive = __TYPE(offensive) == "table" and offensive or {}
    new_type.defensive = __TYPE(defensive) == "table" and defensive or {}
    new_type.status = __TYPE(trait) == "table" and trait or {}
    return new_type
end

function type:get_offensive(type)
    if not type then
        return self.offensive
    else
        return self.offensive[type]
    end
end
function type:get_defensive(type)
    if not type then
        return self.defensive
    else
        return self.defensive[type]
    end
end
function type:set_offensive(type, val)
    self.offensive[type] = val
end
function type:set_defensive(type, val)
    self.defensive[type] = val
end

types = {}

local function __add(key, val)
    types[key] = val
end
-- unlikely to be useful but why not
local function __remove(key)
    types[key] = nil
end

function types:get_type(type)
    return types[type]
end

-- I will broadly assume that any trait will be "immune" if not marked otherwise when writing code
local function __update_type_strengths() -- updates all values on new type addition
    for type_attacking, values in pairs(types) do
        if __TYPE(values) == "table" and values.get_offensive then
            for type_defending, strength in pairs(values:get_offensive()) do
                if types:get_type(type_defending) then
                    types:get_type(type_defending):set_defensive(type_attacking,strength)
                end
            end
        end
    end
    for type_defending, values in pairs(types) do
        if __TYPE(values) == "table" and values.get_offensive then
            for type_attacking, strength in pairs(values:get_defensive()) do
                if types:get_type(type_attacking) then
                    types:get_type(type_attacking):set_offensive(type_defending,strength)
                end
            end
        end
    end
end

function types:new( name, offensive, trait, defensive )
    local key = tostring(name):lower()
    if types[key] then
        error( string.format("Type already exists!\nKey: %s Name: %s", tostring(key), tostring(name) ) )
        return
    end
    __add(key,type:new(name, offensive, trait, defensive))
    __update_type_strengths("dragon")
end


types:new(
        "Normal",
        {
            ghost = 0,
            rock = 0.5,
            steel = 0.5
        }
)
types:new(
        "Fire",
        {
            fire = 0.5,
            water = 0.5,
            grass = 2,
            ice = 2,
            bug = 2,
            rock = 0.5,
            dragon = 0.5,
            steel = 2
        },
        {
            burned={type = "status"}
        }
)
types:new(
        "Water",
        {
            fire = 2,
            water = 0.5,
            grass = 0.5,
            ground = 2,
            rock = 2,
            dragon = 0.5
        }
)
types:new(
        "Grass",
        {
            fire = 0.5,
            water = 2,
            grass = 0.5,
            poison = 0.5,
            ground = 2,
            flying = 0.5,
            bug = 0.5,
            rock = 2,
            dragon = 0.5,
            steel = 0.5
        },
        {
            spore={type = "move"},
            leech_seed={type = "move"},
            powder={type = "move_category"},
            effect_spore={type = "ability"}
        }
)
types:new(
        "Electric",
        {
            water = 2,
            grass = 0.5,
            electric = 0.5,
            ground = 0,
            flying = 2,
            dragon = 0.5
        },
        {
            paralyzed={type = "status"}
        }
)
types:new(
        "Ice",
        {
            fire = 0.5,
            water = 0.5,
            grass = 2,
            ice = 0.5,
            ground = 2,
            flying = 2,
            dragon = 2,
            steel = 0.5
        },
        {
            frozen={type = "status"},
            sheer_cold={type = "move"},
            hail={type = "weather"}
        }
)
types:new(
        "Fighting",
        {
            normal = 2,
            ice = 2,
            poison = 0.5,
            flying = 0.5,
            psychic = 0.5,
            bug = 0.5,
            rock = 2,
            ghost = 0,
            dark = 2,
            steel = 2,
            fairy = 0.5
        }
)
types:new(
        "Poison",
        {
            grass = 2,
            poison = 0.5,
            ground = 0.5,
            rock = 0.5,
            ghost = 0.5,
            steel = 0,
            fairy = 2
        },
        {
            poisoned={type = "status"},
            toxic_spikes={type = "hazard", effect = "remove", trigger = "switched_in"},
            toxic={type = "move", effect = "can_not_miss", trigger = "attacking"}
        }
)
types:new(
        "Ground",
        {
            fire = 2,
            grass = 0.5,
            electric = 2,
            poison = 2,
            flying = 0,
            bug = 0.5,
            rock = 2,
            steel = 2
        },
        {
            paralyzed={type = "status", trigger = "defending", condition = "electric"},
            sandstorm={type = "weather"}
        }
)
types:new(
        "Flying",
        {
            grass = 2,
            electric = 0.5,
            fighting = 2,
            bug = 2,
            rock = 0.5,
            steel = 0.5
        },
        {
            terrain={type = "terrain"},
            hazard={type = "hazard", condition = "grounded"},
            roost={type = "move", effect = "remove_type_flying", condition = "flying"} -- this feels specific enough it should be only in the move itself and not here.
        }
)
types:new(
        "Psychic",
        {
            fighting = 2,
            poison = 2,
            psychic = 0.5,
            dark = 0,
            steel = 0.5
        }
)
types:new(
        "Bug",
        {
            fire = 0.5,
            grass = 2,
            fighting = 0.5,
            poison = 0.5,
            flying = 0.5,
            psychic = 2,
            ghost = 0.5,
            dark = 2,
            steel = 0.5,
            fairy = 0.5
        }
)
types:new(
        "Rock",
        {
            fire = 2,
            ice = 2,
            fighting = 0.5,
            ground = 0.5,
            flying = 2,
            bug = 2,
            steel = 0.5
        },
        {
            sandstorm={type = "weather", effect = "stat_boost_special_defense_50"}
        }
)
types:new(
        "Ghost",
        {
            normal = 0,
            psychic = 2,
            ghost = 2,
            dark = 0.5
        },
        {
            escape={type="move_category"}
        }
)
types:new(
        "Dragon",
        {
            dragon = 2,
            steel = 0.5,
            fairy = 0
        }
)
types:new(
        "Dark",
        {
            fighting = 0.5,
            psychic = 2,
            ghost = 2,
            dark = 0.5,
            fairy = 0.5
        },
        {
            prankster={type="ability", effect="immune"}
        }
)
types:new(
        "Steel",
        {
            fire = 0.5,
            water = 0.5,
            electric = 0.5,
            ice = 2,
            rock = 2,
            steel = 0.5,
            fairy = 2
        },
        {
            sandstorm={type="weather"},
            poisoned={type="status"}
        }
)
types:new(
        "Fairy",
        {
            fire = 0.5,
            fighting = 2,
            poison = 0.5,
            dragon = 2,
            dark = 2,
            steel = 0.5
        }
)

return types