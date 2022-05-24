local move = {
    type = "type",
    category = "category",
    condition = "condition",
    pp = 0,
    power = 0,
    accuracy = 0
}

-- grass, water, fire etc
function move:getType()
    return self.type
end

-- Physical, Special, Status, etc
function move:getCategory()
    return self.category
end

-- What does the move do? How many targets does it hit?
function move:getCondition()
    return self.condition
end

function move:getPp()
    return self.pp
end

function move:getPower()
    return self.power
end

function move:getAccuracy()
    return self.accuracy
end

function move:new(type, category, condition, pp, power, accuracy, trivia, contest)
    local new_move = {}
    setmetatable(new_move, self)
    self.__index = self
    new_move.type = type
    new_move.category = category
    new_move.condition = condition
    new_move.pp = pp
    new_move.power = power
    new_move.accuracy = accuracy
    new_move.trivia = trivia
    new_move.contest = contest

    return new_move
end

local moves = {}

local function __add(key, val)
    moves[key] = val
end

function moves:new( name, type, category, condition, pp, power, accuracy, trivia, contest )
    -- replace spaces and dashes with underscores
    local key = tostring(name):lower():gsub("%s+", "_"):gsub("-", "_")
    if types[key] then
        error( string.format("Type already exists!\nKey: %s Name: %s", tostring(key), tostring(name) ) )
        return
    end
    __add(key,move:new(name, type, category, condition, pp, power, accuracy, trivia, contest))
end

moves:new("Pound",types.normal,category.physical,nil,35,40,100,
        {
            stadium="A Normal-type attack. Slightly stronger than Tackle. Many Pokémon know this move.",
            gsc="Pounds with forelegs or tail.",
            rse="Pounds the foe with forelegs or tail.",
            frlg="A physical attack delivered with a long tail or a foreleg, etc.",
            coloxd="Pounds the target with forelegs or tail.",
            gen4="The foe is physically pounded with a long tail or a foreleg, etc",
            gen5="The target is physically pounded with a long tail or a foreleg, etc.",
            gen6="The target is physically pounded with a long tail, a foreleg, or the like."

        },
        {

        }
)

return moves