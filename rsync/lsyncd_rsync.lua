sync {
	default.rsync,
	source = "src/",
	target = "dest/",
	delay = 30,
	rsync = {
		backup = true,
		backup_dir = "bak",
	}
}
