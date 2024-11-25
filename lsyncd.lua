settings {
	nodaemon = true,
	maxProcesses = 1,
}

sync {
	default.rsync,
	source = "src",
	target = "dest",
	delay = 30,
	rsync = {
		backup = true,
		backup_dir = "bak",
	}
}
