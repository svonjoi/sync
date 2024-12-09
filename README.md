# sync

# srcs

- <https://lsyncd.github.io/lsyncd/manual/config/layer1>

# cfg

- define LUA_PATH in the service unit as absolute path to the project root

service descriptors for debug the setup

# systemd service

[Unit]
Description=lsyncd file sync server1 --> server2
After=network.target

[Service]
Type=simple
PIDFile=/run/lsyncd.pid
ExecStart=/usr/bin/lsyncd /home/svonjoi/dev/repo/sync/rsync/user_cfg.lua
ExecReload=/bin/kill -HUP $MAINPID
Restart=always
StandardOutput=append:/tmp/lsyncdtest/stdout.log
StandardError=append:/tmp/lsyncdtest/stderr.log

Environment="LUA_PATH="
Environment="SSH_PRIVATE_KEY="
Environment="AWS_SECRET_ACCESS_KEY="
Environment="AWS_ACCESS_KEY_ID="

[Install]
WantedBy=multi-user.target

