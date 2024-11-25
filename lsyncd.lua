settings {
	nodaemon = true,
	maxProcesses = 1,
}

local rclone = {}
rclone = {
	delay = 30,
	maxProcesses = 1,
	action = function(inlet)
		local elist = inlet.getEvents(function(ev) return ev.etype == "Create" end)
		local config = inlet.getConfig()
		local paths = elist.getPaths()
		log( "Normal", "syncing new files:\n\n", table.concat( paths, '\n' ) )
		spawn(elist, 'rclone',
			'<', table.concat( paths, '\n' ),
			"--config=" .. config.rclone.config_file,
			-- '--from0',
			"copy",
			'--include-from=-',
			'--exclude=*',
			config.source,
			config.target
		)
	end,
	init = function(event)
		local config = event.config
		-- local event = inlet.createBlanketEvent()
		spawn(event, "rclone", 'copy', config.source, config.target)
	end,
}
rclone.checkgauge = {
	default.checkgauge,
	rclone = {
		config_file = true
	}
}
rclone.prepare = function(config, level)
	default.prepare(config, level+6)
	if not config.rclone.config_file then
		error('need rclone.config_file', level)
	end
end


-- sync {
-- 	default.rsync,
-- 	source = "src/",
-- 	target = "dest/",
-- 	delay = 30,
-- 	rsync = {
-- 		backup = true,
-- 		backup_dir = "bak",
-- 	}
-- }
sync {
	rclone,
	source = "src",
	target = "dest",
	rclone = {
		config_file = "./rclone.conf",
	},
	delay = 30,
}
