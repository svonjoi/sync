return {
	-- logfile = "/tmp/lsyncd/lsyncd.log",
	-- statusFile = "/tmp/lsyncd/lsyncd.status",
	statusInterval = 20,
	nodaemon = true,
	-- maxProcesses = 2,
	-- keep running at startup although one or more targets failed due to not being reachable
	insist = true,
}
