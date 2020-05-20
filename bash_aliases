if [[ "$(hostname)" == "DQ-x1c" ]]; then {
    # shortcuts for directories
    alias hku='cd /media/dexq/mSD-xStorage-NTFS/HKU'
    alias ntfs='cd /media/dexq/mSD-xStorage-NTFS'
    alias dq='cd /media/dexq/DQ-II/DQII/'
    alias hkuv='vim /media/dexq/mSD-xStorage-NTFS/HKU/courses.dqn -c "cd /media/dexq/mSD-xStorage-NTFS/HKU"'

    # often used commands for fixing common issues
    alias re='xinput set-prop "TPPS/2 Elan TrackPoint" "libinput Accel Speed" -0.7 && xinput list-props "TPPS/2 Elan TrackPoint"' # Lower the sensitivity of laptop's TrackPoint
    alias network='sudo service network-manager restart'

    # running programs
    alias java64='/usr/java/jre1.8.0_181/bin/java -d64 -jar'
    alias Tor='cd ~/Tor/tor-browser_en-US/ && ./start-tor-browser.desktop && cd -'
    alias ATLauncher='java64 ~/Launch/ATLauncher3.3.4.2/ATLauncher.jar &'

    # Save a lot of typing for common commands
    alias v='nvim'
    alias vr='nvim -R' # Neovim read-only mode
    alias vdiff='nvim -d'
};
fi

alias g='git'

# Overwrite existing commands for better defaults
alias mv='echo "Use /bin/mv -i!"'
alias rm='echo "Use the full path i.e. /bin/rm!"'

# vi: ft=sh
