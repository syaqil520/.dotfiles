# NOTE: need to run as sudo

# create launch daemons
cp ./com.qaizaa.kanata.plist /Library/LaunchDaemons/
cp ./com.qaizaa.karabiner-vhiddaemon.plist /Library/LaunchDaemons/
cp ./com.qaizaa.karabiner-vhidmanager.plist /Library/LaunchDaemons/

launchctl bootstrap system /Library/LaunchDaemons/com.qaizaa.kanata.plist
launchctl enable system/com.qaizaa.kanata.plist

launchctl start com.qaizaa.kanata

sudo launchctl bootstrap system /Library/LaunchDaemons/com.qaizaa.karabiner-vhiddaemon.plist
sudo launchctl enable system/com.qaizaa.karabiner-vhiddaemon.plist

sudo launchctl bootstrap system /Library/LaunchDaemons/com.qaizaa.karabiner-vhidmanager.plist
sudo launchctl enable system/com.qaizaa.karabiner-vhidmanager.plist

sudo launchctl start com.qaizaa.karabiner-vhiddaemon
sudo launchctl start com.qaizaa.karabiner-vhidmanager
