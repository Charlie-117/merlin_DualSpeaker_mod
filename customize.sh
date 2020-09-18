#!/system/bin/sh

#
# DualSpeaker MOD
#

# Patch mixer_paths.xml and placed the modified one to the original directory
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
if [ -f /system/vendor/etc/mixer_paths.xml ]; then
	mkdir -p `dirname $MODPATH/system/vendor/etc/mixer_paths.xml`
	cp -af $MODPATH/mixer_paths.xml $MODPATH/system/vendor/etc/
	chmod 0755 $MODPATH/system/vendor/etc/mixer_paths.xml
fi

# Clean up
sleep 1
ui_print "- Cleaning up"
clean_up() {
	rm -rf $MODPATH/mixer_paths.xml
	rm -rf $MODPATH/LICENSE
}
clean_up

# Executing...
# Done
sleep 1
