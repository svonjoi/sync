package.path = package.path .. "/?.lua"

local opts = require("rsync.user_cfg")

settings(opts.settings)

local ssh_private_key = os.getenv("SSH_PRIVATE_KEY")
assert(ssh_private_key ~= nil, "Environment variable SSH_PRIVATE_KEY not set")

local rsync_target_host = os.getenv("RSYNC_TARGET_HOST")
assert(rsync_target_host ~= nil, "Environment variable RSYNC_TARGET_HOST not set")

for _, conf in ipairs(opts.dirs) do
	sync({
		default.rsyncssh,
		source = conf.source,
		host = rsync_target_host,
		-- excludeFrom = "/etc/lsyncd.exclude",
		exclude = conf.exclude,
		targetdir = conf.target,
		rsync = {
			archive = true,
			compress = false,
			whole_file = false,
		},
		ssh = {
			port = 22,
			identityFile = ssh_private_key,
		},
	})
end
