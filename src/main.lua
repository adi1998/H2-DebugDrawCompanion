---@diagnostic disable: undefined-global
---@meta _
-- grabbing our dependencies,
-- these funky (---@) comments are just there
-- to help VS Code find the definitions of things

---@diagnostic disable-next-line: undefined-global
local mods = rom.mods

---@module 'LuaENVY-ENVY-auto'
mods['LuaENVY-ENVY'].auto()
-- ^ this gives us `public` and `import`, among others
--    and makes all globals we define private to this plugin.
---@diagnostic disable: lowercase-global

---@diagnostic disable-next-line: undefined-global
rom = rom
---@diagnostic disable-next-line: undefined-global
_PLUGIN = _PLUGIN

-- get definitions for the game's globals
---@module 'game'
game = rom.game
---@module 'game-import'
import_as_fallback(game)

---@module 'SGG_Modding-SJSON'
sjson = mods['SGG_Modding-SJSON']
---@module 'SGG_Modding-ModUtil'
modutil = mods['SGG_Modding-ModUtil']

---@module 'SGG_Modding-ReLoad'
reload = mods['SGG_Modding-ReLoad']

---@module 'SGG_Modding-Chalk'
chalk = mods["SGG_Modding-Chalk"]

config = chalk.auto "config.lua"

local function on_ready()
    mod = modutil.mod.Mod.Register(_PLUGIN.guid)

    import "utils.lua"
    import "projectile_fix.lua"
    import "targets.lua"
end

local function on_reload()
    import "imgui.lua"
    mod.setBind()
end

local loader = reload.auto_single()

modutil.once_loaded.game(function()
    loader.load(on_ready, on_reload)
end)