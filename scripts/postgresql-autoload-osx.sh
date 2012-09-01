launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
cp /usr/local/Cellar/postgresql/9.1.4/homebrew.mxcl.postgresql.plist ~/Library/LaunchAgents/
launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
