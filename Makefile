include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Tailornotail
Tailornotail_FILES = Tweak.xm TNTPreferencesManager.m Background.xm
Tailornotail_FRAMEWORKS = Foundation Photos
Tailornotail_PRIVATE_FRAMEWORKS = IMCore
Tailornotail_LIBRARIES = rocketbootstrap colorpicker
Tailornotail_EXTRA_FRAMEWORKS += Cephei

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += prefs
SUBPROJECTS += getwallpaper
include $(THEOS_MAKE_PATH)/aggregate.mk
