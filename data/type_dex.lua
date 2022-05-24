local type_dex = require("monster/type")

type_dex:new(
        "Normal",
        {
            ghost = 0,
            rock = 0.5,
            steel = 0.5
        }
)
type_dex:new(
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
type_dex:new(
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
type_dex:new(
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
type_dex:new(
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
type_dex:new(
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
type_dex:new(
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
type_dex:new(
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
type_dex:new(
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
type_dex:new(
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
type_dex:new(
        "Psychic",
        {
            fighting = 2,
            poison = 2,
            psychic = 0.5,
            dark = 0,
            steel = 0.5
        }
)
type_dex:new(
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
type_dex:new(
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
type_dex:new(
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
type_dex:new(
        "Dragon",
        {
            dragon = 2,
            steel = 0.5,
            fairy = 0
        }
)
type_dex:new(
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
type_dex:new(
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
type_dex:new(
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

return type_dex
