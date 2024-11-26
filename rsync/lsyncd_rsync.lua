sync {
	default.rsync,
	source = "src/",
	target = "dest/",
	delay = 30,
	rsync = {
		_extra = {
			"--ignore-existing"
		}
	}
}
