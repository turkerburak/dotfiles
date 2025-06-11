sensors 2>/dev/null | grep 'Package id 0:' | awk '{gsub("\\+|°C", "", $4); print $4}'
