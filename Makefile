include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Tailornotail
Tailornotail_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 MobileSMS"
SUBPROJECTS += prefs
include $(THEOS_MAKE_PATH)/aggregate.mk
