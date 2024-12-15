# sync

# srcs

- <https://lsyncd.github.io/lsyncd/manual/config/layer1>

# cfg

- define LUA_PATH in the service unit as absolute path to the project root

service descriptors for debug the setup

```bash
journalctl -f -b unit <service_name> | lnav
```

[Install]
WantedBy=multi-user.target

