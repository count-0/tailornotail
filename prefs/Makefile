include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = tails
tails_FILES = $(wildcard *.m)
tails_INSTALL_PATH = /Library/PreferenceBundles
tails_FRAMEWORKS = UIKit
tails_LIBRARIES = colorpicker
tails_PRIVATE_FRAMEWORKS = Preferences
tails_EXTRA_FRAMEWORKS += CepheiPrefs

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/tails.plist$(ECHO_END)