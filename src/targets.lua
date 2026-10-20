local devObstaclesFileName = rom.path.combine(rom.paths.Content(), "Game\\Obstacles\\1_DevObstacles.sjson")

sjson.hook(devObstaclesFileName, function (data)
    local obstacle_map = {
        InvisibleTarget = true
    }
    for _, value in ipairs(data.Obstacles) do
        -- if obstacle_map[value.Name] and (not value.Thing or (value.Thing.Invisible ~= false)) then
        --     obstacle_map[value.Name] = true
        --     print(value.Name)
        -- end
        if value.Name == "InvisibleTarget" then
            value.Thing.Invisible = false
        end
    end
end)

-- baked in due to lua state reset
local target_obstacles = {
    "InvisibleTarget",
    "InvisibleTargetNoTimeModifier",
    "CameraPoint",
    "WeaponPoint",
    "EnemyPoint",
    "EnemyPointRanged",
    "EnemyPointMelee",
    "EnemyPointSupport",
    "DiscoveryPoint",
    "EncounterStartPoint",
    "HeroStart",
    "HeroEnd",
    "HeroExit",
    "BoatMovePoint",
    "LootPoint",
    "FamiliarPoint",
    "SecretPoint",
    "CameraIntroStart",
    "CameraIntroEnd",
    "CameraClamp",
    "VisibleTarget",
}

function mod.SetTargetVisibility(visibility)
    for index, obstacle in ipairs(target_obstacles) do
        local ids = game.GetIdsByType({ Name = obstacle })
        for key, id in pairs(ids) do
            print(obstacle, id)
            game.SetAlpha({ Fraction = (visibility and 1) or 0, Id = id})
        end
    end
end

game.OnAnyLoad{
    function ()
        mod.SetTargetVisibility(config.target_visibility)
    end
}