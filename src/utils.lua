---Logs a message at the specified log level with colour coding.
---@param level number|nil The log level. 0 = Off, 1 = Errors, 2 = Warnings, 3 = Info, 4 = Debug. nil omits the level display.
function mod.LogMessage(level, ...)
	if level == 1 then
		-- Using rom.log.error would actually throw an error
		rom.log.warning("\27[31m[ERROR]\27[0m", ...)
	elseif level == 2 then
		rom.log.warning(...)
	elseif level == 3 then
		rom.log.info(...)
	elseif level == 4 then
		rom.log.debug(...)
	end
end

---Prints a message to the console at the specified log level
---@param level number|nil The verbosity level required to print the message. 0 = Off/Always printed, 1 = Errors, 2 = Warnings, 3 = Info, 4 = Debug
function mod.DebugPrint(level, ...)
	level = level or 0
	if config.loglevel >= level then
		mod.LogMessage(level, ...)
	end
end