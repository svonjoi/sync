settings {
	nodaemon = true,
}
sync {
	default.rsync,
	source = "src/",
	target = "./jump/",
	delay = 30,
	rsync = {
		_extra = {
			"--ignore-existing"
		}
	}
}
