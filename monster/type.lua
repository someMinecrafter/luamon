local __DEFAULTS_LOADED = false
local __TYPE = type
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

local types = {}

function types:__add(key, val)
    self[key] = val
end
-- unlikely to be useful but why not
function types:__remove(key)
    self[key] = nil
end

function types:get_type(type)
    return self[type]
end

-- I will broadly assume that any trait will be "immune" if not marked otherwise when writing code
function types:__update_type_strengths() -- updates all values on new type addition
    for type_attacking, values in pairs(self) do
        if __TYPE(values) == "table" and values.get_offensive then
            for type_defending, strength in pairs(values:get_offensive()) do
                if self:get_type(type_defending) then
                    self:get_type(type_defending):set_defensive(type_attacking,strength)
                end
            end
        end
    end
    for type_defending, values in pairs(self) do
        if __TYPE(values) == "table" and values.get_offensive then
            for type_attacking, strength in pairs(values:get_defensive()) do
                if self:get_type(type_attacking) then
                    self:get_type(type_attacking):set_offensive(type_defending,strength)
                end
            end
        end
    end
end

function types:new( name, offensive, trait, defensive )
    local new_types = {}
    setmetatable(new_types, self)
    self.__index = self
    local key = tostring(name):lower()
    if new_types[key] then
        error( string.format("Type already exists!\nKey: %s Name: %s", tostring(key), tostring(name) ) )
        return
    end
    new_types:__add(key,type:new(name, offensive, trait, defensive))
    new_types:__update_type_strengths()

    return new_types
end

return types