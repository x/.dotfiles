# init the database
initdb /usr/local/var/postgres

# set it up to lauch on startup
launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
cp /usr/local/Cellar/postgresql/9.1.4/homebrew.mxcl.postgresql.plist ~/Library/LaunchAgents/
launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist

# start the db
pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start
