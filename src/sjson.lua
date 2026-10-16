local projectile_files = {
    "Enemy_1Base_Projectiles.sjson",
    "Enemy_BiomeB_Projectiles.sjson",
    "Enemy_BiomeF_Projectiles.sjson",
    "Enemy_BiomeG_Projectiles.sjson",
    "Enemy_BiomeH_Projectiles.sjson",
    "Enemy_BiomeI_Projectiles.sjson",
    "Enemy_BiomeN_Projectiles.sjson",
    "Enemy_BiomeO_Projectiles.sjson",
    "Enemy_BiomeP_Projectiles.sjson",
    "Enemy_BiomeQ_Projectiles.sjson",
    "Enemy_General_Projectiles.sjson",
    "Enemy_Traps_Projectiles.sjson",
    "Familiar_Projectiles.sjson",
    "NPC_Projectiles.sjson",
    "PlayerProjectiles.sjson",
    "Projectiles.sjson"
}

for _, filename in ipairs(projectile_files) do
    sjson.hook(rom.path.combine(rom.paths.Content(), "Game\\Projectiles\\"..filename), function (data)
        for _, projectile in ipairs(data.Projectiles) do
            if projectile.Thing and (projectile.Thing.Graphic == "null") then
                rom.log.debug("Patching Thing.Graphic for", projectile.Name)
                projectile.Thing.Graphic = "Blank"
            end
            if projectile.DeathFx == "null" then
                rom.log.debug("Patching DeathFx for", projectile.Name)
                projectile.DeathFx = "Blank"
            end
            if projectile.DetonateFx == "null" then
                rom.log.debug("Patching DetonateFx for", projectile.Name)
                projectile.DetonateFx = "Blank"
            end
        end
        return data
    end)
end