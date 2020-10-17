#!/system/bin/sh

#
# DualSpeaker MOD
#

# Print some info
sleep 1
print_modname()
ui_print " "
ui_print "    *******************************************"
ui_print "    *       Dual Speaker Mod for merlin       *"
ui_print "    *******************************************"
ui_print "    *          by Lukest85 , Charlie          *"
ui_print "    *******************************************"
ui_print "    *          ! Use with CAUTION !           *"
ui_print "    *******************************************"
ui_print " "

# Run Device checks
DEVICE=`getprop ro.product.system.device`

ui_print "Running Device Checks"

if [ $DEVICE != "merlin" ]; then
  abort " => Device '"$DEVICE"' is not supported"
fi

ui_print " - Your Device '"$DEVICE"' is supported"
ui_print " "
# Run API checks
ui_print "Running API checks"
if [ $API -ge 28 ]; then
ui_print "  - Reached minimum API requirements"
sleep 1
ui_print "  - Continuing installation"
break
else
ui_print "   - Does not reached minimum API requirements"
sleep 1
	abort 	 "   - Aborting"
fi

# Run addons
if [ "$(ls -A $MODPATH/addon/*/preinstall.sh 2>/dev/null)" ]; then
  ui_print " "; ui_print "- Running Addons -"
  for i in $MODPATH/addon/*/preinstall.sh; do
    ui_print "  Running $(echo $i | sed -r "s|$MODPATH/addon/(.*)/preinstall.sh|\1|")..."
    . $i
  done
fi

# Print some more info
ui_print " "
ui_print "There are three profiles available for this mod"
ui_print " "
ui_print "Activated"
ui_print " - Activates the earpiece as secondary speaker, no other changes"
ui_print " "
ui_print "Balanced"
ui_print " - Adds +10dB to earpiece speaker and increases its output gain by 4 times"
ui_print " and adds -20dB to main speaker"
ui_print " "
ui_print "Medium"
ui_print " - Adds +10dB to earpiece speaker and increases its output gain by 4 times"
ui_print " and adds -4dB to main speaker"
ui_print " "

sleep 1

# Activated profile
ui_print "For installing the Activated profile , press Volume Key UP"
ui_print "To install other profiles press Volume Key DOWN"

if $VKSEL; then
 if [ -f /system/vendor/etc/mixer_paths.xml ]; then
  mkdir -p `dirname $MODPATH/system/vendor/etc/mixer_paths.xml`
  cp -af $MODPATH/profiles/activated/mixer_paths.xml $MODPATH/system/vendor/etc/
  chmod 0755 $MODPATH/system/vendor/etc/mixer_paths.xml
 fi
else
 ui_print " "
 ui_print "Continuing with other Profiles selection"
 ui_print " "
 # Balanced profile
 ui_print "For installing the Balanced profile , press Volume Key UP"
 ui_print "To install other profiles press Volume Key DOWN"
 if $VKSEL; then
  if [ -f /system/vendor/etc/mixer_paths.xml ]; then
  mkdir -p `dirname $MODPATH/system/vendor/etc/mixer_paths.xml`
  cp -af $MODPATH/profiles/balanced/mixer_paths.xml $MODPATH/system/vendor/etc/
  chmod 0755 $MODPATH/system/vendor/etc/mixer_paths.xml
  fi
 else
  ui_print " "
  ui_print "Continuing with other Profiles selection"
  ui_print " "
  # Medium profile
  ui_print "For installing the Medium profile , press Volume Key UP"
  ui_print "To abort the installation press Volume Key DOWN"
  if $VKSEL; then
   if [ -f /system/vendor/etc/mixer_paths.xml ]; then
   mkdir -p `dirname $MODPATH/system/vendor/etc/mixer_paths.xml`
   cp -af $MODPATH/profiles/medium/mixer_paths.xml $MODPATH/system/vendor/etc/
   chmod 0755 $MODPATH/system/vendor/etc/mixer_paths.xml
   fi
  else
   ui_print " "
   abort " => You didn't select any Profile , Aborting"
  fi
 fi
fi

# Clean up
sleep 1
ui_print " "
ui_print " - Cleaning up"
clean_up() {
	rm -rf $MODPATH/profiles
	rm -rf $MODPATH/LICENSE
}
clean_up

# Done
sleep 1
