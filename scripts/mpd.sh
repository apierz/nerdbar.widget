RESULTX="$(/usr/local/bin/mpc; echo x)"
RESULT="${RESULTX%x}"

 echo "$(echo "$RESULT" | grep - | awk -F"-" '{print $1}')@$(echo "$RESULT" | grep - | awk -F"-" '{print $2}')@$(echo "$RESULT" | grep / | awk -F" " '{print $3}' | awk -F"/" '{print $1}')@$(echo "$RESULT" | grep / | awk -F" " '{print $3}' | awk -F"/" '{print $2}')@$(echo "$RESULT" | grep '\[' | awk -F" " '{print $1}')@$(sh ~/.kwm/scripts/torrent_script)"
