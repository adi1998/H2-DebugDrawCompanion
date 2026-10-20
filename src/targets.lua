local devObstaclesFileName = rom.path.combine(rom.paths.Content(), "Game\\Obstacles\\1_DevObstacles.sjson")

sjson.hook(devObstaclesFileName, function (data)
    -- local obstacle_map = {
    --     InvisibleTarget = true
    -- }
    for _, value in ipairs(data.Obstacles) do
        -- if obstacle_map[value.Name] and (not value.Thing or (value.Thing.Invisible ~= false)) then
        --     obstacle_map[value.Name] = true
        --     print(value.Name)
        -- end
        if value.Name == "InvisibleTarget" then
            value.Thing.Invisible = false
            value.Thing.TriggerOnSpawn = true
        end
    end
end)

-- baked in due to lua state reset
local target_obstacles = game.ToLookup({
    -- Game\Obstacles\1_DevObstacles.sjson
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
    -- Game\Obstacles\DrownedChambers.sjson
    "ScyllaFanInvisibleTarget",
    -- Game\Obstacles\AmbienceGenerators.sjson
    "BaseAmbienceGenerator",
    "FireAmbienceGenerator",
    "OlympusAmbienceGenerator",
    "OceanusAmbienceGenerator",
    "TyphonAmbienceGenerator",
    "TartarusAmbienceGenerator",
    "EphyraAmbienceGenerator",
    "IceAmbienceGenerator",
    "TickTockAmbienceGenerator",
    "FieldsAmbienceGenerator",
    "FireAmbienceGeneratorTORCH",
    "WhirlpoolAmbienceGenerator",
    "MetalLanternSqueakAmbienceGenerator",
    "FishNetAmbienceGenerator",
    "FlagFlapAmbienceGenerator",
    "MetalSqueakAmbienceGenerator",
    "WaterRainDripsLocalAmbience",
    "FliesBuzzingAmbienceGenerator",
    "CreakingTreeAmbienceGenerator",
    "CreakingTreeAmbienceGenerator2",
    "FogRiverAmbienceGenerator",
    "CookingAmbienceGenerator",
    "SpiderAmbienceGenerator",
    "InsectScamperingAmbienceGenerator",
    "FrogsAmbienceGenerator",
    "LavaAmbienceGeneratorBubbles",
    "LavaAmbienceGeneratorBubbles2",
    "TyphonBreathingLoop1AmbienceGenerator",
    "TyphonBreathingLoop2AmbienceGenerator",
    "TyphonBreathingLoop3AmbienceGenerator",
    "TyphonBreathingLoop4AmbienceGenerator",
    "NastyAmbienceGenerator1",
    "NastyAmbienceGenerator2",
    "LavaAmbienceGeneratorRumbles",
    "SteamAmbienceGenerator",
    "SandAmbienceGenerator",
    "ChainAmbienceGenerator",
    "HauntedWindAmbienceGenerator",
    "LeavesRustleAmbienceGenerator",
    "StatueAmbienceGenerator",
    "ChimesAmbienceGenerator",
    "WaterfallAmbienceGenerator",
    "FountainAmbienceGenerator",
    "DeathAreaFountainAmbienceGenerator",
    "DeathAreaBloodPoolAmbienceGenerator",
    "LoungeKitchenAmbienceGenerator",
    "LoungeAmbienceGenerator",
    "SlowMovingBloodRiverAmbience",
    "WindAmbienceGenerator",
    "CreepyHandAmbienceGenerator",
    "OceanusBubblesAmbienceGenerator",
    "OceanWavesAmbienceGenerator",
    "WindyFieldAmbienceGeneratorBigRadius",
    -- Game\Obstacles\Gameplay.sjson
    "FamiliarKit",
})

function mod.SetTargetVisibility(visibility)
    for obstacle, _ in pairs(target_obstacles) do
        local ids = game.GetIdsByType({ Name = obstacle })
        game.SetAlpha({ Fraction = (visibility and 1) or 0, Ids = ids})
    end
end

game.OnSpawn{
    function (triggerArgs)
        if triggerArgs.name and target_obstacles[triggerArgs.name] then
            game.SetAlpha({ Fraction = (config.target_visibility and 1) or 0, Id = triggerArgs.triggeredById})
        end
    end
}