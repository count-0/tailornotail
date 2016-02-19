include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Tailornotail
Tailornotail_FILES = Tweak.xm TNTPreferencesManager.m
Tailornotail_FRAMEWORKS = Foundation
Tailornotail_PRIVATE_FRAMEWORKS = IMCore
Tailornotail_LIBRARIES = colorpicker
Tailornotail_EXTRA_FRAMEWORKS += Cephei

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 MobileSMS; killall -9 Preferences;"
SUBPROJECTS += prefs
include $(THEOS_MAKE_PATH)/aggregate.mk
