settings {
	nodaemon = true,
	-- maxProcesses = 1,
}

local rclone = {}
rclone = {
	delay = 30,
	maxProcesses = 1,
	action = function(inlet)
		local config = inlet.getConfig()
		local bkdir = config.rclone.bkroot..os.date("%Y-%m-%dT%X")
		local function run_with_events(evs, cmd)
			local paths = evs.getPaths()
			log( "Normal", ("doin' %s for files in %s:\n\n"):format(cmd, config.rclone.prefix), table.concat( paths, '\n' ) )
			spawn(evs, 'rclone',
				'<', table.concat( paths, '\n' ),
				"--config", config.rclone.config_file,
				'--track-renames',
				cmd,
				'--include-from=-', "--backup-dir", bkdir,
				config.source,
				config.target
			)
		end
		local evs = inlet.getEvents()
		run_with_events(evs, "sync")
		-- local deleted = inlet.getEvents(function(ev) return ev.etype == "Delete" end)
		-- run_with_events(deleted, "delete")
		-- while true do
		-- 	local movesrc, movedst = inlet.getEvent()
		-- 	if movesrc == nil or movedst == nil then
		-- 		break
		-- 	end
		-- 	if not movesrc.etype == "Move" then
		-- 		goto CONTINUE
		-- 	end
		-- 	spawn(movesrc, "rclone", "move", "--backup-dir", bkdir, movesrc.targetPath, movedst.targetPath)
		-- 	::CONTINUE::
		-- end
	end,
	onMove = true,
	init = function(event)
		local config = event.config
		-- local event = inlet.createBlanketEvent()
		spawn(event, "rclone",
			"--config", config.rclone.config_file,
			'sync',
			config.source,
			config.target
		)
	end,
}
rclone.checkgauge = {
	default.checkgauge,
	rclone = {
		config_file = true,
		bkroot = true,
		prefix = true
	}
}
rclone.prepare = function(config, level)
	default.prepare(config, level+6)
	if not config.rclone.config_file then
		error('need rclone.config_file', level)
	end
	if not config.rclone.bkroot then
		error('need backup root rclone.bkroot', level)
	end
	if string.sub( config.rclone.bkroot, -1 ) ~= '/' then
		config.rclone.bkroot = config.rclone.bkroot .. "/"
	end
end

sync {
	rclone,
	source = "./jump/",
	target = "dump:dump/test50",
	rclone = {
		config_file = "./rclone/rclone.conf",
		bkroot = "dump:dump/backups50"
	},
	-- delay = 1,
}
